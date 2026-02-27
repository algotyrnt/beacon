//
//  HomeView.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-09.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var engine: BeaconEngine
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                // MARK: - Hero Section
                VStack {
                    Spacer()
                    Image(systemName: "antenna.radiowaves.left.and.right")
                        .font(.system(size: 120))
                        .foregroundStyle(.blue)
                    Spacer()
                    VStack(spacing: 8) {
                        Text("Beacon")
                            .font(.largeTitle.bold())
                        Text("Offline emergency network")
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(maxHeight: .infinity)
                
                // MARK: - Status Grid
                HStack(spacing: 16) {
                    StatusCard(
                        icon: "person.2.fill",
                        title: "Peers",
                        value: "\(engine.connectedPeers.count)"
                    )
                    StatusCard(
                        icon: "location.fill",
                        title: "Broadcast",
                        value: engine.isRunning ? "On" : "Off"
                    )
                }
                
                // MARK: - Activate Card
                VStack(spacing: 15) {
                    Text(engine.isRunning ? "Beacon Active" : "Beacon Inactive")
                        .font(.title2.bold())
                    Button {
                        withAnimation {
                            if engine.isRunning {
                                engine.stop()
                            } else {
                                engine.start()
                            }
                        }
                    } label: {
                        Text(engine.isRunning ? "Deactivate" : "Activate Beacon")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(engine.isRunning ? .red : .blue)
                            .foregroundStyle(.white)
                            .cornerRadius(16)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
            }
            .padding()
            .navigationTitle("Home")
        }
        .onAppear {
            locationManager.requestPermission()
        }
    }
}
