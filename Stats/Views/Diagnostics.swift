//
//  Diagnostics.swift
//  Stats
//
//  Created by OpenAI Codex on 29/03/2026.
//

import Cocoa
import Kit

class DiagnosticsView: NSStackView {
    private let scrollView: ScrollableStackView = ScrollableStackView(orientation: .vertical)
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    private let relativeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()
    
    private var refreshTimer: Timer?
    
    private var diagnosticsEnabled: Bool {
        get { Store.shared.bool(key: "Diagnostics_enabled", defaultValue: true) }
        set { Store.shared.set(key: "Diagnostics_enabled", value: newValue) }
    }

    private var watchedStoragePaths: String {
        let raw = Store.shared.string(key: "Diagnostics_storageWatchedPaths", defaultValue: "/Volumes/Projects")
        let values = raw
            .components(separatedBy: CharacterSet(charactersIn: ",\n"))
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        return values.isEmpty ? localizedString("None") : values.joined(separator: ", ")
    }
    
    init() {
        super.init(frame: NSRect(x: 0, y: 0, width: Constants.Settings.width, height: Constants.Settings.height))
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.stackView.edgeInsets = NSEdgeInsets(
            top: 0,
            left: Constants.Settings.margin,
            bottom: Constants.Settings.margin,
            right: Constants.Settings.margin
        )
        self.scrollView.stackView.spacing = Constants.Settings.margin
        
        self.addArrangedSubview(self.scrollView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.settingsNavigationChanged(_:)), name: .openModuleSettings, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.settingsNavigationChanged(_:)), name: .toggleSettings, object: nil)
        
        self.refreshTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.refreshTimerTick), userInfo: nil, repeats: true)
        self.refresh()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .openModuleSettings, object: nil)
        NotificationCenter.default.removeObserver(self, name: .toggleSettings, object: nil)
        self.refreshTimer?.invalidate()
    }
    
    internal func refresh() {
        let snapshot = Diagnostics.shared.snapshot(incidentLimit: 40, networkSampleLimit: 40, diskSampleLimit: 120)
        self.rebuild(using: snapshot)
    }
    
    @objc private func settingsNavigationChanged(_ notification: Notification) {
        guard let module = notification.userInfo?["module"] as? String, module == "Diagnostics" else { return }
        self.refresh()
    }
    
    @objc private func refreshTimerTick() {
        self.refresh()
    }
    
    @objc private func toggleDiagnosticsEnabled(_ sender: NSButton) {
        self.diagnosticsEnabled = sender.state == .on
        self.refresh()
    }
    
    @objc private func refreshDiagnostics() {
        self.refresh()
    }
    
    @objc private func exportDiagnostics() {
        let panel = NSSavePanel()
        panel.nameFieldStringValue = "MacStats-diagnostics.json"
        panel.showsTagField = false
        panel.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.modalPanelWindow)))
        panel.begin { result in
            guard result.rawValue == NSApplication.ModalResponse.OK.rawValue else { return }
            if let url = panel.url, !Diagnostics.shared.export(to: url) {
                self.showAlert(
                    title: localizedString("Export diagnostics"),
                    text: localizedString("Unable to export diagnostics history")
                )
            }
        }
    }
    
    @objc private func clearDiagnostics() {
        let alert = NSAlert()
        alert.messageText = localizedString("Clear diagnostics")
        alert.informativeText = localizedString("This will delete the recorded diagnostics history.")
        alert.alertStyle = .warning
        alert.addButton(withTitle: localizedString("Yes"))
        alert.addButton(withTitle: localizedString("No"))
        
        guard alert.runModal() == .alertFirstButtonReturn else { return }
        if !Diagnostics.shared.clear() {
            self.showAlert(
                title: localizedString("Clear diagnostics"),
                text: localizedString("Unable to clear diagnostics history")
            )
            return
        }
        self.refresh()
    }
    
    private func rebuild(using snapshot: DiagnosticsSnapshotData) {
        self.scrollView.stackView.arrangedSubviews.forEach { view in
            self.scrollView.stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        self.scrollView.stackView.addArrangedSubview(self.overviewSection(snapshot))
        self.scrollView.stackView.addArrangedSubview(self.actionsSection())
        self.scrollView.stackView.addArrangedSubview(self.incidentsSection(snapshot.incidents))
        self.scrollView.stackView.addArrangedSubview(self.networkSection(snapshot.networkSamples.first))
        self.scrollView.stackView.addArrangedSubview(self.diskSection(snapshot.diskSamples))
    }
    
    private func overviewSection(_ snapshot: DiagnosticsSnapshotData) -> NSView {
        let recentIncidentCount = snapshot.incidents.filter {
            snapshot.generatedAt.timeIntervalSince($0.startedAt) <= 24 * 60 * 60
        }.count
        let latestActivity = [snapshot.incidents.first?.startedAt, snapshot.networkSamples.first?.timestamp, snapshot.diskSamples.first?.timestamp]
            .compactMap { $0 }
            .max()
        
        return PreferencesSection(label: localizedString("Overview"), [
            PreferencesRow(localizedString("Recorder"), component: textView(self.diagnosticsEnabled ? localizedString("Enabled") : localizedString("Disabled"), alignment: .right)),
            PreferencesRow(localizedString("Open incidents"), component: textView("\(snapshot.incidents.filter { $0.status == "open" }.count)", alignment: .right)),
            PreferencesRow(localizedString("Incidents in last 24 hours"), component: textView("\(recentIncidentCount)", alignment: .right)),
            PreferencesRow(localizedString("Watched storage paths"), component: textView(self.watchedStoragePaths, alignment: .right)),
            PreferencesRow(localizedString("Loaded network samples"), component: textView("\(snapshot.networkSamples.count)", alignment: .right)),
            PreferencesRow(localizedString("Loaded disk samples"), component: textView("\(snapshot.diskSamples.count)", alignment: .right)),
            PreferencesRow(localizedString("Last activity"), component: textView(latestActivity.map(self.timestampDescription) ?? localizedString("No data yet"), alignment: .right))
        ])
    }
    
    private func actionsSection() -> NSView {
        return PreferencesSection(label: localizedString("Actions"), [
            PreferencesRow(localizedString("Record diagnostics"), component: switchView(
                action: #selector(self.toggleDiagnosticsEnabled),
                state: self.diagnosticsEnabled
            )),
            PreferencesRow(localizedString("Refresh data"), component: buttonView(#selector(self.refreshDiagnostics), text: localizedString("Reload"))),
            PreferencesRow(localizedString("Export diagnostics"), component: buttonView(#selector(self.exportDiagnostics), text: localizedString("Save"))),
            PreferencesRow(localizedString("Clear diagnostics"), component: buttonView(#selector(self.clearDiagnostics), text: localizedString("Reset")))
        ])
    }
    
    private func incidentsSection(_ incidents: [DiagnosticsIncidentSummary]) -> NSView {
        let section = PreferencesSection(label: localizedString("Recent incidents"))
        guard !incidents.isEmpty else {
            section.add(self.placeholderRow(localizedString("No incidents have been recorded yet.")))
            return section
        }
        
        incidents.prefix(12).forEach { incident in
            section.add(self.incidentView(incident))
        }
        return section
    }
    
    private func networkSection(_ sample: DiagnosticsNetworkSampleSummary?) -> NSView {
        let section = PreferencesSection(label: localizedString("Latest network state"))
        guard let sample else {
            section.add(self.placeholderRow(localizedString("No network samples recorded yet.")))
            return section
        }
        
        let wifiValue: String
        if let ssid = sample.ssid {
            var parts = [ssid]
            if let bssid = sample.bssid {
                parts.append(bssid)
            }
            if let channel = sample.wifiChannel {
                parts.append(channel)
            }
            if let rssi = sample.rssi {
                parts.append("RSSI \(rssi)")
            }
            if let noise = sample.noise {
                parts.append("Noise \(noise)")
            }
            wifiValue = parts.joined(separator: " • ")
        } else {
            wifiValue = localizedString("Unavailable")
        }
        
        section.add(PreferencesRow(localizedString("Updated"), component: textView(self.timestampDescription(sample.timestamp), alignment: .right)))
        section.add(PreferencesRow(localizedString("Connectivity"), component: textView(self.networkState(sample), alignment: .right)))
        if let reachabilityClass = sample.reachabilityClass, !reachabilityClass.isEmpty {
            section.add(PreferencesRow(localizedString("Reachability"), component: textView(reachabilityClass.replacingOccurrences(of: "_", with: " ").capitalized, alignment: .right)))
        }
        section.add(PreferencesRow(localizedString("Connection type"), component: textView(sample.connectionType?.capitalized ?? localizedString("Unknown"), alignment: .right)))
        section.add(PreferencesRow(localizedString("Target"), component: textView(sample.connectivityTarget ?? localizedString("Unknown"), alignment: .right)))
        section.add(PreferencesRow(localizedString("Latency"), component: textView(sample.latencyMs.map { String(format: "%.0f ms", $0) } ?? localizedString("Unknown"), alignment: .right)))
        section.add(PreferencesRow(localizedString("Jitter"), component: textView(sample.jitterMs.map { String(format: "%.0f ms", $0) } ?? localizedString("Unknown"), alignment: .right)))
        section.add(PreferencesRow(localizedString("Local IP"), component: textView(sample.localIPAddress ?? localizedString("Unknown"), alignment: .right)))
        section.add(PreferencesRow(localizedString("Public IP"), component: textView(sample.publicIPAddress ?? localizedString("Unknown"), alignment: .right)))
        section.add(PreferencesRow(localizedString("Gateway"), component: textView(sample.gatewayAddress ?? localizedString("Unknown"), alignment: .right)))
        section.add(PreferencesRow(localizedString("DNS"), component: textView(sample.dnsServers ?? localizedString("Unknown"), alignment: .right)))
        section.add(PreferencesRow(localizedString("Wi-Fi"), component: textView(wifiValue, alignment: .right)))
        let diagnosis = self.probeSummary(sample)
        if !diagnosis.isEmpty {
            section.add(PreferencesRow(localizedString("Diagnosis"), component: textView(diagnosis, alignment: .right)))
        }
        section.add(PreferencesRow(localizedString("Upload"), component: textView(Units(bytes: sample.uploadBytesPerSecond).getReadableSpeed(), alignment: .right)))
        section.add(PreferencesRow(localizedString("Download"), component: textView(Units(bytes: sample.downloadBytesPerSecond).getReadableSpeed(), alignment: .right)))
        return section
    }
    
    private func diskSection(_ samples: [DiagnosticsDiskSampleSummary]) -> NSView {
        let section = PreferencesSection(label: localizedString("Latest disk state"))
        let latestSamples = self.latestDiskSamples(from: samples)
        
        guard !latestSamples.isEmpty else {
            section.add(self.placeholderRow(localizedString("No disk samples recorded yet.")))
            return section
        }
        
        latestSamples.prefix(6).forEach { sample in
            section.add(self.diskView(sample))
        }
        return section
    }
    
    private func incidentView(_ incident: DiagnosticsIncidentSummary) -> NSView {
        let view = NSStackView()
        view.orientation = .vertical
        view.spacing = 4
        
        let topRow = NSStackView()
        topRow.orientation = .horizontal
        topRow.alignment = .top
        topRow.spacing = Constants.Settings.margin
        
        let titleField = self.makeTextField(incident.title, font: NSFont.systemFont(ofSize: 13, weight: .semibold))
        let badgeField = self.makeTextField(self.incidentBadge(incident), color: self.severityColor(incident.severity), alignment: .right)
        topRow.addArrangedSubview(titleField)
        topRow.addArrangedSubview(NSView())
        topRow.addArrangedSubview(badgeField)
        
        let metaField = self.makeTextField(
            "\(self.timestampDescription(incident.startedAt)) • \(incident.subsystem.capitalized)",
            color: .secondaryLabelColor
        )
        let summaryField = self.makeTextField(incident.summary, color: .labelColor)
        
        view.addArrangedSubview(topRow)
        view.addArrangedSubview(metaField)
        view.addArrangedSubview(summaryField)
        
        let evidence = self.incidentEvidencePreview(incident).map { evidence in
            "\(evidence.key.replacingOccurrences(of: "_", with: " ")): \(evidence.value)"
        }.joined(separator: " • ")
        if !evidence.isEmpty {
            view.addArrangedSubview(self.makeTextField(evidence, color: .secondaryLabelColor))
        }
        
        return view
    }
    
    private func diskView(_ sample: DiagnosticsDiskSampleSummary) -> NSView {
        let view = NSStackView()
        view.orientation = .vertical
        view.spacing = 4
        
        let topRow = NSStackView()
        topRow.orientation = .horizontal
        topRow.alignment = .top
        topRow.spacing = Constants.Settings.margin
        
        let titleField = self.makeTextField(sample.name ?? sample.identifier, font: NSFont.systemFont(ofSize: 13, weight: .semibold))
        let stateField = self.makeTextField(
            sample.mounted == false ? localizedString("Not mounted") : localizedString("Mounted"),
            color: sample.mounted == false ? .systemRed : .secondaryLabelColor,
            alignment: .right
        )
        topRow.addArrangedSubview(titleField)
        topRow.addArrangedSubview(NSView())
        topRow.addArrangedSubview(stateField)
        
        let capacity = self.diskCapacitySummary(sample)
        let activity = localizedString("Read %0 • Write %1",
                                       sample.readBytesPerSecond.map { Units(bytes: $0).getReadableSpeed() } ?? localizedString("Unknown"),
                                       sample.writeBytesPerSecond.map { Units(bytes: $0).getReadableSpeed() } ?? localizedString("Unknown"))
        let smart = self.diskSMARTSummary(sample)
        
        view.addArrangedSubview(topRow)
        view.addArrangedSubview(self.makeTextField(self.timestampDescription(sample.timestamp), color: .secondaryLabelColor))
        view.addArrangedSubview(self.makeTextField(capacity, color: .labelColor))
        view.addArrangedSubview(self.makeTextField(activity, color: .secondaryLabelColor))
        if !smart.isEmpty {
            view.addArrangedSubview(self.makeTextField(smart, color: .secondaryLabelColor))
        }
        
        return view
    }
    
    private func latestDiskSamples(from samples: [DiagnosticsDiskSampleSummary]) -> [DiagnosticsDiskSampleSummary] {
        var seen: Set<String> = []
        var results: [DiagnosticsDiskSampleSummary] = []
        
        samples.forEach { sample in
            guard !seen.contains(sample.identifier) else { return }
            seen.insert(sample.identifier)
            results.append(sample)
        }
        
        return results
    }
    
    private func networkState(_ sample: DiagnosticsNetworkSampleSummary) -> String {
        let availability: String
        if sample.internetReachable == true {
            availability = sample.reachabilityClass == nil || sample.reachabilityClass == "healthy"
                ? localizedString("Reachable")
                : localizedString("Degraded")
        } else {
            availability = localizedString("Unavailable")
        }
        guard let interface = sample.interfaceBSDName else { return availability }
        let interfaceState = sample.interfaceStatus == false ? localizedString("down") : localizedString("up")
        return "\(interface) • \(interfaceState) • \(availability)"
    }
    
    private func probeSummary(_ sample: DiagnosticsNetworkSampleSummary) -> String {
        var parts: [String] = []
        if let quorumPassed = sample.quorumPassed {
            parts.append(localizedString("Quorum %0", quorumPassed ? "ok" : "down"))
        }
        if let primaryProbeReachable = sample.primaryProbeReachable {
            let label = sample.primaryProbeTransport?.uppercased() ?? localizedString("Primary probe")
            parts.append(localizedString("%0 %1", label, primaryProbeReachable ? "ok" : "down"))
        }
        if let stage = sample.failureStage, !stage.isEmpty {
            parts.append(stage.replacingOccurrences(of: "_", with: " "))
        }
        if let reason = sample.failureReason, !reason.isEmpty {
            parts.append(reason.replacingOccurrences(of: "_", with: " "))
        }
        if let gatewayReachable = sample.gatewayReachable {
            parts.append(localizedString("Gateway %0", gatewayReachable ? "ok" : "down"))
        }
        if let publicProbeReachable = sample.publicProbeReachable {
            parts.append(localizedString("Public probe %0", publicProbeReachable ? "ok" : "down"))
        }
        if let dnsResolved = sample.dnsResolved {
            parts.append(localizedString("DNS %0", dnsResolved ? "ok" : "down"))
        }
        if let httpReachable = sample.httpReachable {
            parts.append(localizedString("HTTP %0", httpReachable ? "ok" : "down"))
        }
        return parts.joined(separator: " • ")
    }
    
    private func incidentEvidencePreview(_ incident: DiagnosticsIncidentSummary) -> [DiagnosticsIncidentEvidence] {
        let priorityKeys = [
            "probable_cause",
            "path",
            "error",
            "service",
            "bundle_id",
            "watched_paths",
            "reachability_class",
            "quorum_passed",
            "primary_probe_reachable",
            "primary_probe_failure_reason",
            "recent_changes",
            "failure_stage",
            "failure_reason",
            "gateway_reachable",
            "public_probe_reachable",
            "dns_resolved",
            "http_reachable"
        ]
        
        var selected: [DiagnosticsIncidentEvidence] = []
        priorityKeys.forEach { key in
            if let evidence = incident.evidence.first(where: { $0.key == key }), !selected.contains(where: { $0.key == evidence.key }) {
                selected.append(evidence)
            }
        }
        incident.evidence.forEach { evidence in
            guard selected.count < 3 else { return }
            if !selected.contains(where: { $0.key == evidence.key }) {
                selected.append(evidence)
            }
        }
        return Array(selected.prefix(3))
    }
    
    private func diskCapacitySummary(_ sample: DiagnosticsDiskSampleSummary) -> String {
        var parts: [String] = []
        
        if let utilization = sample.utilization {
            parts.append(localizedString("Used %0%%", "\(Int(utilization * 100))"))
        }
        if let freeBytes = sample.freeBytes {
            parts.append(localizedString("Free %0", DiskSize(freeBytes).getReadableMemory()))
        }
        if let totalBytes = sample.totalBytes {
            parts.append(localizedString("Total %0", DiskSize(totalBytes).getReadableMemory()))
        }
        
        return parts.isEmpty ? localizedString("No capacity data recorded") : parts.joined(separator: " • ")
    }
    
    private func diskSMARTSummary(_ sample: DiagnosticsDiskSampleSummary) -> String {
        var parts: [String] = []
        
        if let temperature = sample.smartTemperature {
            parts.append(localizedString("Temp %0 C", "\(temperature)"))
        }
        if let life = sample.smartLife {
            parts.append(localizedString("Life %0%%", "\(life)"))
        }
        if let hours = sample.smartPowerOnHours {
            parts.append(localizedString("Power on %0 h", "\(hours)"))
        }
        
        return parts.joined(separator: " • ")
    }
    
    private func incidentBadge(_ incident: DiagnosticsIncidentSummary) -> String {
        let status = incident.status.uppercased()
        let severity = incident.severity.uppercased()
        return "\(severity) • \(status)"
    }
    
    private func severityColor(_ severity: String) -> NSColor {
        switch severity {
        case "critical":
            return .systemRed
        case "warning":
            return .systemOrange
        default:
            return .secondaryLabelColor
        }
    }
    
    private func timestampDescription(_ value: Date) -> String {
        "\(self.dateFormatter.string(from: value)) (\(self.relativeFormatter.localizedString(for: value, relativeTo: Date())))"
    }
    
    private func placeholderRow(_ text: String) -> NSView {
        self.makeTextField(text, color: .secondaryLabelColor)
    }
    
    private func makeTextField(
        _ value: String,
        font: NSFont = NSFont.systemFont(ofSize: 12, weight: .regular),
        color: NSColor = .labelColor,
        alignment: NSTextAlignment = .left
    ) -> NSTextField {
        let field: NSTextField = TextView()
        field.font = font
        field.textColor = color
        field.stringValue = value
        field.alignment = alignment
        field.isSelectable = true
        field.usesSingleLineMode = false
        field.maximumNumberOfLines = 0
        field.lineBreakMode = .byWordWrapping
        field.cell?.wraps = true
        field.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return field
    }
    
    private func showAlert(title: String, text: String) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: localizedString("OK"))
        alert.runModal()
    }
}
