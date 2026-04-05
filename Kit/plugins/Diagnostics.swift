//
//  Diagnostics.swift
//  Kit
//
//  Created by OpenAI Codex on 29/03/2026.
//

import Foundation
import SQLite3

private let sqliteTransient = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

public struct DiagnosticsNetworkUsageSnapshot {
    public let timestamp: Date
    public let interfaceBSDName: String?
    public let interfaceStatus: Bool?
    public let reachabilityStatus: Bool
    public let connectionType: String?
    public let localIPAddress: String?
    public let publicIPAddress: String?
    public let gatewayAddress: String?
    public let dnsServers: [String]
    public let ssid: String?
    public let bssid: String?
    public let rssi: Int?
    public let noise: Int?
    public let wifiStandard: String?
    public let wifiMode: String?
    public let wifiSecurity: String?
    public let wifiChannel: String?
    public let wifiChannelBand: String?
    public let wifiChannelWidth: String?
    public let wifiChannelNumber: String?
    public let uploadBytesPerSecond: Int64
    public let downloadBytesPerSecond: Int64
    
    public init(
        timestamp: Date = Date(),
        interfaceBSDName: String? = nil,
        interfaceStatus: Bool? = nil,
        reachabilityStatus: Bool,
        connectionType: String? = nil,
        localIPAddress: String? = nil,
        publicIPAddress: String? = nil,
        gatewayAddress: String? = nil,
        dnsServers: [String] = [],
        ssid: String? = nil,
        bssid: String? = nil,
        rssi: Int? = nil,
        noise: Int? = nil,
        wifiStandard: String? = nil,
        wifiMode: String? = nil,
        wifiSecurity: String? = nil,
        wifiChannel: String? = nil,
        wifiChannelBand: String? = nil,
        wifiChannelWidth: String? = nil,
        wifiChannelNumber: String? = nil,
        uploadBytesPerSecond: Int64,
        downloadBytesPerSecond: Int64
    ) {
        self.timestamp = timestamp
        self.interfaceBSDName = interfaceBSDName
        self.interfaceStatus = interfaceStatus
        self.reachabilityStatus = reachabilityStatus
        self.connectionType = connectionType
        self.localIPAddress = localIPAddress
        self.publicIPAddress = publicIPAddress
        self.gatewayAddress = gatewayAddress
        self.dnsServers = dnsServers
        self.ssid = ssid
        self.bssid = bssid
        self.rssi = rssi
        self.noise = noise
        self.wifiStandard = wifiStandard
        self.wifiMode = wifiMode
        self.wifiSecurity = wifiSecurity
        self.wifiChannel = wifiChannel
        self.wifiChannelBand = wifiChannelBand
        self.wifiChannelWidth = wifiChannelWidth
        self.wifiChannelNumber = wifiChannelNumber
        self.uploadBytesPerSecond = uploadBytesPerSecond
        self.downloadBytesPerSecond = downloadBytesPerSecond
    }
}

public struct DiagnosticsNetworkConnectivitySnapshot {
    public let timestamp: Date
    public let reachable: Bool
    public let latencyMs: Double?
    public let jitterMs: Double?
    public let mode: String
    public let target: String
    public let reachabilityClass: String?
    public let quorumPassed: Bool?
    public let primaryProbeTransport: String?
    public let primaryProbeTarget: String?
    public let primaryProbeReachable: Bool?
    public let primaryProbeFailureReason: String?
    public let gatewayReachable: Bool?
    public let gatewayProbeFailureReason: String?
    public let publicProbeTarget: String?
    public let publicProbeReachable: Bool?
    public let publicProbeFailureReason: String?
    public let dnsProbeHost: String?
    public let dnsResolved: Bool?
    public let dnsFailureReason: String?
    public let httpProbeTarget: String?
    public let httpReachable: Bool?
    public let httpFailureReason: String?
    public let failureStage: String?
    public let failureReason: String?
    
    public init(
        timestamp: Date = Date(),
        reachable: Bool,
        latencyMs: Double? = nil,
        jitterMs: Double? = nil,
        mode: String,
        target: String,
        reachabilityClass: String? = nil,
        quorumPassed: Bool? = nil,
        primaryProbeTransport: String? = nil,
        primaryProbeTarget: String? = nil,
        primaryProbeReachable: Bool? = nil,
        primaryProbeFailureReason: String? = nil,
        gatewayReachable: Bool? = nil,
        gatewayProbeFailureReason: String? = nil,
        publicProbeTarget: String? = nil,
        publicProbeReachable: Bool? = nil,
        publicProbeFailureReason: String? = nil,
        dnsProbeHost: String? = nil,
        dnsResolved: Bool? = nil,
        dnsFailureReason: String? = nil,
        httpProbeTarget: String? = nil,
        httpReachable: Bool? = nil,
        httpFailureReason: String? = nil,
        failureStage: String? = nil,
        failureReason: String? = nil
    ) {
        self.timestamp = timestamp
        self.reachable = reachable
        self.latencyMs = latencyMs
        self.jitterMs = jitterMs
        self.mode = mode
        self.target = target
        self.reachabilityClass = reachabilityClass
        self.quorumPassed = quorumPassed
        self.primaryProbeTransport = primaryProbeTransport
        self.primaryProbeTarget = primaryProbeTarget
        self.primaryProbeReachable = primaryProbeReachable
        self.primaryProbeFailureReason = primaryProbeFailureReason
        self.gatewayReachable = gatewayReachable
        self.gatewayProbeFailureReason = gatewayProbeFailureReason
        self.publicProbeTarget = publicProbeTarget
        self.publicProbeReachable = publicProbeReachable
        self.publicProbeFailureReason = publicProbeFailureReason
        self.dnsProbeHost = dnsProbeHost
        self.dnsResolved = dnsResolved
        self.dnsFailureReason = dnsFailureReason
        self.httpProbeTarget = httpProbeTarget
        self.httpReachable = httpReachable
        self.httpFailureReason = httpFailureReason
        self.failureStage = failureStage
        self.failureReason = failureReason
    }
}

public struct DiagnosticsDiskSnapshot {
    public let timestamp: Date
    public let identifier: String
    public let name: String?
    public let mounted: Bool?
    public let totalBytes: Int64?
    public let freeBytes: Int64?
    public let utilization: Double?
    public let readBytesPerSecond: Int64?
    public let writeBytesPerSecond: Int64?
    public let smartTemperature: Int?
    public let smartLife: Int?
    public let smartPowerCycles: Int?
    public let smartPowerOnHours: Int?
    
    public init(
        timestamp: Date = Date(),
        identifier: String,
        name: String? = nil,
        mounted: Bool? = nil,
        totalBytes: Int64? = nil,
        freeBytes: Int64? = nil,
        utilization: Double? = nil,
        readBytesPerSecond: Int64? = nil,
        writeBytesPerSecond: Int64? = nil,
        smartTemperature: Int? = nil,
        smartLife: Int? = nil,
        smartPowerCycles: Int? = nil,
        smartPowerOnHours: Int? = nil
    ) {
        self.timestamp = timestamp
        self.identifier = identifier
        self.name = name
        self.mounted = mounted
        self.totalBytes = totalBytes
        self.freeBytes = freeBytes
        self.utilization = utilization
        self.readBytesPerSecond = readBytesPerSecond
        self.writeBytesPerSecond = writeBytesPerSecond
        self.smartTemperature = smartTemperature
        self.smartLife = smartLife
        self.smartPowerCycles = smartPowerCycles
        self.smartPowerOnHours = smartPowerOnHours
    }
}

public struct DiagnosticsIncidentEvidence {
    public let timestamp: Date
    public let key: String
    public let value: String
    
    public init(timestamp: Date, key: String, value: String) {
        self.timestamp = timestamp
        self.key = key
        self.value = value
    }
}

public struct DiagnosticsIncidentSummary {
    public let id: Int64
    public let type: String
    public let subsystem: String
    public let severity: String
    public let status: String
    public let title: String
    public let summary: String
    public let subjectKey: String
    public let startedAt: Date
    public let endedAt: Date?
    public let evidence: [DiagnosticsIncidentEvidence]
    
    public init(
        id: Int64,
        type: String,
        subsystem: String,
        severity: String,
        status: String,
        title: String,
        summary: String,
        subjectKey: String,
        startedAt: Date,
        endedAt: Date?,
        evidence: [DiagnosticsIncidentEvidence]
    ) {
        self.id = id
        self.type = type
        self.subsystem = subsystem
        self.severity = severity
        self.status = status
        self.title = title
        self.summary = summary
        self.subjectKey = subjectKey
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.evidence = evidence
    }
}

public struct DiagnosticsNetworkSampleSummary {
    public let timestamp: Date
    public let interfaceBSDName: String?
    public let interfaceStatus: Bool?
    public let internetReachable: Bool?
    public let connectionType: String?
    public let connectivityMode: String?
    public let connectivityTarget: String?
    public let latencyMs: Double?
    public let jitterMs: Double?
    public let reachabilityClass: String?
    public let quorumPassed: Bool?
    public let primaryProbeTransport: String?
    public let primaryProbeTarget: String?
    public let primaryProbeReachable: Bool?
    public let primaryProbeFailureReason: String?
    public let localIPAddress: String?
    public let publicIPAddress: String?
    public let gatewayAddress: String?
    public let dnsServers: String?
    public let ssid: String?
    public let bssid: String?
    public let rssi: Int?
    public let noise: Int?
    public let wifiStandard: String?
    public let wifiMode: String?
    public let wifiSecurity: String?
    public let wifiChannel: String?
    public let wifiChannelBand: String?
    public let wifiChannelWidth: String?
    public let wifiChannelNumber: String?
    public let gatewayReachable: Bool?
    public let gatewayProbeFailureReason: String?
    public let publicProbeTarget: String?
    public let publicProbeReachable: Bool?
    public let publicProbeFailureReason: String?
    public let dnsProbeHost: String?
    public let dnsResolved: Bool?
    public let dnsFailureReason: String?
    public let httpProbeTarget: String?
    public let httpReachable: Bool?
    public let httpFailureReason: String?
    public let failureStage: String?
    public let failureReason: String?
    public let uploadBytesPerSecond: Int64
    public let downloadBytesPerSecond: Int64
    
    public init(
        timestamp: Date,
        interfaceBSDName: String?,
        interfaceStatus: Bool?,
        internetReachable: Bool?,
        connectionType: String?,
        connectivityMode: String?,
        connectivityTarget: String?,
        latencyMs: Double?,
        jitterMs: Double?,
        reachabilityClass: String?,
        quorumPassed: Bool?,
        primaryProbeTransport: String?,
        primaryProbeTarget: String?,
        primaryProbeReachable: Bool?,
        primaryProbeFailureReason: String?,
        localIPAddress: String?,
        publicIPAddress: String?,
        gatewayAddress: String?,
        dnsServers: String?,
        ssid: String?,
        bssid: String?,
        rssi: Int?,
        noise: Int?,
        wifiStandard: String?,
        wifiMode: String?,
        wifiSecurity: String?,
        wifiChannel: String?,
        wifiChannelBand: String?,
        wifiChannelWidth: String?,
        wifiChannelNumber: String?,
        gatewayReachable: Bool?,
        gatewayProbeFailureReason: String?,
        publicProbeTarget: String?,
        publicProbeReachable: Bool?,
        publicProbeFailureReason: String?,
        dnsProbeHost: String?,
        dnsResolved: Bool?,
        dnsFailureReason: String?,
        httpProbeTarget: String?,
        httpReachable: Bool?,
        httpFailureReason: String?,
        failureStage: String?,
        failureReason: String?,
        uploadBytesPerSecond: Int64,
        downloadBytesPerSecond: Int64
    ) {
        self.timestamp = timestamp
        self.interfaceBSDName = interfaceBSDName
        self.interfaceStatus = interfaceStatus
        self.internetReachable = internetReachable
        self.connectionType = connectionType
        self.connectivityMode = connectivityMode
        self.connectivityTarget = connectivityTarget
        self.latencyMs = latencyMs
        self.jitterMs = jitterMs
        self.reachabilityClass = reachabilityClass
        self.quorumPassed = quorumPassed
        self.primaryProbeTransport = primaryProbeTransport
        self.primaryProbeTarget = primaryProbeTarget
        self.primaryProbeReachable = primaryProbeReachable
        self.primaryProbeFailureReason = primaryProbeFailureReason
        self.localIPAddress = localIPAddress
        self.publicIPAddress = publicIPAddress
        self.gatewayAddress = gatewayAddress
        self.dnsServers = dnsServers
        self.ssid = ssid
        self.bssid = bssid
        self.rssi = rssi
        self.noise = noise
        self.wifiStandard = wifiStandard
        self.wifiMode = wifiMode
        self.wifiSecurity = wifiSecurity
        self.wifiChannel = wifiChannel
        self.wifiChannelBand = wifiChannelBand
        self.wifiChannelWidth = wifiChannelWidth
        self.wifiChannelNumber = wifiChannelNumber
        self.gatewayReachable = gatewayReachable
        self.gatewayProbeFailureReason = gatewayProbeFailureReason
        self.publicProbeTarget = publicProbeTarget
        self.publicProbeReachable = publicProbeReachable
        self.publicProbeFailureReason = publicProbeFailureReason
        self.dnsProbeHost = dnsProbeHost
        self.dnsResolved = dnsResolved
        self.dnsFailureReason = dnsFailureReason
        self.httpProbeTarget = httpProbeTarget
        self.httpReachable = httpReachable
        self.httpFailureReason = httpFailureReason
        self.failureStage = failureStage
        self.failureReason = failureReason
        self.uploadBytesPerSecond = uploadBytesPerSecond
        self.downloadBytesPerSecond = downloadBytesPerSecond
    }
}

public struct DiagnosticsDiskSampleSummary {
    public let timestamp: Date
    public let identifier: String
    public let name: String?
    public let mounted: Bool?
    public let freeBytes: Int64?
    public let totalBytes: Int64?
    public let utilization: Double?
    public let readBytesPerSecond: Int64?
    public let writeBytesPerSecond: Int64?
    public let smartTemperature: Int?
    public let smartLife: Int?
    public let smartPowerCycles: Int?
    public let smartPowerOnHours: Int?
    
    public init(
        timestamp: Date,
        identifier: String,
        name: String?,
        mounted: Bool?,
        freeBytes: Int64?,
        totalBytes: Int64?,
        utilization: Double?,
        readBytesPerSecond: Int64?,
        writeBytesPerSecond: Int64?,
        smartTemperature: Int?,
        smartLife: Int?,
        smartPowerCycles: Int?,
        smartPowerOnHours: Int?
    ) {
        self.timestamp = timestamp
        self.identifier = identifier
        self.name = name
        self.mounted = mounted
        self.freeBytes = freeBytes
        self.totalBytes = totalBytes
        self.utilization = utilization
        self.readBytesPerSecond = readBytesPerSecond
        self.writeBytesPerSecond = writeBytesPerSecond
        self.smartTemperature = smartTemperature
        self.smartLife = smartLife
        self.smartPowerCycles = smartPowerCycles
        self.smartPowerOnHours = smartPowerOnHours
    }
}

public struct DiagnosticsSnapshotData {
    public let generatedAt: Date
    public let incidents: [DiagnosticsIncidentSummary]
    public let networkSamples: [DiagnosticsNetworkSampleSummary]
    public let diskSamples: [DiagnosticsDiskSampleSummary]
    
    public init(
        generatedAt: Date,
        incidents: [DiagnosticsIncidentSummary],
        networkSamples: [DiagnosticsNetworkSampleSummary],
        diskSamples: [DiagnosticsDiskSampleSummary]
    ) {
        self.generatedAt = generatedAt
        self.incidents = incidents
        self.networkSamples = networkSamples
        self.diskSamples = diskSamples
    }
}

private struct DiagnosticsDiskRuntimeState {
    var snapshot: DiagnosticsDiskSnapshot
    var lastSampleWriteAt: Date = .distantPast
    var lowSpaceIncidentID: Int64?
    var tempHighCount: Int = 0
    var tempNormalCount: Int = 0
    var tempIncidentID: Int64?
    var lastRecordedLife: Int?
    var freeHistory: [(Date, Int64)] = []
    var lastRapidDropIncidentAt: Date?
}

private struct DiagnosticsWatchedPathRuntimeState {
    var exists: Bool?
    var readable: Bool?
    var missingIncidentID: Int64?
    var unreadableIncidentID: Int64?
}

private struct NetworkCauseClassification {
    let code: String
    let summary: String
    let rank: Int
    let evidence: [String: String]
}

public final class Diagnostics {
    public static let shared = Diagnostics()
    
    private let queue = DispatchQueue(label: "com.textd.MacStats.Diagnostics")
    private let store = DiagnosticsStore()
    
    private var usage: DiagnosticsNetworkUsageSnapshot?
    private var connectivity: DiagnosticsNetworkConnectivitySnapshot?
    private var lastSampleWriteAt: Date = .distantPast
    private var lastConnectivityStatus: Bool?
    private var flapTransitions: [Date] = []
    private var lastFlapIncidentAt: Date?
    private var changeMarkers: [String: Date] = [:]
    private var lastUnreachableUsage: DiagnosticsNetworkUsageSnapshot?
    private var lastUnreachableConnectivity: DiagnosticsNetworkConnectivitySnapshot?
    
    private var downPendingCount: Int = 0
    private var downIncidentID: Int64?
    private var downIncidentCause: NetworkCauseClassification?
    
    private var latencyHighCount: Int = 0
    private var latencyNormalCount: Int = 0
    private var latencyIncidentID: Int64?
    
    private var jitterHighCount: Int = 0
    private var jitterNormalCount: Int = 0
    private var jitterIncidentID: Int64?
    
    private var diskStates: [String: DiagnosticsDiskRuntimeState] = [:]
    private var watchedPathStates: [String: DiagnosticsWatchedPathRuntimeState] = [:]
    private var lastStorageSignalPollAt: Date = .distantPast
    private var recentPermissionEvents: [String: Date] = [:]
    
    private var writeCounter: Int = 0
    
    private init() {}
    
    public func recordNetworkUsage(_ snapshot: DiagnosticsNetworkUsageSnapshot) {
        self.queue.async {
            guard self.isEnabled else { return }
            
            let previous = self.usage
            self.usage = snapshot
            if self.connectivity?.reachable == false || self.downIncidentID != nil {
                self.lastUnreachableUsage = snapshot
                self.captureDownIncidentCause(self.classifyNetworkCause(at: snapshot.timestamp, connectivity: self.lastUnreachableConnectivity ?? self.connectivity))
            }
            
            var forceSample = false
            if let previous {
                forceSample = self.handleUsageChanges(previous: previous, current: snapshot) || forceSample
            }
            
            self.persistNetworkSampleIfNeeded(force: forceSample)
        }
    }
    
    public func recordNetworkConnectivity(_ snapshot: DiagnosticsNetworkConnectivitySnapshot) {
        self.queue.async {
            guard self.isEnabled else { return }
            
            self.connectivity = snapshot
            if !snapshot.reachable {
                self.lastUnreachableConnectivity = snapshot
                self.captureDownIncidentCause(self.classifyNetworkCause(at: snapshot.timestamp, connectivity: snapshot))
            }
            
            var forceSample = false
            if let previousStatus = self.lastConnectivityStatus, previousStatus != snapshot.reachable {
                self.flapTransitions.append(snapshot.timestamp)
                self.flapTransitions = self.flapTransitions.filter {
                    snapshot.timestamp.timeIntervalSince($0) <= TimeInterval(self.flapWindowSeconds)
                }
                forceSample = true
                self.recordFlapIncidentIfNeeded(at: snapshot.timestamp)
            }
            
            self.handleConnectivityStatus(snapshot)
            self.handleLatency(snapshot)
            self.handleJitter(snapshot)
            
            self.lastConnectivityStatus = snapshot.reachable
            self.persistNetworkSampleIfNeeded(force: forceSample)
        }
    }
    
    public func recordDiskSnapshots(_ snapshots: [DiagnosticsDiskSnapshot]) {
        self.queue.async {
            guard self.isEnabled else { return }

            let timestamp = snapshots.map(\.timestamp).max() ?? Date()

            if !snapshots.isEmpty {
                let knownDiskKeys = Set(self.diskStates.keys)
                let currentDiskKeys = Set(snapshots.map { self.diskSubjectKey($0.identifier) })

                snapshots.forEach { snapshot in
                    self.mergeDiskSnapshot(snapshot)
                }

                knownDiskKeys.subtracting(currentDiskKeys).forEach { subjectKey in
                    self.handleMissingDisk(subjectKey: subjectKey, at: timestamp)
                }
            }

            self.pollStorageSignalsIfNeeded(at: timestamp)
        }
    }
    
    public func export(to url: URL) -> Bool {
        self.queue.sync {
            self.store.export(to: url)
        }
    }
    
    public func clear() -> Bool {
        self.queue.sync {
            self.resetState()
            return self.store.clear()
        }
    }
    
    public func snapshot(
        incidentLimit: Int = 50,
        networkSampleLimit: Int = 50,
        diskSampleLimit: Int = 100
    ) -> DiagnosticsSnapshotData {
        self.queue.sync {
            self.store.snapshot(
                incidentLimit: max(incidentLimit, 1),
                networkSampleLimit: max(networkSampleLimit, 1),
                diskSampleLimit: max(diskSampleLimit, 1)
            )
        }
    }
    
    private var isEnabled: Bool {
        Store.shared.bool(key: "Diagnostics_enabled", defaultValue: true)
    }
    
    private var sampleInterval: TimeInterval {
        TimeInterval(max(Store.shared.int(key: "Diagnostics_networkSampleInterval", defaultValue: 5), 1))
    }
    
    private var downThreshold: Int {
        max(Store.shared.int(key: "Diagnostics_networkDownThreshold", defaultValue: 2), 1)
    }
    
    private var highLatencyThresholdMs: Double {
        Double(max(Store.shared.int(key: "Diagnostics_latencyThresholdMs", defaultValue: 250), 1))
    }
    
    private var highJitterThresholdMs: Double {
        Double(max(Store.shared.int(key: "Diagnostics_jitterThresholdMs", defaultValue: 75), 1))
    }
    
    private var metricTriggerCount: Int {
        max(Store.shared.int(key: "Diagnostics_networkMetricTriggerCount", defaultValue: 3), 1)
    }
    
    private var metricRecoveryCount: Int {
        max(Store.shared.int(key: "Diagnostics_networkMetricRecoveryCount", defaultValue: 3), 1)
    }
    
    private var flapWindowSeconds: Int {
        max(Store.shared.int(key: "Diagnostics_networkFlapWindowSeconds", defaultValue: 120), 10)
    }
    
    private var flapTransitionThreshold: Int {
        max(Store.shared.int(key: "Diagnostics_networkFlapTransitionThreshold", defaultValue: 4), 2)
    }
    
    private var networkRetentionHours: Int {
        max(Store.shared.int(key: "Diagnostics_networkRetentionHours", defaultValue: 24), 1)
    }
    
    private var diskSampleInterval: TimeInterval {
        TimeInterval(max(Store.shared.int(key: "Diagnostics_diskSampleInterval", defaultValue: 30), 5))
    }
    
    private var diskRetentionDays: Int {
        max(Store.shared.int(key: "Diagnostics_diskRetentionDays", defaultValue: 7), 1)
    }
    
    private var lowDiskSpaceThreshold: Double {
        Double(max(Store.shared.int(key: "Diagnostics_diskLowSpaceThreshold", defaultValue: 90), 1)) / 100
    }
    
    private var smartTemperatureThreshold: Int {
        max(Store.shared.int(key: "Diagnostics_diskSmartTemperatureThreshold", defaultValue: 70), 1)
    }
    
    private var diskSpaceDropWindowSeconds: Int {
        max(Store.shared.int(key: "Diagnostics_diskDropWindowSeconds", defaultValue: 600), 60)
    }
    
    private var diskSpaceDropThresholdGB: Int64 {
        Int64(max(Store.shared.int(key: "Diagnostics_diskDropThresholdGB", defaultValue: 10), 1))
    }

    private var storageSignalPollInterval: TimeInterval {
        TimeInterval(max(Store.shared.int(key: "Diagnostics_storageSignalPollInterval", defaultValue: 60), 10))
    }

    private var permissionLogLookbackSeconds: Int {
        max(Store.shared.int(key: "Diagnostics_permissionLogLookbackSeconds", defaultValue: 180), 30)
    }

    private var permissionLogEnabled: Bool {
        Store.shared.bool(key: "Diagnostics_permissionLogEnabled", defaultValue: true)
    }

    private var watchedVolumePaths: [String] {
        let raw = Store.shared.string(key: "Diagnostics_storageWatchedPaths", defaultValue: "/Volumes/Projects")
        let separators = CharacterSet(charactersIn: ",\n")
        let values = raw
            .components(separatedBy: separators)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .map { URL(fileURLWithPath: $0).standardizedFileURL.path }
        var seen: Set<String> = []
        return values.filter { seen.insert($0).inserted }
    }
    
    private var incidentRetentionDays: Int {
        max(Store.shared.int(key: "Diagnostics_incidentRetentionDays", defaultValue: 90), 1)
    }
    
    private var correlationWindowSeconds: Int {
        max(Store.shared.int(key: "Diagnostics_networkCorrelationWindowSeconds", defaultValue: 45), 5)
    }
    
    private var weakWiFiRSSIThreshold: Int {
        Store.shared.int(key: "Diagnostics_networkWeakWiFiRSSIThreshold", defaultValue: -75)
    }
    
    private var weakWiFiSNRThreshold: Int {
        max(Store.shared.int(key: "Diagnostics_networkWeakWiFiSNRThreshold", defaultValue: 15), 1)
    }
    
    private func handleUsageChanges(previous: DiagnosticsNetworkUsageSnapshot, current: DiagnosticsNetworkUsageSnapshot) -> Bool {
        var forceSample = false
        
        if previous.interfaceBSDName != current.interfaceBSDName,
           previous.interfaceBSDName != nil || current.interfaceBSDName != nil {
            self.recordChangeMarker("interface", at: current.timestamp)
            self.store.recordEventIncident(
                type: "interface_changed",
                severity: "info",
                title: localizedString("Network interface changed"),
                summary: self.changeSummary(kind: "interface", previous: previous.interfaceBSDName, current: current.interfaceBSDName),
                subjectKey: self.subjectKey(interfaceName: current.interfaceBSDName ?? previous.interfaceBSDName),
                evidence: [
                    "previous_interface": previous.interfaceBSDName ?? "-",
                    "current_interface": current.interfaceBSDName ?? "-"
                ],
                at: current.timestamp
            )
            forceSample = true
        }
        
        if previous.localIPAddress != current.localIPAddress,
           previous.localIPAddress != nil || current.localIPAddress != nil {
            self.recordChangeMarker("local_ip", at: current.timestamp)
            self.store.recordEventIncident(
                type: "local_ip_changed",
                severity: "info",
                title: localizedString("Local IP changed"),
                summary: self.changeSummary(kind: "local IP", previous: previous.localIPAddress, current: current.localIPAddress),
                subjectKey: self.subjectKey(interfaceName: current.interfaceBSDName ?? previous.interfaceBSDName),
                evidence: [
                    "previous_local_ip": previous.localIPAddress ?? "-",
                    "current_local_ip": current.localIPAddress ?? "-"
                ],
                at: current.timestamp
            )
            forceSample = true
        }
        
        if previous.publicIPAddress != current.publicIPAddress,
           previous.publicIPAddress != nil || current.publicIPAddress != nil {
            self.recordChangeMarker("public_ip", at: current.timestamp)
            self.store.recordEventIncident(
                type: "public_ip_changed",
                severity: "info",
                title: localizedString("Public IP changed"),
                summary: self.changeSummary(kind: "public IP", previous: previous.publicIPAddress, current: current.publicIPAddress),
                subjectKey: self.subjectKey(interfaceName: current.interfaceBSDName ?? previous.interfaceBSDName),
                evidence: [
                    "previous_public_ip": previous.publicIPAddress ?? "-",
                    "current_public_ip": current.publicIPAddress ?? "-"
                ],
                at: current.timestamp
            )
            forceSample = true
        }
        
        if previous.ssid != current.ssid,
           previous.ssid != nil || current.ssid != nil {
            self.recordChangeMarker("ssid", at: current.timestamp)
            self.store.recordEventIncident(
                type: "wifi_changed",
                severity: "warning",
                title: localizedString("WiFi network changed"),
                summary: self.changeSummary(kind: "Wi-Fi network", previous: previous.ssid, current: current.ssid),
                subjectKey: self.subjectKey(interfaceName: current.interfaceBSDName ?? previous.interfaceBSDName),
                evidence: [
                    "previous_ssid": previous.ssid ?? "-",
                    "current_ssid": current.ssid ?? "-",
                    "rssi": current.rssi.map { "\($0)" } ?? "-",
                    "noise": current.noise.map { "\($0)" } ?? "-"
                ],
                at: current.timestamp
            )
            forceSample = true
        }
        
        if previous.bssid != current.bssid,
           previous.bssid != nil || current.bssid != nil {
            self.recordChangeMarker("bssid", at: current.timestamp)
            self.store.recordEventIncident(
                type: "wifi_access_point_changed",
                severity: "warning",
                title: localizedString("Wi-Fi access point changed"),
                summary: self.changeSummary(kind: "Wi-Fi access point", previous: previous.bssid, current: current.bssid),
                subjectKey: self.subjectKey(interfaceName: current.interfaceBSDName ?? previous.interfaceBSDName),
                evidence: [
                    "ssid": current.ssid ?? previous.ssid ?? "-",
                    "previous_bssid": previous.bssid ?? "-",
                    "current_bssid": current.bssid ?? "-",
                    "channel": current.wifiChannel ?? previous.wifiChannel ?? "-"
                ],
                at: current.timestamp
            )
            forceSample = true
        }
        
        if previous.gatewayAddress != current.gatewayAddress,
           previous.gatewayAddress != nil || current.gatewayAddress != nil {
            self.recordChangeMarker("gateway", at: current.timestamp)
            self.store.recordEventIncident(
                type: "gateway_changed",
                severity: "info",
                title: localizedString("Default gateway changed"),
                summary: self.changeSummary(kind: "default gateway", previous: previous.gatewayAddress, current: current.gatewayAddress),
                subjectKey: self.subjectKey(interfaceName: current.interfaceBSDName ?? previous.interfaceBSDName),
                evidence: [
                    "previous_gateway": previous.gatewayAddress ?? "-",
                    "current_gateway": current.gatewayAddress ?? "-"
                ],
                at: current.timestamp
            )
            forceSample = true
        }
        
        let previousDNS = previous.dnsServers.joined(separator: ",")
        let currentDNS = current.dnsServers.joined(separator: ",")
        if previousDNS != currentDNS, !previousDNS.isEmpty || !currentDNS.isEmpty {
            self.recordChangeMarker("dns", at: current.timestamp)
            self.store.recordEventIncident(
                type: "dns_servers_changed",
                severity: "info",
                title: localizedString("DNS servers changed"),
                summary: self.changeSummary(kind: "DNS servers", previous: previousDNS.isEmpty ? nil : previousDNS, current: currentDNS.isEmpty ? nil : currentDNS),
                subjectKey: self.subjectKey(interfaceName: current.interfaceBSDName ?? previous.interfaceBSDName),
                evidence: [
                    "previous_dns_servers": previousDNS.isEmpty ? "-" : previousDNS,
                    "current_dns_servers": currentDNS.isEmpty ? "-" : currentDNS
                ],
                at: current.timestamp
            )
            forceSample = true
        }
        
        return forceSample
    }
    
    private func handleConnectivityStatus(_ snapshot: DiagnosticsNetworkConnectivitySnapshot) {
        guard !snapshot.target.isEmpty else { return }
        
        if snapshot.reachable {
            self.downPendingCount = 0
            if let incidentID = self.downIncidentID {
                let failureUsage = self.lastUnreachableUsage ?? self.usage
                let failureSnapshot = self.lastUnreachableConnectivity ?? snapshot
                let cause = self.downIncidentCause ?? self.classifyNetworkCause(at: failureSnapshot.timestamp, connectivity: failureSnapshot)
                let duration = self.store.resolveIncident(
                    id: incidentID,
                    summary: self.durationSummary(
                        healthyText: "Internet connectivity restored",
                        startText: "Internet connectivity was unavailable",
                        at: snapshot.timestamp,
                        cause: cause?.summary
                    ),
                    at: snapshot.timestamp,
                    evidence: self.networkIncidentEvidence(
                        usage: failureUsage,
                        connectivity: failureSnapshot,
                        cause: cause,
                        recoveryConnectivity: snapshot
                    ).merging([
                        "recovery_mode": snapshot.mode,
                        "recovery_target": snapshot.target,
                        "latency_ms": self.formattedDouble(snapshot.latencyMs),
                        "jitter_ms": self.formattedDouble(snapshot.jitterMs)
                    ], uniquingKeysWith: { _, new in new })
                )
                if duration {
                    self.downIncidentID = nil
                    self.downIncidentCause = nil
                    self.lastUnreachableUsage = nil
                    self.lastUnreachableConnectivity = nil
                }
            }
            return
        }
        
        self.downPendingCount += 1
        let cause = self.classifyNetworkCause(at: snapshot.timestamp, connectivity: snapshot)
        self.captureDownIncidentCause(cause)
        guard self.downIncidentID == nil, self.downPendingCount >= self.downThreshold else { return }
        
        self.downIncidentID = self.store.openIncident(
            type: "internet_down",
            severity: "critical",
            title: localizedString("Internet connection lost"),
            summary: localizedString("Broad connectivity witnesses are failing while probing %0 via %1", snapshot.target, snapshot.mode.uppercased()),
            subjectKey: self.currentSubjectKey(),
            at: snapshot.timestamp,
            evidence: self.networkIncidentEvidence(usage: self.usage, connectivity: snapshot, cause: cause)
        )
        self.persistNetworkSampleIfNeeded(force: true)
    }
    
    private func handleLatency(_ snapshot: DiagnosticsNetworkConnectivitySnapshot) {
        guard !snapshot.target.isEmpty else { return }
        
        if !snapshot.reachable {
            self.latencyHighCount = 0
            self.latencyNormalCount = 0
            if let incidentID = self.latencyIncidentID {
                let resolved = self.store.resolveIncident(
                    id: incidentID,
                    summary: localizedString("Latency returned to normal after connectivity recovered"),
                    at: snapshot.timestamp,
                    evidence: ["latency_ms": self.formattedDouble(snapshot.latencyMs)]
                )
                if resolved {
                    self.latencyIncidentID = nil
                }
            }
            return
        }
        
        let isHigh = (snapshot.latencyMs ?? 0) >= self.highLatencyThresholdMs
        if isHigh {
            self.latencyHighCount += 1
            self.latencyNormalCount = 0
        } else {
            self.latencyHighCount = 0
            self.latencyNormalCount += 1
        }
        
        if self.latencyIncidentID == nil && isHigh && self.latencyHighCount >= self.metricTriggerCount {
            self.latencyIncidentID = self.store.openIncident(
                type: "high_latency",
                severity: "warning",
                title: localizedString("High latency detected"),
                summary: localizedString("Latency to %0 is above %1 ms", snapshot.target, "\(Int(self.highLatencyThresholdMs))"),
                subjectKey: self.currentSubjectKey(),
                at: snapshot.timestamp,
                evidence: [
                    "mode": snapshot.mode,
                    "target": snapshot.target,
                    "latency_ms": self.formattedDouble(snapshot.latencyMs),
                    "threshold_ms": "\(Int(self.highLatencyThresholdMs))"
                ]
            )
            self.persistNetworkSampleIfNeeded(force: true)
        } else if let incidentID = self.latencyIncidentID, !isHigh && self.latencyNormalCount >= self.metricRecoveryCount {
            let resolved = self.store.resolveIncident(
                id: incidentID,
                summary: localizedString("Latency recovered below %0 ms", "\(Int(self.highLatencyThresholdMs))"),
                at: snapshot.timestamp,
                evidence: ["latency_ms": self.formattedDouble(snapshot.latencyMs)]
            )
            if resolved {
                self.latencyIncidentID = nil
            }
        }
    }
    
    private func handleJitter(_ snapshot: DiagnosticsNetworkConnectivitySnapshot) {
        guard !snapshot.target.isEmpty else { return }
        
        if !snapshot.reachable {
            self.jitterHighCount = 0
            self.jitterNormalCount = 0
            if let incidentID = self.jitterIncidentID {
                let resolved = self.store.resolveIncident(
                    id: incidentID,
                    summary: localizedString("Jitter returned to normal after connectivity recovered"),
                    at: snapshot.timestamp,
                    evidence: ["jitter_ms": self.formattedDouble(snapshot.jitterMs)]
                )
                if resolved {
                    self.jitterIncidentID = nil
                }
            }
            return
        }
        
        let isHigh = (snapshot.jitterMs ?? 0) >= self.highJitterThresholdMs
        if isHigh {
            self.jitterHighCount += 1
            self.jitterNormalCount = 0
        } else {
            self.jitterHighCount = 0
            self.jitterNormalCount += 1
        }
        
        if self.jitterIncidentID == nil && isHigh && self.jitterHighCount >= self.metricTriggerCount {
            self.jitterIncidentID = self.store.openIncident(
                type: "high_jitter",
                severity: "warning",
                title: localizedString("High jitter detected"),
                summary: localizedString("Jitter to %0 is above %1 ms", snapshot.target, "\(Int(self.highJitterThresholdMs))"),
                subjectKey: self.currentSubjectKey(),
                at: snapshot.timestamp,
                evidence: [
                    "mode": snapshot.mode,
                    "target": snapshot.target,
                    "jitter_ms": self.formattedDouble(snapshot.jitterMs),
                    "threshold_ms": "\(Int(self.highJitterThresholdMs))"
                ]
            )
            self.persistNetworkSampleIfNeeded(force: true)
        } else if let incidentID = self.jitterIncidentID, !isHigh && self.jitterNormalCount >= self.metricRecoveryCount {
            let resolved = self.store.resolveIncident(
                id: incidentID,
                summary: localizedString("Jitter recovered below %0 ms", "\(Int(self.highJitterThresholdMs))"),
                at: snapshot.timestamp,
                evidence: ["jitter_ms": self.formattedDouble(snapshot.jitterMs)]
            )
            if resolved {
                self.jitterIncidentID = nil
            }
        }
    }
    
    private func recordFlapIncidentIfNeeded(at timestamp: Date) {
        guard self.flapTransitions.count >= self.flapTransitionThreshold else { return }
        if let last = self.lastFlapIncidentAt, timestamp.timeIntervalSince(last) < TimeInterval(self.flapWindowSeconds) {
            return
        }
        
        self.lastFlapIncidentAt = timestamp
        self.store.recordEventIncident(
            type: "network_flap",
            severity: "warning",
            title: localizedString("Network flapping detected"),
            summary: localizedString("Connectivity changed %0 times in the last %1 seconds", "\(self.flapTransitions.count)", "\(self.flapWindowSeconds)"),
            subjectKey: self.currentSubjectKey(),
            evidence: [
                "transitions": "\(self.flapTransitions.count)",
                "window_seconds": "\(self.flapWindowSeconds)"
            ],
            at: timestamp
        )
    }
    
    private func persistNetworkSampleIfNeeded(force: Bool) {
        let now = Date()
        guard force || now.timeIntervalSince(self.lastSampleWriteAt) >= self.sampleInterval else { return }
        
        let sample = DiagnosticsNetworkSampleRecord(
            timestamp: now,
            interfaceBSDName: self.usage?.interfaceBSDName,
            interfaceStatus: self.usage?.interfaceStatus,
            internetReachable: self.connectivity?.reachable ?? self.usage?.reachabilityStatus,
            connectionType: self.usage?.connectionType,
            connectivityMode: self.connectivity?.mode,
            connectivityTarget: self.connectivity?.target,
            latencyMs: self.connectivity?.latencyMs,
            jitterMs: self.connectivity?.jitterMs,
            reachabilityClass: self.connectivity?.reachabilityClass,
            quorumPassed: self.connectivity?.quorumPassed,
            primaryProbeTransport: self.connectivity?.primaryProbeTransport,
            primaryProbeTarget: self.connectivity?.primaryProbeTarget,
            primaryProbeReachable: self.connectivity?.primaryProbeReachable,
            primaryProbeFailureReason: self.connectivity?.primaryProbeFailureReason,
            localIPAddress: self.usage?.localIPAddress,
            publicIPAddress: self.usage?.publicIPAddress,
            gatewayAddress: self.usage?.gatewayAddress,
            dnsServers: self.usage?.dnsServers.joined(separator: ","),
            ssid: self.usage?.ssid,
            bssid: self.usage?.bssid,
            rssi: self.usage?.rssi,
            noise: self.usage?.noise,
            wifiStandard: self.usage?.wifiStandard,
            wifiMode: self.usage?.wifiMode,
            wifiSecurity: self.usage?.wifiSecurity,
            wifiChannel: self.usage?.wifiChannel,
            wifiChannelBand: self.usage?.wifiChannelBand,
            wifiChannelWidth: self.usage?.wifiChannelWidth,
            wifiChannelNumber: self.usage?.wifiChannelNumber,
            gatewayReachable: self.connectivity?.gatewayReachable,
            gatewayProbeFailureReason: self.connectivity?.gatewayProbeFailureReason,
            publicProbeTarget: self.connectivity?.publicProbeTarget,
            publicProbeReachable: self.connectivity?.publicProbeReachable,
            publicProbeFailureReason: self.connectivity?.publicProbeFailureReason,
            dnsProbeHost: self.connectivity?.dnsProbeHost,
            dnsResolved: self.connectivity?.dnsResolved,
            dnsFailureReason: self.connectivity?.dnsFailureReason,
            httpProbeTarget: self.connectivity?.httpProbeTarget,
            httpReachable: self.connectivity?.httpReachable,
            httpFailureReason: self.connectivity?.httpFailureReason,
            failureStage: self.connectivity?.failureStage,
            failureReason: self.connectivity?.failureReason,
            uploadBytesPerSecond: self.usage?.uploadBytesPerSecond ?? 0,
            downloadBytesPerSecond: self.usage?.downloadBytesPerSecond ?? 0
        )
        
        self.store.insertNetworkSample(sample)
        self.lastSampleWriteAt = now
        self.incrementWriteCounter()
    }
    
    private func mergeDiskSnapshot(_ snapshot: DiagnosticsDiskSnapshot) {
        let subjectKey = self.diskSubjectKey(snapshot.identifier)
        var state = self.diskStates[subjectKey] ?? DiagnosticsDiskRuntimeState(snapshot: snapshot)
        let previousSnapshot = state.snapshot
        let merged = self.mergedDiskSnapshot(previous: self.diskStates[subjectKey]?.snapshot, current: snapshot)
        
        state.snapshot = merged
        var forceSample = false
        
        if merged.mounted == true, merged.totalBytes != nil {
            forceSample = self.handleDiskLowSpace(subjectKey: subjectKey, state: &state) || forceSample
            forceSample = self.handleDiskTemperature(subjectKey: subjectKey, state: &state) || forceSample
            forceSample = self.handleDiskLife(subjectKey: subjectKey, previous: previousSnapshot, current: merged, state: &state) || forceSample
            forceSample = self.handleDiskRapidDrop(subjectKey: subjectKey, state: &state) || forceSample
        } else {
            state.lastRecordedLife = merged.smartLife ?? state.lastRecordedLife
        }
        
        self.persistDiskSampleIfNeeded(subjectKey: subjectKey, state: &state, force: forceSample)
        self.diskStates[subjectKey] = state
    }
    
    private func handleMissingDisk(subjectKey: String, at timestamp: Date) {
        guard var state = self.diskStates.removeValue(forKey: subjectKey) else { return }
        let name = state.snapshot.name ?? state.snapshot.identifier
        
        self.resolveDiskIncident(id: state.lowSpaceIncidentID, summary: localizedString("Disk %0 became unavailable", name), at: timestamp, evidence: [:])
        self.resolveDiskIncident(id: state.tempIncidentID, summary: localizedString("Disk %0 became unavailable", name), at: timestamp, evidence: [:])
        
        state.snapshot = self.mergedDiskSnapshot(
            previous: state.snapshot,
            current: DiagnosticsDiskSnapshot(
                timestamp: timestamp,
                identifier: state.snapshot.identifier,
                name: state.snapshot.name,
                mounted: false
            )
        )
        self.store.insertDiskSample(self.diskSampleRecord(from: state.snapshot))
        
        self.store.recordEventIncident(
            type: "disk_missing",
            subsystem: "disk",
            severity: "critical",
            title: localizedString("Disk became unavailable"),
            summary: localizedString("Disk %0 is no longer mounted", name),
            subjectKey: subjectKey,
            evidence: [
                "disk_name": name,
                "free_bytes": self.formattedInt64(state.snapshot.freeBytes),
                "utilization": self.formattedPercentage(state.snapshot.utilization)
            ],
            at: timestamp
        )
        
        self.incrementWriteCounter()
    }
    
    private func handleDiskLowSpace(subjectKey: String, state: inout DiagnosticsDiskRuntimeState) -> Bool {
        guard let utilization = state.snapshot.utilization else { return false }
        
        let isHigh = utilization >= self.lowDiskSpaceThreshold
        let name = state.snapshot.name ?? state.snapshot.identifier
        if isHigh && state.lowSpaceIncidentID == nil {
            state.lowSpaceIncidentID = self.store.openIncident(
                type: "disk_low_space",
                subsystem: "disk",
                severity: "warning",
                title: localizedString("Disk low on space"),
                summary: localizedString("Disk %0 is at %1%% utilization", name, "\(Int(utilization * 100))"),
                subjectKey: subjectKey,
                at: state.snapshot.timestamp,
                evidence: [
                    "disk_name": name,
                    "free_bytes": self.formattedInt64(state.snapshot.freeBytes),
                    "total_bytes": self.formattedInt64(state.snapshot.totalBytes),
                    "utilization": self.formattedPercentage(utilization)
                ]
            )
            return true
        }
        
        if !isHigh, let incidentID = state.lowSpaceIncidentID {
            let resolved = self.store.resolveIncident(
                id: incidentID,
                summary: localizedString("Disk %0 recovered below the low-space threshold", name),
                at: state.snapshot.timestamp,
                evidence: [
                    "free_bytes": self.formattedInt64(state.snapshot.freeBytes),
                    "utilization": self.formattedPercentage(utilization)
                ]
            )
            if resolved {
                state.lowSpaceIncidentID = nil
            }
        }
        
        return false
    }
    
    private func handleDiskTemperature(subjectKey: String, state: inout DiagnosticsDiskRuntimeState) -> Bool {
        guard let temperature = state.snapshot.smartTemperature else { return false }
        
        let isHigh = temperature >= self.smartTemperatureThreshold
        if isHigh {
            state.tempHighCount += 1
            state.tempNormalCount = 0
        } else {
            state.tempHighCount = 0
            state.tempNormalCount += 1
        }
        
        let name = state.snapshot.name ?? state.snapshot.identifier
        if state.tempIncidentID == nil && isHigh && state.tempHighCount >= self.metricTriggerCount {
            state.tempIncidentID = self.store.openIncident(
                type: "smart_temp_high",
                subsystem: "disk",
                severity: "warning",
                title: localizedString("Disk temperature is high"),
                summary: localizedString("SMART temperature for %0 reached %1 C", name, "\(temperature)"),
                subjectKey: subjectKey,
                at: state.snapshot.timestamp,
                evidence: [
                    "disk_name": name,
                    "temperature_c": "\(temperature)",
                    "threshold_c": "\(self.smartTemperatureThreshold)"
                ]
            )
            return true
        }
        
        if let incidentID = state.tempIncidentID, !isHigh && state.tempNormalCount >= self.metricRecoveryCount {
            let resolved = self.store.resolveIncident(
                id: incidentID,
                summary: localizedString("SMART temperature for %0 recovered below %1 C", name, "\(self.smartTemperatureThreshold)"),
                at: state.snapshot.timestamp,
                evidence: ["temperature_c": "\(temperature)"]
            )
            if resolved {
                state.tempIncidentID = nil
            }
        }
        
        return false
    }
    
    private func handleDiskLife(subjectKey: String, previous: DiagnosticsDiskSnapshot, current: DiagnosticsDiskSnapshot, state: inout DiagnosticsDiskRuntimeState) -> Bool {
        guard let currentLife = current.smartLife else { return false }
        
        defer { state.lastRecordedLife = currentLife }
        guard let previousLife = state.lastRecordedLife ?? previous.smartLife, currentLife < previousLife else { return false }
        
        self.store.recordEventIncident(
            type: "smart_life_drop",
            subsystem: "disk",
            severity: "warning",
            title: localizedString("Disk life estimate changed"),
            summary: localizedString("SMART life for %0 changed from %1%% to %2%%", current.name ?? current.identifier, "\(previousLife)", "\(currentLife)"),
            subjectKey: subjectKey,
            evidence: [
                "disk_name": current.name ?? current.identifier,
                "previous_life": "\(previousLife)",
                "current_life": "\(currentLife)"
            ],
            at: current.timestamp
        )
        return true
    }
    
    private func handleDiskRapidDrop(subjectKey: String, state: inout DiagnosticsDiskRuntimeState) -> Bool {
        guard let freeBytes = state.snapshot.freeBytes else { return false }
        
        state.freeHistory.append((state.snapshot.timestamp, freeBytes))
        state.freeHistory = state.freeHistory.filter {
            state.snapshot.timestamp.timeIntervalSince($0.0) <= TimeInterval(self.diskSpaceDropWindowSeconds)
        }
        
        guard let oldest = state.freeHistory.first else { return false }
        let thresholdBytes = self.diskSpaceDropThresholdGB * 1024 * 1024 * 1024
        let dropBytes = oldest.1 - freeBytes
        guard dropBytes >= thresholdBytes else { return false }
        if let last = state.lastRapidDropIncidentAt,
           state.snapshot.timestamp.timeIntervalSince(last) < TimeInterval(self.diskSpaceDropWindowSeconds) {
            return false
        }
        
        state.lastRapidDropIncidentAt = state.snapshot.timestamp
        self.store.recordEventIncident(
            type: "disk_space_dropping_fast",
            subsystem: "disk",
            severity: "warning",
            title: localizedString("Disk space is dropping quickly"),
            summary: localizedString("%0 lost %1 GB of free space within %2 seconds", state.snapshot.name ?? state.snapshot.identifier, "\(Int64(dropBytes / (1024 * 1024 * 1024)))", "\(self.diskSpaceDropWindowSeconds)"),
            subjectKey: subjectKey,
            evidence: [
                "disk_name": state.snapshot.name ?? state.snapshot.identifier,
                "previous_free_bytes": "\(oldest.1)",
                "current_free_bytes": "\(freeBytes)",
                "drop_bytes": "\(dropBytes)"
            ],
            at: state.snapshot.timestamp
        )
        return true
    }
    
    private func persistDiskSampleIfNeeded(subjectKey: String, state: inout DiagnosticsDiskRuntimeState, force: Bool) {
        let now = state.snapshot.timestamp
        guard force || now.timeIntervalSince(state.lastSampleWriteAt) >= self.diskSampleInterval else { return }
        
        self.store.insertDiskSample(self.diskSampleRecord(from: state.snapshot))
        state.lastSampleWriteAt = now
        self.incrementWriteCounter()
    }
    
    private func diskSampleRecord(from snapshot: DiagnosticsDiskSnapshot) -> DiagnosticsDiskSampleRecord {
        DiagnosticsDiskSampleRecord(
            timestamp: snapshot.timestamp,
            identifier: snapshot.identifier,
            name: snapshot.name,
            mounted: snapshot.mounted,
            freeBytes: snapshot.freeBytes,
            totalBytes: snapshot.totalBytes,
            utilization: snapshot.utilization,
            readBytesPerSecond: snapshot.readBytesPerSecond,
            writeBytesPerSecond: snapshot.writeBytesPerSecond,
            smartTemperature: snapshot.smartTemperature,
            smartLife: snapshot.smartLife,
            smartPowerCycles: snapshot.smartPowerCycles,
            smartPowerOnHours: snapshot.smartPowerOnHours
        )
    }
    
    private func mergedDiskSnapshot(previous: DiagnosticsDiskSnapshot?, current: DiagnosticsDiskSnapshot) -> DiagnosticsDiskSnapshot {
        DiagnosticsDiskSnapshot(
            timestamp: current.timestamp,
            identifier: current.identifier,
            name: current.name ?? previous?.name,
            mounted: current.mounted ?? previous?.mounted,
            totalBytes: current.totalBytes ?? previous?.totalBytes,
            freeBytes: current.freeBytes ?? previous?.freeBytes,
            utilization: current.utilization ?? previous?.utilization,
            readBytesPerSecond: current.readBytesPerSecond ?? previous?.readBytesPerSecond,
            writeBytesPerSecond: current.writeBytesPerSecond ?? previous?.writeBytesPerSecond,
            smartTemperature: current.smartTemperature ?? previous?.smartTemperature,
            smartLife: current.smartLife ?? previous?.smartLife,
            smartPowerCycles: current.smartPowerCycles ?? previous?.smartPowerCycles,
            smartPowerOnHours: current.smartPowerOnHours ?? previous?.smartPowerOnHours
        )
    }
    
    private func resolveDiskIncident(id: Int64?, summary: String, at timestamp: Date, evidence: [String: String]) {
        guard let id else { return }
        _ = self.store.resolveIncident(id: id, summary: summary, at: timestamp, evidence: evidence)
    }

    private func pollStorageSignalsIfNeeded(at timestamp: Date) {
        guard timestamp.timeIntervalSince(self.lastStorageSignalPollAt) >= self.storageSignalPollInterval else { return }

        self.lastStorageSignalPollAt = timestamp
        self.checkWatchedPaths(at: timestamp)
        self.scanUnifiedLogForVolumePermissionIssues(at: timestamp)
    }

    private func checkWatchedPaths(at timestamp: Date) {
        let watchedPaths = self.watchedVolumePaths
        let activeKeys = Set(watchedPaths)

        watchedPaths.forEach { path in
            let subjectKey = self.watchedPathSubjectKey(path)
            var state = self.watchedPathStates[path] ?? DiagnosticsWatchedPathRuntimeState()
            let probe = self.evaluateWatchedPath(path)
            let quotedPath = "\"\(path)\""

            if probe.exists {
                if let incidentID = state.missingIncidentID {
                    if self.store.resolveIncident(
                        id: incidentID,
                        summary: localizedString("Watched path %0 became available again", quotedPath),
                        at: timestamp,
                        evidence: [
                            "path": path,
                            "exists": "true",
                            "readable": self.formattedBool(probe.readable),
                            "error": probe.error ?? "-"
                        ]
                    ) {
                        state.missingIncidentID = nil
                    }
                }
            } else if state.missingIncidentID == nil {
                state.missingIncidentID = self.store.openIncident(
                    type: "watched_path_missing",
                    subsystem: "storage",
                    severity: "critical",
                    title: localizedString("Watched path is unavailable"),
                    summary: localizedString("Watched path %0 is missing", quotedPath),
                    subjectKey: subjectKey,
                    at: timestamp,
                    evidence: [
                        "path": path,
                        "exists": "false",
                        "readable": "false",
                        "error": probe.error ?? "-"
                    ]
                )
            }

            if probe.exists && probe.readable {
                if let incidentID = state.unreadableIncidentID {
                    if self.store.resolveIncident(
                        id: incidentID,
                        summary: localizedString("Watched path %0 is readable again", quotedPath),
                        at: timestamp,
                        evidence: [
                            "path": path,
                            "exists": "true",
                            "readable": "true",
                            "error": probe.error ?? "-"
                        ]
                    ) {
                        state.unreadableIncidentID = nil
                    }
                }
            } else if probe.exists && state.unreadableIncidentID == nil {
                state.unreadableIncidentID = self.store.openIncident(
                    type: "watched_path_unreadable",
                    subsystem: "storage",
                    severity: "warning",
                    title: localizedString("Watched path is unreadable"),
                    summary: localizedString("Watched path %0 exists but could not be read", quotedPath),
                    subjectKey: subjectKey,
                    at: timestamp,
                    evidence: [
                        "path": path,
                        "exists": "true",
                        "readable": "false",
                        "error": probe.error ?? "-"
                    ]
                )
            }

            state.exists = probe.exists
            state.readable = probe.readable
            self.watchedPathStates[path] = state
        }

        self.watchedPathStates.keys.filter { !activeKeys.contains($0) }.forEach { path in
            self.watchedPathStates.removeValue(forKey: path)
        }
    }

    private func evaluateWatchedPath(_ path: String) -> (exists: Bool, readable: Bool, error: String?) {
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        let exists = fileManager.fileExists(atPath: path, isDirectory: &isDirectory)
        guard exists else {
            return (false, false, nil)
        }

        do {
            _ = try fileManager.attributesOfItem(atPath: path)
            if isDirectory.boolValue {
                _ = try fileManager.contentsOfDirectory(atPath: path)
            }
            return (true, true, nil)
        } catch {
            return (true, false, error.localizedDescription)
        }
    }

    private func scanUnifiedLogForVolumePermissionIssues(at timestamp: Date) {
        guard self.permissionLogEnabled else { return }
        guard let output = self.runProcess(
            path: "/usr/bin/log",
            args: [
                "show",
                "--style", "compact",
                "--last", "\(self.permissionLogLookbackSeconds)s",
                "--predicate", "(process == \"tccd\" OR process == \"sandboxd\")"
            ]
        ) else {
            return
        }

        let watchedPaths = self.watchedVolumePaths
        output.enumerateLines { line, _ in
            let normalized = line.lowercased()
            let touchesVolumeAccess = normalized.contains("ktccservicesystempolicyremovablevolumes") || normalized.contains("ktccservicesystempolicyallfiles")
            let isFailure = normalized.contains("failed:") ||
                normalized.contains("denied") ||
                normalized.contains("not permitted") ||
                normalized.contains("operation not permitted") ||
                normalized.contains("missing 'auth_value'")

            guard touchesVolumeAccess, isFailure else { return }

            if let seenAt = self.recentPermissionEvents[line],
               timestamp.timeIntervalSince(seenAt) <= TimeInterval(self.permissionLogLookbackSeconds) {
                return
            }
            self.recentPermissionEvents[line] = timestamp

            let service = normalized.contains("ktccservicesystempolicyremovablevolumes")
                ? "SystemPolicyRemovableVolumes"
                : "SystemPolicyAllFiles"
            let bundleID = self.extractLogField(named: "identifier", from: line) ?? "-"
            let matchingPaths = watchedPaths.filter { line.contains($0) }
            let watchedPathText = matchingPaths.isEmpty ? watchedPaths.joined(separator: ",") : matchingPaths.joined(separator: ",")

            self.store.recordEventIncident(
                type: "volume_access_permission_failure",
                subsystem: "storage",
                severity: "warning",
                title: localizedString("Volume access permission issue"),
                summary: localizedString("%0 reported a permission or authorization failure for watched storage access", service),
                subjectKey: "permission:\(service)",
                evidence: [
                    "service": service,
                    "bundle_id": bundleID,
                    "watched_paths": watchedPathText.isEmpty ? "-" : watchedPathText,
                    "log_line": line
                ],
                at: self.extractLogTimestamp(from: line) ?? timestamp
            )
        }

        self.recentPermissionEvents = self.recentPermissionEvents.filter {
            timestamp.timeIntervalSince($0.value) <= 24 * 60 * 60
        }
    }

    private func extractLogField(named name: String, from line: String) -> String? {
        guard let range = line.range(of: "\(name)=") else { return nil }
        let suffix = line[range.upperBound...]
        let token = suffix.prefix { character in
            character != "," && character != "}" && !character.isWhitespace
        }
        return token.isEmpty ? nil : String(token)
    }

    private func extractLogTimestamp(from line: String) -> Date? {
        let prefix = String(line.prefix(23))
        guard prefix.count == 23 else { return nil }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter.date(from: prefix)
    }

    private func watchedPathSubjectKey(_ path: String) -> String {
        return "path:\(path)"
    }

    private func runProcess(path: String, args: [String]) -> String? {
        let task = Process()
        task.launchPath = path
        task.arguments = args

        let outputPipe = Pipe()
        defer {
            outputPipe.fileHandleForReading.closeFile()
        }
        task.standardOutput = outputPipe
        task.standardError = Pipe()

        do {
            try task.run()
        } catch {
            return nil
        }

        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        task.waitUntilExit()
        guard task.terminationStatus == 0 || !outputData.isEmpty else {
            return nil
        }
        return String(data: outputData, encoding: .utf8)
    }
    
    private func incrementWriteCounter() {
        self.writeCounter += 1
        if self.writeCounter % 30 == 0 {
            self.store.prune(
                networkRetentionHours: self.networkRetentionHours,
                diskRetentionDays: self.diskRetentionDays,
                incidentRetentionDays: self.incidentRetentionDays
            )
        }
    }
    
    private func resetState() {
        self.usage = nil
        self.connectivity = nil
        self.lastSampleWriteAt = .distantPast
        self.lastConnectivityStatus = nil
        self.flapTransitions.removeAll()
        self.lastFlapIncidentAt = nil
        self.changeMarkers.removeAll()
        self.lastUnreachableUsage = nil
        self.lastUnreachableConnectivity = nil
        self.downPendingCount = 0
        self.downIncidentID = nil
        self.downIncidentCause = nil
        self.latencyHighCount = 0
        self.latencyNormalCount = 0
        self.latencyIncidentID = nil
        self.jitterHighCount = 0
        self.jitterNormalCount = 0
        self.jitterIncidentID = nil
        self.diskStates.removeAll()
        self.watchedPathStates.removeAll()
        self.lastStorageSignalPollAt = .distantPast
        self.recentPermissionEvents.removeAll()
        self.writeCounter = 0
    }
    
    private func recordChangeMarker(_ key: String, at timestamp: Date) {
        self.changeMarkers[key] = timestamp
    }
    
    private func isRecentChange(_ key: String, at timestamp: Date) -> Bool {
        guard let marker = self.changeMarkers[key] else { return false }
        return timestamp.timeIntervalSince(marker) <= TimeInterval(self.correlationWindowSeconds)
    }
    
    private func recentChangeLabels(at timestamp: Date) -> [String] {
        let labels = [
            ("interface", localizedString("interface changed")),
            ("local_ip", localizedString("local IP changed")),
            ("public_ip", localizedString("public IP changed")),
            ("ssid", localizedString("Wi-Fi network changed")),
            ("bssid", localizedString("Wi-Fi access point changed")),
            ("gateway", localizedString("gateway changed")),
            ("dns", localizedString("DNS servers changed"))
        ]
        return labels.compactMap { self.isRecentChange($0.0, at: timestamp) ? $0.1 : nil }
    }
    
    private func captureDownIncidentCause(_ cause: NetworkCauseClassification?) {
        guard let cause else { return }
        guard let current = self.downIncidentCause else {
            self.downIncidentCause = cause
            return
        }
        if cause.rank >= current.rank {
            self.downIncidentCause = cause
        }
    }
    
    private func classifyNetworkCause(
        at timestamp: Date,
        connectivity: DiagnosticsNetworkConnectivitySnapshot?
    ) -> NetworkCauseClassification? {
        guard self.downIncidentID != nil || connectivity?.reachable == false else { return nil }
        
        var candidates: [NetworkCauseClassification] = []
        let recentChanges = self.recentChangeLabels(at: timestamp)
        let recentChangeSummary = recentChanges.isEmpty ? nil : recentChanges.joined(separator: ", ")
        
        if self.usage?.interfaceStatus == false {
            candidates.append(NetworkCauseClassification(
                code: "interface_down",
                summary: localizedString("The active network interface went down during the outage."),
                rank: 100,
                evidence: ["cause_code": "interface_down"]
            ))
        }
        
        if self.usage?.connectionType == "wifi" {
            if self.isRecentChange("bssid", at: timestamp) {
                candidates.append(NetworkCauseClassification(
                    code: "wifi_access_point_changed",
                    summary: localizedString("The Mac switched Wi-Fi access points just before connectivity was lost."),
                    rank: 95,
                    evidence: ["cause_code": "wifi_access_point_changed"]
                ))
            } else if self.isRecentChange("ssid", at: timestamp) {
                candidates.append(NetworkCauseClassification(
                    code: "wifi_network_changed",
                    summary: localizedString("The Mac switched Wi-Fi networks just before connectivity was lost."),
                    rank: 92,
                    evidence: ["cause_code": "wifi_network_changed"]
                ))
            }
            
            if self.hasWeakWiFiSignal(self.usage) {
                candidates.append(NetworkCauseClassification(
                    code: "weak_wifi_signal",
                    summary: localizedString("Wi-Fi signal quality was poor during the outage."),
                    rank: 70,
                    evidence: [
                        "cause_code": "weak_wifi_signal",
                        "rssi": self.usage?.rssi.map { "\($0)" } ?? "-",
                        "noise": self.usage?.noise.map { "\($0)" } ?? "-"
                    ]
                ))
            }
        }
        
        if self.isRecentChange("local_ip", at: timestamp) || self.isRecentChange("gateway", at: timestamp) || self.isRecentChange("dns", at: timestamp) {
            candidates.append(NetworkCauseClassification(
                code: "network_reconfigured",
                summary: localizedString("Local network routing or addressing changed just before connectivity was lost."),
                rank: 88,
                evidence: ["cause_code": "network_reconfigured"]
            ))
        }
        
        if let connectivity {
            if connectivity.quorumPassed == true && connectivity.primaryProbeReachable == false {
                let code: String
                let summary: String
                switch connectivity.reachabilityClass {
                case "dns_failure":
                    code = "dns_failure"
                    summary = localizedString("The primary target failed, but broader internet checks show DNS-specific trouble.")
                case "http_failure":
                    code = "http_failure"
                    summary = localizedString("The primary target failed, but broader internet checks show an HTTP-specific issue.")
                case "partial_outage":
                    code = "partial_outage"
                    summary = localizedString("The primary target failed, but at least one broader internet witness still succeeded.")
                default:
                    code = "probe_target_failure"
                    summary = localizedString("The configured probe target failed while broader internet checks still passed.")
                }
                candidates.append(NetworkCauseClassification(
                    code: code,
                    summary: summary,
                    rank: 96,
                    evidence: ["cause_code": code]
                ))
            }

            if connectivity.gatewayReachable == false {
                candidates.append(NetworkCauseClassification(
                    code: "gateway_unreachable",
                    summary: localizedString("The default gateway path was unavailable during the outage."),
                    rank: 84,
                    evidence: ["cause_code": "gateway_unreachable"]
                ))
            }
            
            if connectivity.quorumPassed != true && connectivity.publicProbeReachable == false {
                candidates.append(NetworkCauseClassification(
                    code: "upstream_unreachable",
                    summary: localizedString("The local link stayed up, but upstream internet reachability failed."),
                    rank: 80,
                    evidence: ["cause_code": "upstream_unreachable"]
                ))
            }
            
            if connectivity.dnsResolved == false && (connectivity.publicProbeReachable == true || connectivity.httpReachable == true) {
                candidates.append(NetworkCauseClassification(
                    code: "dns_failure",
                    summary: localizedString("Public IP reachability stayed up, but DNS resolution failed."),
                    rank: 82,
                    evidence: ["cause_code": "dns_failure"]
                ))
            }
            
            if connectivity.httpReachable == false && connectivity.publicProbeReachable == true && connectivity.dnsResolved == true {
                candidates.append(NetworkCauseClassification(
                    code: "http_failure",
                    summary: localizedString("Raw connectivity stayed up, but HTTP checks still failed."),
                    rank: 75,
                    evidence: ["cause_code": "http_failure"]
                ))
            }
            
            if connectivity.publicProbeReachable == true &&
                connectivity.dnsResolved == true &&
                connectivity.httpReachable == true &&
                connectivity.failureStage == "probe_target" {
                candidates.append(NetworkCauseClassification(
                    code: "probe_target_failure",
                    summary: localizedString("The configured probe target failed while broader internet checks still succeeded."),
                    rank: 78,
                    evidence: ["cause_code": "probe_target_failure"]
                ))
            }
        }
        
        guard var best = candidates.max(by: { $0.rank < $1.rank }) else {
            return nil
        }
        if let recentChangeSummary, best.evidence["recent_changes"] == nil {
            var evidence = best.evidence
            evidence["recent_changes"] = recentChangeSummary
            best = NetworkCauseClassification(code: best.code, summary: best.summary, rank: best.rank, evidence: evidence)
        }
        return best
    }
    
    private func hasWeakWiFiSignal(_ usage: DiagnosticsNetworkUsageSnapshot?) -> Bool {
        guard let usage,
              usage.connectionType == "wifi",
              let rssi = usage.rssi,
              let noise = usage.noise else {
            return false
        }
        return rssi <= self.weakWiFiRSSIThreshold || (rssi - noise) <= self.weakWiFiSNRThreshold
    }
    
    private func changeSummary(kind: String, previous: String?, current: String?) -> String {
        let oldValue = previous ?? localizedString("Unknown")
        let newValue = current ?? localizedString("Unknown")
        return localizedString("The %0 changed from %1 to %2", kind, oldValue, newValue)
    }
    
    private func subjectKey(interfaceName: String?) -> String {
        return "network:\(interfaceName ?? "unknown")"
    }
    
    private func currentSubjectKey() -> String {
        return self.subjectKey(interfaceName: self.usage?.interfaceBSDName)
    }
    
    private func diskSubjectKey(_ identifier: String) -> String {
        return "disk:\(identifier)"
    }
    
    private func formattedDouble(_ value: Double?) -> String {
        guard let value else { return "-" }
        return String(format: "%.2f", value)
    }
    
    private func formattedPercentage(_ value: Double?) -> String {
        guard let value else { return "-" }
        return String(format: "%.2f%%", value * 100)
    }
    
    private func formattedInt64(_ value: Int64?) -> String {
        guard let value else { return "-" }
        return "\(value)"
    }
    
    private func networkIncidentEvidence(
        usage: DiagnosticsNetworkUsageSnapshot?,
        connectivity: DiagnosticsNetworkConnectivitySnapshot,
        cause: NetworkCauseClassification?,
        recoveryConnectivity: DiagnosticsNetworkConnectivitySnapshot? = nil
    ) -> [String: String] {
        let dnsServers = usage?.dnsServers.joined(separator: ",") ?? ""
        var evidence: [String: String] = [
            "mode": connectivity.mode,
            "target": connectivity.target,
            "latency_ms": self.formattedDouble(connectivity.latencyMs),
            "jitter_ms": self.formattedDouble(connectivity.jitterMs),
            "reachability_class": connectivity.reachabilityClass ?? "-",
            "quorum_passed": self.formattedBool(connectivity.quorumPassed),
            "primary_probe_transport": connectivity.primaryProbeTransport ?? "-",
            "primary_probe_target": connectivity.primaryProbeTarget ?? "-",
            "primary_probe_reachable": self.formattedBool(connectivity.primaryProbeReachable),
            "primary_probe_failure_reason": connectivity.primaryProbeFailureReason ?? "-",
            "connection_type": usage?.connectionType ?? "-",
            "local_ip": usage?.localIPAddress ?? "-",
            "public_ip": usage?.publicIPAddress ?? "-",
            "gateway": usage?.gatewayAddress ?? "-",
            "dns_servers": dnsServers.isEmpty ? "-" : dnsServers,
            "ssid": usage?.ssid ?? "-",
            "bssid": usage?.bssid ?? "-",
            "rssi": usage?.rssi.map { "\($0)" } ?? "-",
            "noise": usage?.noise.map { "\($0)" } ?? "-",
            "wifi_channel": usage?.wifiChannel ?? "-",
            "gateway_reachable": self.formattedBool(connectivity.gatewayReachable),
            "gateway_probe_failure_reason": connectivity.gatewayProbeFailureReason ?? "-",
            "public_probe_target": connectivity.publicProbeTarget ?? "-",
            "public_probe_reachable": self.formattedBool(connectivity.publicProbeReachable),
            "public_probe_failure_reason": connectivity.publicProbeFailureReason ?? "-",
            "dns_probe_host": connectivity.dnsProbeHost ?? "-",
            "dns_resolved": self.formattedBool(connectivity.dnsResolved),
            "dns_failure_reason": connectivity.dnsFailureReason ?? "-",
            "http_probe_target": connectivity.httpProbeTarget ?? "-",
            "http_reachable": self.formattedBool(connectivity.httpReachable),
            "http_failure_reason": connectivity.httpFailureReason ?? "-",
            "failure_stage": connectivity.failureStage ?? "-",
            "failure_reason": connectivity.failureReason ?? "-"
        ]
        
        if let recoveryConnectivity {
            evidence["recovery_latency_ms"] = self.formattedDouble(recoveryConnectivity.latencyMs)
            evidence["recovery_jitter_ms"] = self.formattedDouble(recoveryConnectivity.jitterMs)
        }
        if let cause {
            evidence["probable_cause"] = cause.summary
            cause.evidence.forEach { evidence[$0.key] = $0.value }
        }
        
        return evidence
    }
    
    private func formattedBool(_ value: Bool?) -> String {
        guard let value else { return "-" }
        return value ? "true" : "false"
    }
    
    private func durationSummary(healthyText: String, startText: String, at endAt: Date, cause: String? = nil) -> String {
        guard let startedAt = self.store.startedAt(for: self.downIncidentID) else {
            return localizedString(healthyText)
        }
        
        let duration = max(Int(endAt.timeIntervalSince(startedAt)), 0)
        let base = localizedString("%0 for %1 seconds", startText, "\(duration)")
        guard let cause, !cause.isEmpty else {
            return base
        }
        return "\(base) \(localizedString("Likely cause:")) \(cause)"
    }
}

private struct DiagnosticsNetworkSampleRecord: Codable {
    let timestamp: Date
    let interfaceBSDName: String?
    let interfaceStatus: Bool?
    let internetReachable: Bool?
    let connectionType: String?
    let connectivityMode: String?
    let connectivityTarget: String?
    let latencyMs: Double?
    let jitterMs: Double?
    let reachabilityClass: String?
    let quorumPassed: Bool?
    let primaryProbeTransport: String?
    let primaryProbeTarget: String?
    let primaryProbeReachable: Bool?
    let primaryProbeFailureReason: String?
    let localIPAddress: String?
    let publicIPAddress: String?
    let gatewayAddress: String?
    let dnsServers: String?
    let ssid: String?
    let bssid: String?
    let rssi: Int?
    let noise: Int?
    let wifiStandard: String?
    let wifiMode: String?
    let wifiSecurity: String?
    let wifiChannel: String?
    let wifiChannelBand: String?
    let wifiChannelWidth: String?
    let wifiChannelNumber: String?
    let gatewayReachable: Bool?
    let gatewayProbeFailureReason: String?
    let publicProbeTarget: String?
    let publicProbeReachable: Bool?
    let publicProbeFailureReason: String?
    let dnsProbeHost: String?
    let dnsResolved: Bool?
    let dnsFailureReason: String?
    let httpProbeTarget: String?
    let httpReachable: Bool?
    let httpFailureReason: String?
    let failureStage: String?
    let failureReason: String?
    let uploadBytesPerSecond: Int64
    let downloadBytesPerSecond: Int64
}

private struct DiagnosticsDiskSampleRecord: Codable {
    let timestamp: Date
    let identifier: String
    let name: String?
    let mounted: Bool?
    let freeBytes: Int64?
    let totalBytes: Int64?
    let utilization: Double?
    let readBytesPerSecond: Int64?
    let writeBytesPerSecond: Int64?
    let smartTemperature: Int?
    let smartLife: Int?
    let smartPowerCycles: Int?
    let smartPowerOnHours: Int?
}

private struct DiagnosticsIncidentEvidenceRecord: Codable {
    let timestamp: Date
    let key: String
    let value: String
}

private struct DiagnosticsIncidentRecord: Codable {
    let id: Int64
    let type: String
    let subsystem: String
    let severity: String
    let status: String
    let title: String
    let summary: String
    let subjectKey: String
    let startedAt: Date
    let endedAt: Date?
    let evidence: [DiagnosticsIncidentEvidenceRecord]
}

private struct DiagnosticsExportPayload: Codable {
    let exportedAt: Date
    let incidents: [DiagnosticsIncidentRecord]
    let networkSamples: [DiagnosticsNetworkSampleRecord]
    let diskSamples: [DiagnosticsDiskSampleRecord]
}

private final class DiagnosticsStore {
    private var db: OpaquePointer?
    private var incidentStartCache: [Int64: Date] = [:]
    
    init() {
        self.open()
        self.createTables()
        self.migrateTables()
        self.prune(networkRetentionHours: 24, diskRetentionDays: 7, incidentRetentionDays: 90)
    }
    
    deinit {
        if let db = self.db {
            sqlite3_close(db)
        }
    }
    
    func insertNetworkSample(_ sample: DiagnosticsNetworkSampleRecord) {
        let sql = """
        INSERT INTO network_samples (
            ts, interface_bsd, interface_status, internet_reachable, connection_type,
            connectivity_mode, connectivity_target, latency_ms, jitter_ms, reachability_class,
            quorum_passed, primary_probe_transport, primary_probe_target, primary_probe_reachable, primary_probe_failure_reason,
            local_ip, public_ip, gateway_address, dns_servers, ssid,
            bssid, rssi, noise, wifi_standard, wifi_mode,
            wifi_security, wifi_channel, wifi_channel_band, wifi_channel_width, wifi_channel_number,
            gateway_reachable, gateway_probe_failure_reason, public_probe_target, public_probe_reachable, public_probe_failure_reason,
            dns_probe_host, dns_resolved, dns_failure_reason, http_probe_target, http_reachable,
            http_failure_reason, failure_stage, failure_reason, upload_bps, download_bps
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        """
        
        self.withStatement(sql) { statement in
            self.bind(int64: self.timestamp(sample.timestamp), index: 1, statement: statement)
            self.bind(text: sample.interfaceBSDName, index: 2, statement: statement)
            self.bind(bool: sample.interfaceStatus, index: 3, statement: statement)
            self.bind(bool: sample.internetReachable, index: 4, statement: statement)
            self.bind(text: sample.connectionType, index: 5, statement: statement)
            self.bind(text: sample.connectivityMode, index: 6, statement: statement)
            self.bind(text: sample.connectivityTarget, index: 7, statement: statement)
            self.bind(double: sample.latencyMs, index: 8, statement: statement)
            self.bind(double: sample.jitterMs, index: 9, statement: statement)
            self.bind(text: sample.reachabilityClass, index: 10, statement: statement)
            self.bind(bool: sample.quorumPassed, index: 11, statement: statement)
            self.bind(text: sample.primaryProbeTransport, index: 12, statement: statement)
            self.bind(text: sample.primaryProbeTarget, index: 13, statement: statement)
            self.bind(bool: sample.primaryProbeReachable, index: 14, statement: statement)
            self.bind(text: sample.primaryProbeFailureReason, index: 15, statement: statement)
            self.bind(text: sample.localIPAddress, index: 16, statement: statement)
            self.bind(text: sample.publicIPAddress, index: 17, statement: statement)
            self.bind(text: sample.gatewayAddress, index: 18, statement: statement)
            self.bind(text: sample.dnsServers, index: 19, statement: statement)
            self.bind(text: sample.ssid, index: 20, statement: statement)
            self.bind(text: sample.bssid, index: 21, statement: statement)
            self.bind(int64: sample.rssi.map(Int64.init), index: 22, statement: statement)
            self.bind(int64: sample.noise.map(Int64.init), index: 23, statement: statement)
            self.bind(text: sample.wifiStandard, index: 24, statement: statement)
            self.bind(text: sample.wifiMode, index: 25, statement: statement)
            self.bind(text: sample.wifiSecurity, index: 26, statement: statement)
            self.bind(text: sample.wifiChannel, index: 27, statement: statement)
            self.bind(text: sample.wifiChannelBand, index: 28, statement: statement)
            self.bind(text: sample.wifiChannelWidth, index: 29, statement: statement)
            self.bind(text: sample.wifiChannelNumber, index: 30, statement: statement)
            self.bind(bool: sample.gatewayReachable, index: 31, statement: statement)
            self.bind(text: sample.gatewayProbeFailureReason, index: 32, statement: statement)
            self.bind(text: sample.publicProbeTarget, index: 33, statement: statement)
            self.bind(bool: sample.publicProbeReachable, index: 34, statement: statement)
            self.bind(text: sample.publicProbeFailureReason, index: 35, statement: statement)
            self.bind(text: sample.dnsProbeHost, index: 36, statement: statement)
            self.bind(bool: sample.dnsResolved, index: 37, statement: statement)
            self.bind(text: sample.dnsFailureReason, index: 38, statement: statement)
            self.bind(text: sample.httpProbeTarget, index: 39, statement: statement)
            self.bind(bool: sample.httpReachable, index: 40, statement: statement)
            self.bind(text: sample.httpFailureReason, index: 41, statement: statement)
            self.bind(text: sample.failureStage, index: 42, statement: statement)
            self.bind(text: sample.failureReason, index: 43, statement: statement)
            self.bind(int64: sample.uploadBytesPerSecond, index: 44, statement: statement)
            self.bind(int64: sample.downloadBytesPerSecond, index: 45, statement: statement)
            sqlite3_step(statement)
        }
    }
    
    func insertDiskSample(_ sample: DiagnosticsDiskSampleRecord) {
        let sql = """
        INSERT INTO disk_samples (
            ts, disk_uuid, disk_name, mounted, free_bytes, total_bytes, utilization,
            read_bps, write_bps, smart_temperature, smart_life, smart_power_cycles, smart_power_on_hours
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        """
        
        self.withStatement(sql) { statement in
            self.bind(int64: self.timestamp(sample.timestamp), index: 1, statement: statement)
            self.bind(text: sample.identifier, index: 2, statement: statement)
            self.bind(text: sample.name, index: 3, statement: statement)
            self.bind(bool: sample.mounted, index: 4, statement: statement)
            self.bind(int64: sample.freeBytes, index: 5, statement: statement)
            self.bind(int64: sample.totalBytes, index: 6, statement: statement)
            self.bind(double: sample.utilization, index: 7, statement: statement)
            self.bind(int64: sample.readBytesPerSecond, index: 8, statement: statement)
            self.bind(int64: sample.writeBytesPerSecond, index: 9, statement: statement)
            self.bind(int64: sample.smartTemperature.map(Int64.init), index: 10, statement: statement)
            self.bind(int64: sample.smartLife.map(Int64.init), index: 11, statement: statement)
            self.bind(int64: sample.smartPowerCycles.map(Int64.init), index: 12, statement: statement)
            self.bind(int64: sample.smartPowerOnHours.map(Int64.init), index: 13, statement: statement)
            sqlite3_step(statement)
        }
    }
    
    func openIncident(
        type: String,
        subsystem: String = "network",
        severity: String,
        title: String,
        summary: String,
        subjectKey: String,
        at timestamp: Date,
        evidence: [String: String]
    ) -> Int64? {
        let sql = """
        INSERT INTO incidents (
            type, subsystem, severity, status, title, summary, subject_key, started_at
        ) VALUES (?, ?, ?, 'open', ?, ?, ?, ?);
        """
        
        var incidentID: Int64?
        self.withStatement(sql) { statement in
            self.bind(text: type, index: 1, statement: statement)
            self.bind(text: subsystem, index: 2, statement: statement)
            self.bind(text: severity, index: 3, statement: statement)
            self.bind(text: title, index: 4, statement: statement)
            self.bind(text: summary, index: 5, statement: statement)
            self.bind(text: subjectKey, index: 6, statement: statement)
            self.bind(int64: self.timestamp(timestamp), index: 7, statement: statement)
            if sqlite3_step(statement) == SQLITE_DONE {
                incidentID = sqlite3_last_insert_rowid(self.db)
            }
        }
        
        if let incidentID {
            self.incidentStartCache[incidentID] = timestamp
            self.insertEvidence(incidentID: incidentID, evidence: evidence, at: timestamp)
        }
        
        return incidentID
    }
    
    func recordEventIncident(
        type: String,
        subsystem: String = "network",
        severity: String,
        title: String,
        summary: String,
        subjectKey: String,
        evidence: [String: String],
        at timestamp: Date
    ) {
        let sql = """
        INSERT INTO incidents (
            type, subsystem, severity, status, title, summary, subject_key, started_at, ended_at
        ) VALUES (?, ?, ?, 'resolved', ?, ?, ?, ?, ?);
        """
        
        var incidentID: Int64?
        self.withStatement(sql) { statement in
            self.bind(text: type, index: 1, statement: statement)
            self.bind(text: subsystem, index: 2, statement: statement)
            self.bind(text: severity, index: 3, statement: statement)
            self.bind(text: title, index: 4, statement: statement)
            self.bind(text: summary, index: 5, statement: statement)
            self.bind(text: subjectKey, index: 6, statement: statement)
            let timestampValue = self.timestamp(timestamp)
            self.bind(int64: timestampValue, index: 7, statement: statement)
            self.bind(int64: timestampValue, index: 8, statement: statement)
            if sqlite3_step(statement) == SQLITE_DONE {
                incidentID = sqlite3_last_insert_rowid(self.db)
            }
        }
        
        if let incidentID {
            self.insertEvidence(incidentID: incidentID, evidence: evidence, at: timestamp)
        }
    }
    
    func resolveIncident(id: Int64, summary: String, at timestamp: Date, evidence: [String: String]) -> Bool {
        let sql = """
        UPDATE incidents
        SET status = 'resolved', ended_at = ?, summary = ?
        WHERE id = ? AND status = 'open';
        """
        
        var updated = false
        self.withStatement(sql) { statement in
            self.bind(int64: self.timestamp(timestamp), index: 1, statement: statement)
            self.bind(text: summary, index: 2, statement: statement)
            self.bind(int64: id, index: 3, statement: statement)
            if sqlite3_step(statement) == SQLITE_DONE {
                updated = sqlite3_changes(self.db) > 0
            }
        }
        
        if updated {
            self.insertEvidence(incidentID: id, evidence: evidence, at: timestamp)
        }
        return updated
    }
    
    func startedAt(for incidentID: Int64?) -> Date? {
        guard let incidentID else { return nil }
        if let value = self.incidentStartCache[incidentID] {
            return value
        }
        
        let sql = "SELECT started_at FROM incidents WHERE id = ? LIMIT 1;"
        var result: Date?
        self.withStatement(sql) { statement in
            self.bind(int64: incidentID, index: 1, statement: statement)
            if sqlite3_step(statement) == SQLITE_ROW {
                result = self.date(from: sqlite3_column_int64(statement, 0))
            }
        }
        if let result {
            self.incidentStartCache[incidentID] = result
        }
        return result
    }
    
    func snapshot(incidentLimit: Int, networkSampleLimit: Int, diskSampleLimit: Int) -> DiagnosticsSnapshotData {
        DiagnosticsSnapshotData(
            generatedAt: Date(),
            incidents: self.fetchIncidents(limit: incidentLimit).map {
                DiagnosticsIncidentSummary(
                    id: $0.id,
                    type: $0.type,
                    subsystem: $0.subsystem,
                    severity: $0.severity,
                    status: $0.status,
                    title: $0.title,
                    summary: $0.summary,
                    subjectKey: $0.subjectKey,
                    startedAt: $0.startedAt,
                    endedAt: $0.endedAt,
                    evidence: $0.evidence.map {
                        DiagnosticsIncidentEvidence(timestamp: $0.timestamp, key: $0.key, value: $0.value)
                    }
                )
            },
            networkSamples: self.fetchNetworkSamples(limit: networkSampleLimit).map {
                DiagnosticsNetworkSampleSummary(
                    timestamp: $0.timestamp,
                    interfaceBSDName: $0.interfaceBSDName,
                    interfaceStatus: $0.interfaceStatus,
                    internetReachable: $0.internetReachable,
                    connectionType: $0.connectionType,
                    connectivityMode: $0.connectivityMode,
                    connectivityTarget: $0.connectivityTarget,
                    latencyMs: $0.latencyMs,
                    jitterMs: $0.jitterMs,
                    reachabilityClass: $0.reachabilityClass,
                    quorumPassed: $0.quorumPassed,
                    primaryProbeTransport: $0.primaryProbeTransport,
                    primaryProbeTarget: $0.primaryProbeTarget,
                    primaryProbeReachable: $0.primaryProbeReachable,
                    primaryProbeFailureReason: $0.primaryProbeFailureReason,
                    localIPAddress: $0.localIPAddress,
                    publicIPAddress: $0.publicIPAddress,
                    gatewayAddress: $0.gatewayAddress,
                    dnsServers: $0.dnsServers,
                    ssid: $0.ssid,
                    bssid: $0.bssid,
                    rssi: $0.rssi,
                    noise: $0.noise,
                    wifiStandard: $0.wifiStandard,
                    wifiMode: $0.wifiMode,
                    wifiSecurity: $0.wifiSecurity,
                    wifiChannel: $0.wifiChannel,
                    wifiChannelBand: $0.wifiChannelBand,
                    wifiChannelWidth: $0.wifiChannelWidth,
                    wifiChannelNumber: $0.wifiChannelNumber,
                    gatewayReachable: $0.gatewayReachable,
                    gatewayProbeFailureReason: $0.gatewayProbeFailureReason,
                    publicProbeTarget: $0.publicProbeTarget,
                    publicProbeReachable: $0.publicProbeReachable,
                    publicProbeFailureReason: $0.publicProbeFailureReason,
                    dnsProbeHost: $0.dnsProbeHost,
                    dnsResolved: $0.dnsResolved,
                    dnsFailureReason: $0.dnsFailureReason,
                    httpProbeTarget: $0.httpProbeTarget,
                    httpReachable: $0.httpReachable,
                    httpFailureReason: $0.httpFailureReason,
                    failureStage: $0.failureStage,
                    failureReason: $0.failureReason,
                    uploadBytesPerSecond: $0.uploadBytesPerSecond,
                    downloadBytesPerSecond: $0.downloadBytesPerSecond
                )
            },
            diskSamples: self.fetchDiskSamples(limit: diskSampleLimit).map {
                DiagnosticsDiskSampleSummary(
                    timestamp: $0.timestamp,
                    identifier: $0.identifier,
                    name: $0.name,
                    mounted: $0.mounted,
                    freeBytes: $0.freeBytes,
                    totalBytes: $0.totalBytes,
                    utilization: $0.utilization,
                    readBytesPerSecond: $0.readBytesPerSecond,
                    writeBytesPerSecond: $0.writeBytesPerSecond,
                    smartTemperature: $0.smartTemperature,
                    smartLife: $0.smartLife,
                    smartPowerCycles: $0.smartPowerCycles,
                    smartPowerOnHours: $0.smartPowerOnHours
                )
            }
        )
    }
    
    func export(to url: URL) -> Bool {
        let payload = DiagnosticsExportPayload(
            exportedAt: Date(),
            incidents: self.fetchIncidents(),
            networkSamples: self.fetchNetworkSamples(),
            diskSamples: self.fetchDiskSamples()
        )
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        
        guard let data = try? encoder.encode(payload) else { return false }
        do {
            try data.write(to: url, options: .atomic)
            return true
        } catch {
            return false
        }
    }
    
    func clear() -> Bool {
        let queries = [
            "DELETE FROM incident_evidence;",
            "DELETE FROM incidents;",
            "DELETE FROM network_samples;",
            "DELETE FROM disk_samples;"
        ]
        self.incidentStartCache.removeAll()
        return queries.reduce(true) { partialResult, query in
            partialResult && self.execute(query)
        }
    }
    
    func prune(networkRetentionHours: Int, diskRetentionDays: Int, incidentRetentionDays: Int) {
        let now = Int64(Date().timeIntervalSince1970)
        let networkSampleCutoff = now - Int64(networkRetentionHours * 60 * 60)
        let diskSampleCutoff = now - Int64(diskRetentionDays * 24 * 60 * 60)
        let incidentCutoff = now - Int64(incidentRetentionDays * 24 * 60 * 60)
        
        let networkSampleSQL = "DELETE FROM network_samples WHERE ts < ?;"
        self.withStatement(networkSampleSQL) { statement in
            self.bind(int64: networkSampleCutoff, index: 1, statement: statement)
            sqlite3_step(statement)
        }
        
        let diskSampleSQL = "DELETE FROM disk_samples WHERE ts < ?;"
        self.withStatement(diskSampleSQL) { statement in
            self.bind(int64: diskSampleCutoff, index: 1, statement: statement)
            sqlite3_step(statement)
        }
        
        let evidenceSQL = """
        DELETE FROM incident_evidence
        WHERE incident_id IN (
            SELECT id FROM incidents
            WHERE COALESCE(ended_at, started_at) < ?
        );
        """
        self.withStatement(evidenceSQL) { statement in
            self.bind(int64: incidentCutoff, index: 1, statement: statement)
            sqlite3_step(statement)
        }
        
        let incidentSQL = "DELETE FROM incidents WHERE COALESCE(ended_at, started_at) < ?;"
        self.withStatement(incidentSQL) { statement in
            self.bind(int64: incidentCutoff, index: 1, statement: statement)
            sqlite3_step(statement)
        }
    }
    
    private func fetchNetworkSamples(limit: Int? = nil) -> [DiagnosticsNetworkSampleRecord] {
        let sql = """
        SELECT
            ts, interface_bsd, interface_status, internet_reachable, connection_type,
            connectivity_mode, connectivity_target, latency_ms, jitter_ms, reachability_class,
            quorum_passed, primary_probe_transport, primary_probe_target, primary_probe_reachable, primary_probe_failure_reason,
            local_ip, public_ip, gateway_address, dns_servers, ssid,
            bssid, rssi, noise, wifi_standard, wifi_mode,
            wifi_security, wifi_channel, wifi_channel_band, wifi_channel_width, wifi_channel_number,
            gateway_reachable, gateway_probe_failure_reason, public_probe_target, public_probe_reachable, public_probe_failure_reason,
            dns_probe_host, dns_resolved, dns_failure_reason, http_probe_target, http_reachable,
            http_failure_reason, failure_stage, failure_reason, upload_bps, download_bps
        FROM network_samples
        ORDER BY ts DESC\(self.limitClause(limit));
        """
        
        var results: [DiagnosticsNetworkSampleRecord] = []
        self.withStatement(sql) { statement in
            while sqlite3_step(statement) == SQLITE_ROW {
                results.append(DiagnosticsNetworkSampleRecord(
                    timestamp: self.date(from: sqlite3_column_int64(statement, 0)),
                    interfaceBSDName: self.text(statement, index: 1),
                    interfaceStatus: self.bool(statement, index: 2),
                    internetReachable: self.bool(statement, index: 3),
                    connectionType: self.text(statement, index: 4),
                    connectivityMode: self.text(statement, index: 5),
                    connectivityTarget: self.text(statement, index: 6),
                    latencyMs: self.double(statement, index: 7),
                    jitterMs: self.double(statement, index: 8),
                    reachabilityClass: self.text(statement, index: 9),
                    quorumPassed: self.bool(statement, index: 10),
                    primaryProbeTransport: self.text(statement, index: 11),
                    primaryProbeTarget: self.text(statement, index: 12),
                    primaryProbeReachable: self.bool(statement, index: 13),
                    primaryProbeFailureReason: self.text(statement, index: 14),
                    localIPAddress: self.text(statement, index: 15),
                    publicIPAddress: self.text(statement, index: 16),
                    gatewayAddress: self.text(statement, index: 17),
                    dnsServers: self.text(statement, index: 18),
                    ssid: self.text(statement, index: 19),
                    bssid: self.text(statement, index: 20),
                    rssi: self.int(statement, index: 21),
                    noise: self.int(statement, index: 22),
                    wifiStandard: self.text(statement, index: 23),
                    wifiMode: self.text(statement, index: 24),
                    wifiSecurity: self.text(statement, index: 25),
                    wifiChannel: self.text(statement, index: 26),
                    wifiChannelBand: self.text(statement, index: 27),
                    wifiChannelWidth: self.text(statement, index: 28),
                    wifiChannelNumber: self.text(statement, index: 29),
                    gatewayReachable: self.bool(statement, index: 30),
                    gatewayProbeFailureReason: self.text(statement, index: 31),
                    publicProbeTarget: self.text(statement, index: 32),
                    publicProbeReachable: self.bool(statement, index: 33),
                    publicProbeFailureReason: self.text(statement, index: 34),
                    dnsProbeHost: self.text(statement, index: 35),
                    dnsResolved: self.bool(statement, index: 36),
                    dnsFailureReason: self.text(statement, index: 37),
                    httpProbeTarget: self.text(statement, index: 38),
                    httpReachable: self.bool(statement, index: 39),
                    httpFailureReason: self.text(statement, index: 40),
                    failureStage: self.text(statement, index: 41),
                    failureReason: self.text(statement, index: 42),
                    uploadBytesPerSecond: sqlite3_column_int64(statement, 43),
                    downloadBytesPerSecond: sqlite3_column_int64(statement, 44)
                ))
            }
        }
        return results
    }
    
    private func fetchDiskSamples(limit: Int? = nil) -> [DiagnosticsDiskSampleRecord] {
        let sql = """
        SELECT
            ts, disk_uuid, disk_name, mounted, free_bytes, total_bytes, utilization,
            read_bps, write_bps, smart_temperature, smart_life, smart_power_cycles, smart_power_on_hours
        FROM disk_samples
        ORDER BY ts DESC\(self.limitClause(limit));
        """
        
        var results: [DiagnosticsDiskSampleRecord] = []
        self.withStatement(sql) { statement in
            while sqlite3_step(statement) == SQLITE_ROW {
                results.append(DiagnosticsDiskSampleRecord(
                    timestamp: self.date(from: sqlite3_column_int64(statement, 0)),
                    identifier: self.text(statement, index: 1) ?? "",
                    name: self.text(statement, index: 2),
                    mounted: self.bool(statement, index: 3),
                    freeBytes: self.optionalInt64(statement, index: 4),
                    totalBytes: self.optionalInt64(statement, index: 5),
                    utilization: self.double(statement, index: 6),
                    readBytesPerSecond: self.optionalInt64(statement, index: 7),
                    writeBytesPerSecond: self.optionalInt64(statement, index: 8),
                    smartTemperature: self.int(statement, index: 9),
                    smartLife: self.int(statement, index: 10),
                    smartPowerCycles: self.int(statement, index: 11),
                    smartPowerOnHours: self.int(statement, index: 12)
                ))
            }
        }
        return results
    }
    
    private func fetchIncidents(limit: Int? = nil) -> [DiagnosticsIncidentRecord] {
        let sql = """
        SELECT id, type, subsystem, severity, status, title, summary, subject_key, started_at, ended_at
        FROM incidents
        ORDER BY started_at DESC\(self.limitClause(limit));
        """
        
        var results: [DiagnosticsIncidentRecord] = []
        self.withStatement(sql) { statement in
            while sqlite3_step(statement) == SQLITE_ROW {
                let incidentID = sqlite3_column_int64(statement, 0)
                results.append(DiagnosticsIncidentRecord(
                    id: incidentID,
                    type: self.text(statement, index: 1) ?? "",
                    subsystem: self.text(statement, index: 2) ?? "",
                    severity: self.text(statement, index: 3) ?? "",
                    status: self.text(statement, index: 4) ?? "",
                    title: self.text(statement, index: 5) ?? "",
                    summary: self.text(statement, index: 6) ?? "",
                    subjectKey: self.text(statement, index: 7) ?? "",
                    startedAt: self.date(from: sqlite3_column_int64(statement, 8)),
                    endedAt: self.optionalDate(statement, index: 9),
                    evidence: self.fetchEvidence(incidentID: incidentID)
                ))
            }
        }
        return results
    }
    
    private func fetchEvidence(incidentID: Int64) -> [DiagnosticsIncidentEvidenceRecord] {
        let sql = """
        SELECT ts, key, value
        FROM incident_evidence
        WHERE incident_id = ?
        ORDER BY ts ASC, id ASC;
        """
        
        var evidence: [DiagnosticsIncidentEvidenceRecord] = []
        self.withStatement(sql) { statement in
            self.bind(int64: incidentID, index: 1, statement: statement)
            while sqlite3_step(statement) == SQLITE_ROW {
                evidence.append(DiagnosticsIncidentEvidenceRecord(
                    timestamp: self.date(from: sqlite3_column_int64(statement, 0)),
                    key: self.text(statement, index: 1) ?? "",
                    value: self.text(statement, index: 2) ?? ""
                ))
            }
        }
        
        return evidence
    }
    
    private func insertEvidence(incidentID: Int64, evidence: [String: String], at timestamp: Date) {
        guard !evidence.isEmpty else { return }
        
        let sql = "INSERT INTO incident_evidence (incident_id, ts, key, value) VALUES (?, ?, ?, ?);"
        for (key, value) in evidence.sorted(by: { $0.key < $1.key }) {
            self.withStatement(sql) { statement in
                self.bind(int64: incidentID, index: 1, statement: statement)
                self.bind(int64: self.timestamp(timestamp), index: 2, statement: statement)
                self.bind(text: key, index: 3, statement: statement)
                self.bind(text: value, index: 4, statement: statement)
                sqlite3_step(statement)
            }
        }
    }
    
    private func limitClause(_ value: Int?) -> String {
        guard let value else { return ";" }
        return " LIMIT \(max(value, 1));"
    }
    
    private func open() {
        guard let path = self.databaseURL()?.path else { return }
        
        var connection: OpaquePointer?
        if sqlite3_open(path, &connection) == SQLITE_OK {
            self.db = connection
            sqlite3_busy_timeout(connection, 2000)
        } else {
            if let connection {
                sqlite3_close(connection)
            }
            self.db = nil
        }
    }
    
    private func createTables() {
        let queries = [
            """
            CREATE TABLE IF NOT EXISTS network_samples (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                ts INTEGER NOT NULL,
                interface_bsd TEXT,
                interface_status INTEGER,
                internet_reachable INTEGER,
                connection_type TEXT,
                connectivity_mode TEXT,
                connectivity_target TEXT,
                latency_ms REAL,
                jitter_ms REAL,
                reachability_class TEXT,
                quorum_passed INTEGER,
                primary_probe_transport TEXT,
                primary_probe_target TEXT,
                primary_probe_reachable INTEGER,
                primary_probe_failure_reason TEXT,
                local_ip TEXT,
                public_ip TEXT,
                gateway_address TEXT,
                dns_servers TEXT,
                ssid TEXT,
                bssid TEXT,
                rssi INTEGER,
                noise INTEGER,
                wifi_standard TEXT,
                wifi_mode TEXT,
                wifi_security TEXT,
                wifi_channel TEXT,
                wifi_channel_band TEXT,
                wifi_channel_width TEXT,
                wifi_channel_number TEXT,
                gateway_reachable INTEGER,
                gateway_probe_failure_reason TEXT,
                public_probe_target TEXT,
                public_probe_reachable INTEGER,
                public_probe_failure_reason TEXT,
                dns_probe_host TEXT,
                dns_resolved INTEGER,
                dns_failure_reason TEXT,
                http_probe_target TEXT,
                http_reachable INTEGER,
                http_failure_reason TEXT,
                failure_stage TEXT,
                failure_reason TEXT,
                upload_bps INTEGER NOT NULL,
                download_bps INTEGER NOT NULL
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS disk_samples (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                ts INTEGER NOT NULL,
                disk_uuid TEXT,
                disk_name TEXT,
                mounted INTEGER,
                free_bytes INTEGER,
                total_bytes INTEGER,
                utilization REAL,
                read_bps INTEGER,
                write_bps INTEGER,
                smart_temperature INTEGER,
                smart_life INTEGER,
                smart_power_cycles INTEGER,
                smart_power_on_hours INTEGER
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS incidents (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                type TEXT NOT NULL,
                subsystem TEXT NOT NULL,
                severity TEXT NOT NULL,
                status TEXT NOT NULL,
                title TEXT NOT NULL,
                summary TEXT NOT NULL,
                subject_key TEXT NOT NULL,
                started_at INTEGER NOT NULL,
                ended_at INTEGER
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS incident_evidence (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                incident_id INTEGER NOT NULL,
                ts INTEGER NOT NULL,
                key TEXT NOT NULL,
                value TEXT NOT NULL,
                FOREIGN KEY (incident_id) REFERENCES incidents(id) ON DELETE CASCADE
            );
            """,
            "CREATE INDEX IF NOT EXISTS idx_network_samples_ts ON network_samples(ts);",
            "CREATE INDEX IF NOT EXISTS idx_disk_samples_ts ON disk_samples(ts);",
            "CREATE INDEX IF NOT EXISTS idx_incidents_started_at ON incidents(started_at);",
            "CREATE INDEX IF NOT EXISTS idx_incident_evidence_incident_id ON incident_evidence(incident_id);"
        ]
        
        queries.forEach { _ = self.execute($0) }
    }
    
    private func migrateTables() {
        let networkColumns = [
            ("connection_type", "TEXT"),
            ("reachability_class", "TEXT"),
            ("quorum_passed", "INTEGER"),
            ("primary_probe_transport", "TEXT"),
            ("primary_probe_target", "TEXT"),
            ("primary_probe_reachable", "INTEGER"),
            ("primary_probe_failure_reason", "TEXT"),
            ("gateway_address", "TEXT"),
            ("dns_servers", "TEXT"),
            ("bssid", "TEXT"),
            ("wifi_standard", "TEXT"),
            ("wifi_mode", "TEXT"),
            ("wifi_security", "TEXT"),
            ("wifi_channel", "TEXT"),
            ("wifi_channel_band", "TEXT"),
            ("wifi_channel_width", "TEXT"),
            ("wifi_channel_number", "TEXT"),
            ("gateway_reachable", "INTEGER"),
            ("gateway_probe_failure_reason", "TEXT"),
            ("public_probe_target", "TEXT"),
            ("public_probe_reachable", "INTEGER"),
            ("public_probe_failure_reason", "TEXT"),
            ("dns_probe_host", "TEXT"),
            ("dns_resolved", "INTEGER"),
            ("dns_failure_reason", "TEXT"),
            ("http_probe_target", "TEXT"),
            ("http_reachable", "INTEGER"),
            ("http_failure_reason", "TEXT"),
            ("failure_stage", "TEXT"),
            ("failure_reason", "TEXT")
        ]
        networkColumns.forEach { self.ensureColumn(table: "network_samples", name: $0.0, type: $0.1) }
    }
    
    private func execute(_ sql: String) -> Bool {
        guard let db = self.db else { return false }
        return sqlite3_exec(db, sql, nil, nil, nil) == SQLITE_OK
    }
    
    private func ensureColumn(table: String, name: String, type: String) {
        guard !self.columnExists(table: table, name: name) else { return }
        _ = self.execute("ALTER TABLE \(table) ADD COLUMN \(name) \(type);")
    }
    
    private func columnExists(table: String, name: String) -> Bool {
        let sql = "PRAGMA table_info(\(table));"
        var found = false
        self.withStatement(sql) { statement in
            while sqlite3_step(statement) == SQLITE_ROW {
                if self.text(statement, index: 1) == name {
                    found = true
                    break
                }
            }
        }
        return found
    }
    
    private func withStatement(_ sql: String, _ body: (OpaquePointer?) -> Void) {
        guard let db = self.db else { return }
        
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else {
            sqlite3_finalize(statement)
            return
        }
        body(statement)
        sqlite3_finalize(statement)
    }
    
    private func bind(text: String?, index: Int32, statement: OpaquePointer?) {
        guard let statement else { return }
        guard let text else {
            sqlite3_bind_null(statement, index)
            return
        }
        sqlite3_bind_text(statement, index, (text as NSString).utf8String, -1, sqliteTransient)
    }
    
    private func bind(int64: Int64?, index: Int32, statement: OpaquePointer?) {
        guard let statement else { return }
        guard let value = int64 else {
            sqlite3_bind_null(statement, index)
            return
        }
        sqlite3_bind_int64(statement, index, value)
    }
    
    private func bind(bool: Bool?, index: Int32, statement: OpaquePointer?) {
        self.bind(int64: bool.map { $0 ? 1 : 0 }, index: index, statement: statement)
    }
    
    private func bind(double: Double?, index: Int32, statement: OpaquePointer?) {
        guard let statement else { return }
        guard let value = double else {
            sqlite3_bind_null(statement, index)
            return
        }
        sqlite3_bind_double(statement, index, value)
    }
    
    private func text(_ statement: OpaquePointer?, index: Int32) -> String? {
        guard let pointer = sqlite3_column_text(statement, index) else { return nil }
        return String(cString: pointer)
    }
    
    private func int(_ statement: OpaquePointer?, index: Int32) -> Int? {
        guard sqlite3_column_type(statement, index) != SQLITE_NULL else { return nil }
        return Int(sqlite3_column_int64(statement, index))
    }
    
    private func optionalInt64(_ statement: OpaquePointer?, index: Int32) -> Int64? {
        guard sqlite3_column_type(statement, index) != SQLITE_NULL else { return nil }
        return sqlite3_column_int64(statement, index)
    }
    
    private func bool(_ statement: OpaquePointer?, index: Int32) -> Bool? {
        guard sqlite3_column_type(statement, index) != SQLITE_NULL else { return nil }
        return sqlite3_column_int64(statement, index) != 0
    }
    
    private func double(_ statement: OpaquePointer?, index: Int32) -> Double? {
        guard sqlite3_column_type(statement, index) != SQLITE_NULL else { return nil }
        return sqlite3_column_double(statement, index)
    }
    
    private func optionalDate(_ statement: OpaquePointer?, index: Int32) -> Date? {
        guard sqlite3_column_type(statement, index) != SQLITE_NULL else { return nil }
        return self.date(from: sqlite3_column_int64(statement, index))
    }
    
    private func timestamp(_ date: Date) -> Int64 {
        Int64(date.timeIntervalSince1970)
    }
    
    private func date(from timestamp: Int64) -> Date {
        Date(timeIntervalSince1970: TimeInterval(timestamp))
    }
    
    private func databaseURL() -> URL? {
        guard let supportDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            return nil
        }
        let directory = supportDirectory.appendingPathComponent("Stats", isDirectory: true)
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
        return directory.appendingPathComponent("diagnostics.sqlite")
    }
}
