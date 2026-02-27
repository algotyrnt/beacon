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
        VStack(spacing: 8) {
            Image(systemName: resource.icon)
                .font(.system(size: 32))
                .foregroundStyle(.blue)
            
            Text(resource.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            Text(resource.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(1)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}
