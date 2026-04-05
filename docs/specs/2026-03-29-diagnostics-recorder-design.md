# Diagnostics Recorder Design

Date: 2026-03-29
Status: Draft

## Goal

Add a local diagnostics utility to MacStats that can:

- record short-lived network and disk health samples
- detect intermittent failures and degradations
- summarize them as durable incidents with timestamps and evidence
- help the user answer "what failed, when, and what else changed around that time?"

## Problem

MacStats already detects live network and disk conditions, but it treats them as transient UI data and notifications. That works for "what is happening right now," but it does not answer:

- Did the internet drop three times in the last hour?
- Did latency and jitter degrade before the drop?
- Did the Wi-Fi network, IP, or interface change around the failure?
- Did disk health or free space cross a threshold before the system became unstable?

## Scope

V1 scope is host-local diagnostics only:

- the current Mac
- the selected network interface
- the configured connectivity target
- mounted local disks that MacStats already reads

V1 does not attempt to monitor arbitrary LAN devices, routers, or upstream services beyond the configured reachability target. Supporting other devices would require explicit remote probes or user-configured targets.

## Constraints

- MacStats is a native Swift app inside an existing `.xcodeproj` codebase.
- Current Net and Disk modules already produce the required live signals.
- Current persistence is not enough for user-facing diagnostics history.
- Storage must be local-first, lightweight, and bounded by retention rules.
- The feature should work without any external service.
- Sampling must not materially increase energy impact.

## Existing Signals

MacStats already exposes the core inputs needed for a recorder:

- Net usage, interface state, local/public IP, Wi-Fi details, and reachability
- Connectivity status, latency, and jitter against a configured host
- Disk free space, utilization, activity, and NVMe SMART data
- Existing notification thresholds and debounce logic for state changes

## Chosen Approach

Use a two-layer local diagnostics model:

1. A rolling sample buffer for recent raw measurements.
2. A durable incident log derived from detector rules.

This gives enough context to investigate intermittent failures without turning MacStats into a full telemetry platform.

## Why Not Reuse The Current DB Directly

The existing LLDB-backed store is suitable for:

- last-known reader values
- limited internal history when a reader enables timestamped writes

It is not a good fit for diagnostics because it does not provide:

- queryable incidents
- retention by data class
- filtering by severity or subsystem
- efficient timeline views or export

Diagnostics should use a dedicated SQLite store under Application Support.

## Storage Design

Proposed file:

- `~/Library/Application Support/Stats/diagnostics.sqlite`

Tables:

- `network_samples`
- `disk_samples`
- `incidents`
- `incident_evidence`

Retention:

- network samples: 24 hours
- disk samples: 7 days
- incidents: 90 days

Compaction:

- prune on startup
- prune once every few hours while the app is active

## Data Model

### Network Sample

- timestamp
- interface BSD name
- interface up/down
- internet reachable
- connectivity mode and target
- latency ms
- jitter ms
- local IP
- public IP
- SSID
- RSSI
- noise
- upload bytes/s
- download bytes/s

### Disk Sample

- timestamp
- disk UUID
- disk name
- mounted present/absent
- free bytes
- total bytes
- utilization
- read bytes/s
- write bytes/s
- SMART temperature
- SMART life
- SMART power cycles
- SMART power-on hours

### Incident

- id
- type
- subsystem
- severity
- started_at
- ended_at
- status
- title
- summary
- subject key

`subject key` is the thing affected by the incident, such as `network:en0` or `disk:uuid`.

### Incident Evidence

- incident id
- timestamp
- key
- value

Evidence stores the short facts used to explain the incident, such as prior SSID, new IP, average latency, peak jitter, SMART life change, or free-space drop.

## Detection Model

Each detector is a small state machine:

- `idle`
- `pending`
- `open`
- `resolved`

Rules should avoid firing on one noisy sample. The existing Net notification debounce logic already shows the right pattern: require consecutive failures or threshold breaches before opening an incident.

## Initial Detectors

### Network

- `internet_down`: connectivity target fails while the app is sampling
- `network_flap`: repeated up/down transitions within a short window
- `high_latency`: rolling average latency exceeds threshold for N samples
- `high_jitter`: rolling average jitter exceeds threshold for N samples
- `interface_changed`: selected interface changes
- `local_ip_changed`: local IP changes and remains changed after debounce
- `public_ip_changed`: public IP changes and remains changed after debounce
- `wifi_changed`: SSID changes
- `wifi_quality_degraded`: RSSI/noise crosses a poor-quality threshold for N samples

### Disk

- `disk_low_space`: utilization exceeds configured threshold
- `disk_space_dropping_fast`: free space falls by more than X in Y minutes
- `smart_temp_high`: SMART temperature exceeds threshold for N samples
- `smart_life_drop`: SMART life declines relative to the last durable sample
- `disk_missing`: a previously present disk disappears unexpectedly

## Correlation Rules

V1 should keep correlation simple and descriptive, not predictive.

Examples:

- If `internet_down` starts within 60 seconds of `wifi_changed`, attach that as evidence.
- If `internet_down` starts while RSSI is poor, attach the RSSI/noise window.
- If `disk_missing` starts after SMART temperature spikes, attach the preceding disk samples.

This should remain post-facto correlation, not a separate alerting engine.

## Collection Pipeline

### Network

Feed the diagnostics engine from existing callbacks in the Net module:

- usage callback for interface, IP, Wi-Fi, and bandwidth signals
- connectivity callback for internet status, latency, and jitter

The engine should merge these into a single in-memory network snapshot before committing a sample.

### Disk

Feed the diagnostics engine from existing Disk callbacks:

- capacity callback for free space, utilization, and SMART data
- activity callback for read/write rates

The engine should track one active state per disk UUID.

## UI

V1 UI should be app-level, not a new menu bar module.

Recommended UI:

- a new `Diagnostics` screen under the main app views
- a timeline list of incidents
- an incident details pane with summary and evidence
- a compact health summary for the last 24 hours
- export as JSON or plain text report

Why not a full module in V1:

- incidents are low-frequency, not continuous telemetry
- they are easier to review in a dedicated screen than a tiny popup
- this avoids cluttering the menu bar with another real-time view

## Settings

Add a small diagnostics settings section:

- enable diagnostics recording
- network sample interval
- disk sample interval
- retention length
- thresholds for latency, jitter, and SMART temperature
- export and clear history actions

Default state:

- enabled for incidents
- conservative sample intervals
- bounded retention

## Candidate Integration Points

Likely new files:

- `Kit/Diagnostics/DiagnosticsEngine.swift`
- `Kit/Diagnostics/DiagnosticsStore.swift`
- `Kit/Diagnostics/Incident.swift`
- `Kit/Diagnostics/Detectors/NetworkDetector.swift`
- `Kit/Diagnostics/Detectors/DiskDetector.swift`

Likely modified files:

- `Modules/Net/main.swift`
- `Modules/Disk/main.swift`
- `Stats/Views/AppSettings.swift`
- `Stats/Views/Dashboard.swift` or a new `Stats/Views/Diagnostics.swift`

## Rollout Plan

### Phase 1

- add SQLite-backed diagnostics store
- add network samples
- implement `internet_down`, `network_flap`, `high_latency`, `high_jitter`, `wifi_changed`, and IP change incidents
- add export

### Phase 2

- add disk samples
- implement `disk_low_space`, `disk_missing`, `smart_temp_high`, and `smart_life_drop`
- add incident detail UI

### Phase 3

- add simple cross-signal correlation
- add user-tunable thresholds
- add richer summaries such as "3 drops in the last 24 hours"

## Acceptance Criteria

The feature is done when:

- MacStats can retain local network and disk diagnostics history across app restarts.
- A short network outage is recorded as one incident with start time, end time, duration, and supporting evidence.
- A sustained latency or jitter problem is recorded without generating duplicate incidents every sample.
- Disk low-space and SMART threshold problems are recorded as incidents.
- The user can view recent incidents and export them from the app.
- Storage remains bounded by retention rules and does not grow unbounded.

## Open Questions

- Should diagnostics be always on, or explicitly opt-in?
- Should incidents appear in the menu bar popup, or only in the main app window?
- Should V1 support user-defined reachability targets beyond the current connectivity host?
- Do we want unified log integration later for filesystem or network stack errors that current readers cannot see?
