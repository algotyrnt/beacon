//
//  ResourcesView.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-09.
//

import SwiftUI

struct Resource: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let details: String
}

let resourcesData: [Resource] = [
    Resource(
        title: "First Aid",
        subtitle: "Bleeding, CPR",
        icon: "cross.case.fill",
        details: "Apply pressure to bleeding wounds. If unconscious and not breathing, begin CPR if trained."
    ),
    Resource(
        title: "Cyclone Safety",
        subtitle: "Shelter tips",
        icon: "hurricane",
        details: "Move to interior rooms. Stay away from windows. Keep emergency kit nearby."
    ),
    Resource(
        title: "Water Safety",
        subtitle: "Purification",
        icon: "drop.fill",
        details: "Boil water for 1 minute or use purification tablets before drinking."
    ),
    Resource(
        title: "Power Saving",
        subtitle: "Extend battery",
        icon: "battery.100",
        details: "Enable Low Power Mode. Reduce screen brightness. Close background apps."
    ),
    Resource(
        title: "SOS Signals",
        subtitle: "Get attention",
        icon: "wave.3.right",
        details: "Use whistle, flashlight flashes, or reflective surfaces to signal rescuers."
    ),
    Resource(
        title: "Evacuation",
        subtitle: "When to move",
        icon: "figure.walk",
        details: "Evacuate if instructed by authorities. Follow marked safe routes."
    )
]

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
                ResourceDetail(resource: res)
            }
        }
    }
}

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

struct ResourceDetail: View {
    
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

