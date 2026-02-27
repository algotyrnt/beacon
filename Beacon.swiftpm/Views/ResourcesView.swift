//
//  ResourcesView.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-09.
//

import SwiftUI

struct ResourcesView: View {
    
    @State private var selectedResource: Resource?
    @State private var searchText = ""
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var filteredResources: [Resource] {
        if searchText.isEmpty {
            return resourcesData
        } else {
            return resourcesData.filter { resource in
                resource.title.localizedCaseInsensitiveContains(searchText) ||
                resource.subtitle.localizedCaseInsensitiveContains(searchText) ||
                resource.details.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(filteredResources) { resource in
                        Button {
                            selectedResource = resource
                        } label: {
                            ResourceCard(resource: resource)
                                .frame(height: 140)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Resources")
            .background(Color(UIColor.systemGroupedBackground))
            .searchable(text: $searchText, prompt: "search")
            
            .sheet(item: $selectedResource) { res in
                ResourceDetailView(resource: res)
            }
        }
    }
}
