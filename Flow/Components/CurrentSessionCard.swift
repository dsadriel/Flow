//
//  CurrentSessionCard.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import SwiftUI

struct CurrentSessionCard: View {
    let session: FlowSession?
    let isPaused: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Current Session")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            if let session = session {
                Text(session.start, style: .timer)
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .monospacedDigit()
            }
            
            if isPaused {
                Label("Paused", systemImage: "pause.circle.fill")
                    .foregroundStyle(Color.Flow.tertiary)
                    .font(.subheadline)
            } else {
                Label("In Progress", systemImage: "play.circle.fill")
                    .foregroundStyle(Color.Flow.secondary)
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    VStack {
        Text("Started 5 min ago")
        CurrentSessionCard(session: .init(start: .now.addingTimeInterval(-60*5)), isPaused: false)

        Divider()
        Text("Paused")
        CurrentSessionCard(session: .init(), isPaused: true)
        
        Divider()
        Text("No session")
        CurrentSessionCard(session: nil, isPaused: false)
    }
}
