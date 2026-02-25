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
            ScrollView {
                VStack(spacing: 25) {
                    
                    // MARK: - Hero Section
                    VStack(spacing: 12) {
                        Image(systemName: "antenna.radiowaves.left.and.right")
                            .font(.system(size: 60))
                            .foregroundStyle(.blue)
                        
                        Text("Beacon")
                            .font(.largeTitle.bold())
                        
                        Text("Offline emergency network")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 30)
                    
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
                    
                    // MARK: - Tips
                    VStack(alignment: .leading) {
                        Text("Quick Tips")
                            .font(.headline)
                        
                        TipRow(text: "Keep Bluetooth ON")
                        TipRow(text: "Stay in open areas")
                        TipRow(text: "Help others if safe")
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    
                }
                .padding()
            }
            .navigationTitle("Home")
        }
        .onAppear {
            locationManager.requestPermission()
        }
    }
}

struct StatusCard: View {
    
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.blue)
            
            Text(title)
                .foregroundStyle(.secondary)
            
            Text(value)
                .font(.title2.bold())
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}

struct TipRow: View {
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
            Text(text)
            Spacer()
        }
    }
}
