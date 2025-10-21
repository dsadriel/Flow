//
//  ContentView.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var sessionManager = FlowSessionManager.shared
    @Query(sort: \FlowSession.start, order: .reverse) private var sessions: [FlowSession]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Current Session Card
                if sessionManager.currentSession != nil {
                    CurrentSessionCard(
                        session: sessionManager.currentSession,
                        isPaused: sessionManager.isPaused
                    )
                    .padding(.horizontal)
                }
                
                // Session Controls
                SessionControls(
                    hasCurrentSession: sessionManager.currentSession != nil,
                    isPaused: sessionManager.isPaused,
                    onStart: { sessionManager.startSession() },
                    onPause: { sessionManager.pauseSession() },
                    onResume: { sessionManager.resumeSession() },
                    onEnd: { sessionManager.endSession() }
                )
                .padding(.horizontal)
                
                // Past Sessions List
                PastSessionsList(sessions: sessions)
            }
            .navigationTitle("Flow Sessions")
            .task {
                // Initialize FlowPersistence with modelContext
                await FlowPersistence.shared.initialize(modelContext: modelContext)
            }
        }
    }
}

#Preview {
    ContentView()
}
