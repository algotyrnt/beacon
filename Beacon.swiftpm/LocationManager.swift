//
//  LocationManager.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-12.
//

import Foundation
import CoreLocation
import Combine

@MainActor
final class LocationManager: NSObject, ObservableObject {
    
    // MARK: - Public State
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    // MARK: - Core
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 5 // meters
    }
    
    // MARK: - Controls
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func start() {
        manager.startUpdatingLocation()
    }
    
    func stop() {
        manager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    nonisolated func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        Task { @MainActor in
            self.authorizationStatus = status
            
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                self.start()
            }
        }
    }
    
    nonisolated func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let latest = locations.last else { return }
        
        Task { @MainActor in
            self.location = latest
        }
    }
}
