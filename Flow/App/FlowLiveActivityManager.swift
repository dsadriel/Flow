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

    func startLiveActivity() {
        let attributes = FlowActivityAttributes(startedOn: .now, id: UUID())

        let initialState = FlowActivityAttributes.ContentState(isPaused: false, accumulatedTime: 0)

        do {
            flowLiveActivity = try Activity.request(
                attributes: attributes,
                content: ActivityContent(state: initialState, staleDate: nil),
                pushType: nil
            )
        } catch {
            print("Error starting live activity: \(error)")
            return
        }
    }

    func updateLiveActivity(isPaused: Bool, pausedTime: TimeInterval) {
        guard let flowLiveActivity, flowLiveActivity.activityState == .active else {
            print("Error ")
            return
        }

        let updatedState = FlowActivityAttributes.ContentState(
            isPaused: isPaused,
            accumulatedTime: pausedTime
        )

        Task {
            await flowLiveActivity.update(using: updatedState)
        }
    }

    func endLiveActivity() {
        Task {
            await flowLiveActivity?.end(nil, dismissalPolicy: .immediate)
        }
    }
}
