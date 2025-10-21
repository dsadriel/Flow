//
//  PastSessionsList.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import SwiftUI

struct PastSessionsList: View {
    let sessions: [FlowSession]
    
    private var completedSessions: [FlowSession] {
        sessions.filter { $0.duration != nil }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Past Sessions")
                .font(.headline)
                .padding(.horizontal)
            
            if completedSessions.isEmpty {
                ContentUnavailableView(
                    "No Sessions Yet",
                    systemImage: "clock.badge.questionmark",
                    description: Text("Start your first flow session to see it here")
                )
                .frame(maxHeight: .infinity)
            } else {
                List {
                    ForEach(completedSessions) { session in
                        SessionRow(session: session)
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}


#Preview {
    PastSessionsList(sessions: [.init(), .init(), .init()])
}
