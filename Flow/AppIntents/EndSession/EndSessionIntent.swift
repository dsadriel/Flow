//
//  EndSessionIntent.swift
//  Flow
//
//  Created by Vítor Bruno on 21/10/25.
//

import Foundation
import AppIntents

struct EndSessionIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Finish Session"
    
    static var description: IntentDescription? = "finish the current session"
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        await FlowSessionManager.shared.endSession()
        return .result(dialog: "Current session finished")
    }
}
