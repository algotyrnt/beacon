//
//  Resource.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-25.
//

import Foundation

struct Resource: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let details: String
}
