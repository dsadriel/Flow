//
//  FlowAnalytics.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import Foundation

struct FlowAnalytics {
    let totalSessions: Int
    let totalDuration: TimeInterval
    let averageDuration: TimeInterval
    let longestSession: TimeInterval
    let shortestSession: TimeInterval
    let sessionsToday: Int
    let durationToday: TimeInterval
    let sessionsThisWeek: Int
    let durationThisWeek: TimeInterval
    let sessionsThisMonth: Int
    let durationThisMonth: TimeInterval
}
