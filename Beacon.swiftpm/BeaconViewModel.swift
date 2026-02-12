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
    
    let engine = BeaconEngine()
    let locationManager = LocationManager()
    
    private var broadcastTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        engine.start()
        locationManager.requestPermission()
        
        startBroadcasting()
        observeIncomingData()
    }
    
    deinit {
        broadcastTask?.cancel()
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
    
    func sendPacket() {
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
    func observeIncomingData() {
        engine.$receivedData
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                guard let packet = try? JSONDecoder().decode(BeaconPacket.self, from: data) else { return }
                self?.updatePeer(packet)
            }
            .store(in: &cancellables)
    }
    
    func updatePeer(_ packet: BeaconPacket) {
        peers.removeAll { $0.id == packet.id }
        peers.append(packet)
    }
    
    // MARK: - Emergency
    func toggleHelp() {
        myStatus = myStatus == .normal ? .help : .normal
    }
}
