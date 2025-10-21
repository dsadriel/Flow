//
//  TodaysSessionIntent.swift
//  Flow
//
//  Created by Vítor Bruno on 21/10/25.
//

import Foundation
import AppIntents

struct StartSessionWithNote: AppIntent {
    
    static var title: LocalizedStringResource = "Start Session with note"
    
    static var description: IntentDescription? = "Shows all sessions saved from today"
    
    @Parameter(title: "Note", requestValueDialog: "Write your note bellow")
    var note: String
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        
        try await requestConfirmation(dialog: "You are sure you want to start a session with this note? \(note)")
        
        FlowSessionManager.shared.startSession(note: note)
        
        return .result(dialog: "Session started with note!")
    }
}
