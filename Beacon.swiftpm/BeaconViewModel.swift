//
//  BeaconViewModel.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-12.
//

import Foundation
import Combine
import CoreLocation

@MainActor
final class BeaconViewModel: ObservableObject {
    
    @Published var peers: [BeaconPacket] = []
    @Published var myStatus: BeaconPacket.Status = .normal
    
    private let engine: BeaconEngine
    private let locationManager: LocationManager
    
    private var broadcastTask: Task<Void, Never>?
    private var cleanupTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()
    
    private let staleThreshold: TimeInterval = 15
    
    init(engine: BeaconEngine, locationManager: LocationManager) {
        self.engine = engine
        self.locationManager = locationManager
        
        observeIncomingData()
        startBroadcasting()
        startCleanupTimer()
    }
    
    deinit {
        broadcastTask?.cancel()
        cleanupTask?.cancel()
    }
    
    // MARK: - Broadcast
    func startBroadcasting() {
        broadcastTask?.cancel()
        
        broadcastTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
                self.sendPacket()
            }
        }
    }
    
    private func sendPacket() {
        guard let location = locationManager.location else { return }
        
        let packet = BeaconPacket(
            id: engine.myPeerID.displayName,
            name: engine.myPeerID.displayName,
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            status: myStatus,
            timestamp: Date()
        )
        
        guard let data = try? JSONEncoder().encode(packet) else { return }
        engine.send(data)
    }
    
    // MARK: - Receive
    private func observeIncomingData() {
        engine.incomingData
            .receive(on: RunLoop.main)
            .sink { [weak self] payload in
                guard let self = self else { return }
                
                let (data, peerID) = payload
                
                guard let packet = try? JSONDecoder().decode(BeaconPacket.self, from: data) else {
                    print("Failed to decode packet from \(peerID.displayName)")
                    return
                }
                
                self.updatePeer(packet)
            }
            .store(in: &cancellables)
    }
    
    private func updatePeer(_ packet: BeaconPacket) {
        peers.removeAll { $0.id == packet.id }
        peers.append(packet)
    }
    
    // MARK: - Cleanup Routine
    private func startCleanupTimer() {
        cleanupTask?.cancel()
        
        cleanupTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 5 * 1_000_000_000)
                
                let now = Date()
                self.peers.removeAll { peer in
                    now.timeIntervalSince(peer.timestamp) > self.staleThreshold
                }
            }
        }
    }
    
    // MARK: - Emergency
    func toggleHelp() {
        myStatus = myStatus == .normal ? .help : .normal
        if myStatus == .help {
            engine.start()
        }
        sendPacket()
    }
}
