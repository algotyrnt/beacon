//
//  BeaconView.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-09.
//

import SwiftUI
import MapKit

struct BeaconView: View {
    
    @EnvironmentObject var vm: BeaconViewModel
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        Map(position: $cameraPosition) {
            
            // Yourself
            if let myLoc = locationManager.location {
                Annotation("Me", coordinate: myLoc.coordinate) {
                    Circle()
                        .fill(.blue)
                        .frame(width: 20, height: 20)
                        .overlay(Circle().stroke(.white, lineWidth: 2))
                        .shadow(radius: 2)
                }
            }
            
            // Peers
            ForEach(vm.peers) { peer in
                Annotation(peer.name, coordinate: CLLocationCoordinate2D(
                    latitude: peer.latitude,
                    longitude: peer.longitude
                )) {
                    ZStack {
                        Circle()
                            .fill(peer.status == .help ? .red : .orange)
                            .frame(width: 18, height: 18)
                            .overlay(Circle().stroke(.white, lineWidth: 2))
                            .shadow(radius: 2)
                        
                        if peer.status == .help {
                            VStack(spacing: -2) {
                                Text("HELP!!!")
                                    .font(.caption2.bold())
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(.red)
                                    .foregroundStyle(.white)
                                    .clipShape(Capsule())
                                    .shadow(radius: 2)
                                
                                Image(systemName: "arrowtriangle.down.fill")
                                    .font(.system(size: 8))
                                    .foregroundStyle(.red)
                            }
                            .offset(y: -28)
                        }
                    }
                }
            }
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
        .safeAreaInset(edge: .bottom) {
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
