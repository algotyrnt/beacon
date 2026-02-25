//
//  BeaconPacket.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-12.
//

import Foundation

struct BeaconPacket: Codable, Identifiable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    let status: Status
    let timestamp: Date
    
    enum Status: String, Codable {
        case normal
        case help
    }
}
