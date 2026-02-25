//
//  MainTabView.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-09.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            BeaconView()
                .tabItem {
                    Label("Beacon", systemImage: "dot.radiowaves.left.and.right")
                }
            
            ResourcesView()
                .tabItem {
                    Label("Resources", systemImage: "square.grid.2x2.fill")
                }
        }
    }
}

