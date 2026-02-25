//
//  TipRow.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-25.
//

import SwiftUI

struct TipRow: View {
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
            Text(text)
            Spacer()
        }
    }
}
