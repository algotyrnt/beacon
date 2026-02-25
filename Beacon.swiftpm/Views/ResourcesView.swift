//
//  ResourcesView.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-09.
//

import SwiftUI

struct ResourcesView: View {
    
    @State private var selectedResource: Resource?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    
                    ForEach(resourcesData) { resource in
                        ResourceCard(resource: resource)
                            .onTapGesture {
                                selectedResource = resource
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Resources")
            .sheet(item: $selectedResource) { res in
                ResourceDetailView(resource: res)
            }
        }
    }
}
