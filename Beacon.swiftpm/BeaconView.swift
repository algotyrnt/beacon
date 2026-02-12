//
//  BeaconView.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-09.
//

import SwiftUI
import MapKit

struct BeaconView: View {
    
    @StateObject private var vm = BeaconViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            Map {
                // Yourself
                if let myLoc = vm.locationManager.location {
                    Annotation("Me",
                               coordinate: myLoc.coordinate) {
                        Circle()
                            .fill(.blue)
                            .frame(width: 20, height: 20)
                    }
                }
                
                // Peers
                ForEach(vm.peers) { peer in
                    Annotation(peer.name,
                               coordinate: CLLocationCoordinate2D(
                                latitude: peer.latitude,
                                longitude: peer.longitude
                               )) {
                        Circle()
                            .fill(peer.status == .help ? .red : .orange)
                            .frame(width: 18, height: 18)
                    }
                }
            }
            .ignoresSafeArea()
            
            // Control Panel
            VStack(spacing: 12) {
                
                Button {
                    vm.toggleHelp()
                } label: {
                    Text(vm.myStatus == .help ? "Cancel Help" : "I Need Help")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(vm.myStatus == .help ? .gray : .red)
                        .foregroundStyle(.white)
                        .cornerRadius(16)
                }
                
                Text("Nearby People: \(vm.peers.count)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
            }
            .padding()
            .background(.ultraThinMaterial)
        }
    }
}

