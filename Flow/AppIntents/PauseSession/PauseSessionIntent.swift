//
//  PauseSessionIntent.swift
//  Flow
//
//  Created by Vítor Bruno on 21/10/25.
//

import Foundation
import AppIntents
import SwiftUI

struct PauseSessionIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Pause session"
    
    static var description: IntentDescription? = "Pauses the current session on flow"
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        
        let session = FlowSessionManager.shared.currentSession
        
        FlowSessionManager.shared.pauseSession()
        return .result(dialog: "Current session has been paused") {
            CurrentSessionCard(session: session, isPaused: true)
                .padding()
                .frame(alignment: .center)
        }
    }
}
