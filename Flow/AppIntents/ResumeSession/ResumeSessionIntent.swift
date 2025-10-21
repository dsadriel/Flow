//
//  ResumeSessionIntent.swift
//  Flow
//
//  Created by Vítor Bruno on 21/10/25.
//

import Foundation
import AppIntents

struct ResumeSessionIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Resume session"
    
    static var description: IntentDescription? = "Resume the current paused session"
    
    func perform() async throws -> some IntentResult & ProvidesDialog{
        await FlowSessionManager.shared.resumeSession()
        return .result(dialog: "Session resumed")
    }
}
