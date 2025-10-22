//
//  ResumeSessionIntent.swift
//  Flow
//
//  Created by Vítor Bruno on 21/10/25.
//

import Foundation
import AppIntents
import SwiftUI

struct ResumeSessionIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Resume session"
    
    static var description: IntentDescription? = "Resume the current paused session"
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView{
        
        let session = FlowSessionManager.shared.currentSession
        
        FlowSessionManager.shared.resumeSession()
        
        return .result(dialog: "Session resumed") {
            CurrentSessionCard(session: session, isPaused: false)
                .padding()
                .frame(alignment: .center)
        }
    }
}
