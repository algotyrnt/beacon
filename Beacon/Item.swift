//
//  Item.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-04.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
