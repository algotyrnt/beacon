//
//  BeaconApp.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-09.
//

import SwiftUI

@main
struct BeaconApp: App {
    @StateObject private var engine = BeaconEngine()
    @StateObject private var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            DependencyRootView(engine: engine, locationManager: locationManager)
        }
    }
}

struct DependencyRootView: View {
    @ObservedObject var engine: BeaconEngine
    @ObservedObject var locationManager: LocationManager
    
    @StateObject private var vm: BeaconViewModel
    
    init(engine: BeaconEngine, locationManager: LocationManager) {
        self.engine = engine
        self.locationManager = locationManager
        _vm = StateObject(wrappedValue: BeaconViewModel(engine: engine, locationManager: locationManager))
    }
    
    var body: some View {
        MainTabView()
            .environmentObject(engine)
            .environmentObject(locationManager)
            .environmentObject(vm)
    }
}
