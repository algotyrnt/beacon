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
            Group {
                if filteredResources.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                } else {
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
                                .transition(.scale(scale: 0.9).combined(with: .opacity))
                            }
                        }
                        .padding()
                        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: searchText)
                    }
                }
            }
            .navigationTitle("Resources")
            .searchable(text: $searchText, prompt: "search")
            .sheet(item: $selectedResource) { res in
                ResourceDetailView(resource: res)
            }
        }
    }
}
