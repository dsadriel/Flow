//
//  FlowSession.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import SwiftData
import Foundation

@Model
class FlowSession: Identifiable {
    var id: UUID
    var start: Date
    var end: Date?
    var duration: TimeInterval?
    var pausedTime: TimeInterval = 0
    var note: String?

    init(id: UUID = UUID(), start: Date = .now, end: Date? = nil, duration: TimeInterval? = nil, note: String? = nil) {
        self.id = id
        self.start = start
        self.end = end
        self.duration = duration
        self.note = note
    }
}
