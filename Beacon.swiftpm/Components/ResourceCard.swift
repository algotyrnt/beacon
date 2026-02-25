//
//  ResourceCard.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-25.
//

import SwiftUI

struct ResourceCard: View {
    let resource: Resource
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: resource.icon)
                .font(.system(size: 30))
                .foregroundStyle(.blue)
            
            Text(resource.title)
                .font(.headline)
            
            Text(resource.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}
