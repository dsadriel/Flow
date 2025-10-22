//
//  FlowActivity.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import Foundation
import ActivityKit

// MARK: ActivityAttributes
struct FlowActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var isPaused: Bool
        var accumulatedTime: TimeInterval
    }

    var name: String?
    var startedOn: Date
    var id: UUID
}
