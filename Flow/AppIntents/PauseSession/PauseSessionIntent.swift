//
//  PauseSessionIntent.swift
//  Flow
//
//  Created by Vítor Bruno on 21/10/25.
//

import Foundation
import AppIntents

struct PauseSessionIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Pause session"
    
    static var description: IntentDescription? = "Pauses the current session on flow"
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        await FlowSessionManager.shared.pauseSession()
        return .result(dialog: "Current session has been paused")
    }
}
