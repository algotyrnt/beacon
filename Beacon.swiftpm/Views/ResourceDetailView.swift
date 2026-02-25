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
        VStack(spacing: 20) {
            Image(systemName: resource.icon)
                .font(.system(size: 60))
                .foregroundStyle(.blue)
            
            Text(resource.title)
                .font(.largeTitle.bold())
            
            Text(resource.details)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .padding()
    }
}
