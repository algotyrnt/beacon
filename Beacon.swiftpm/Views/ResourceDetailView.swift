//
//  ResourceDetailView.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-25.
//

import SwiftUI

struct ResourceDetailView: View {
    let resource: Resource
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header Icon
                Image(systemName: resource.icon)
                    .font(.system(size: 64))
                    .foregroundStyle(.blue)
                    .padding(.top, 30)
                
                // Titles
                VStack(spacing: 8) {
                    Text(resource.title)
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                    
                    Text(resource.subtitle)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                
                // Details Text
                Text(resource.details)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical)
                
                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .presentationDragIndicator(.visible)
    }
}
