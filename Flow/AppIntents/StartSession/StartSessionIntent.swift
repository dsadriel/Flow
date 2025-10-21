//
//  StartSessionIntent.swift
//  Flow
//
//  Created by Vítor Bruno on 21/10/25.
//

import Foundation
import AppIntents

struct StartSessionIntent: AppIntent {
    
    //Title for the intent
    static var title: LocalizedStringResource = "Start Session"
    
    //Description for the intetn
    static var description: IntentDescription? = "Start a new session on flow"
    
    //our perfom() func in @MainActor, returns a result and a dialog
    @MainActor
    func perform() throws -> some IntentResult & ProvidesDialog {
        FlowSessionManager.shared.startSession()
        return .result(dialog: "Session started")
    }
}
