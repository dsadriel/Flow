//
//  FlowLiveActivityManager.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import ActivityKit
import Foundation

@MainActor
@Observable
class FlowLiveActivityManager {
    static let shared = FlowLiveActivityManager()

    // States
    var flowLiveActivity: Activity<FlowActivityAttributes>? = nil

    func startLiveActivity(startedOn: Date, id: UUID) {
        // ... 
    }

    func updateLiveActivity(isPaused: Bool, pausedTime: TimeInterval) {
        // ...
    }

    func endLiveActivity() {
        // ...
    }
}
