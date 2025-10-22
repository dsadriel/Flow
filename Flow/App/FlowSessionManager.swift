//
//  FlowSessionManager.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import Foundation

@MainActor
@Observable
class FlowSessionManager {
    static let shared = FlowSessionManager()
    
    private(set) var currentSession: FlowSession?
    private var pauseStartTime: Date?
    private var totalPauseDuration: TimeInterval = 0
    
    private init() {}
    
    // MARK: - Session Actions
    
    /// Starts a new flow session
    func startSession(note: String? = nil) {
        // End any existing session first
        if currentSession != nil {
            endSession()
        }
        
        let session = FlowSession(start: .now, note: note)
        currentSession = session
        pauseStartTime = nil
        totalPauseDuration = 0
        
        Task {
            await FlowPersistence.shared.insert(session)
        }

        FlowLiveActivityManager.shared.startLiveActivity(startedOn: session.start, id: session.id)
    }
    
    /// Ends the current flow session
    func endSession() {
        guard let session = currentSession else { return }
        
        // If session was paused, add the remaining pause duration
        if let pauseStart = pauseStartTime {
            totalPauseDuration += Date.now.timeIntervalSince(pauseStart)
            pauseStartTime = nil
        }
        
        session.end = .now
        let totalElapsed = session.end!.timeIntervalSince(session.start)
        session.duration = totalElapsed - totalPauseDuration

        Task {
            session.duration ?? 0.0 >= 30.0 ? await FlowPersistence.shared.update(session) : await FlowPersistence.shared.delete(session)
        }

        currentSession = nil
        totalPauseDuration = 0

        FlowLiveActivityManager.shared.endLiveActivity()
    }
    
    /// Pauses the current flow session
    func pauseSession() {
        guard currentSession != nil, pauseStartTime == nil else { return }
        pauseStartTime = .now

        FlowLiveActivityManager.shared.updateLiveActivity(isPaused: true, pausedTime: totalPauseDuration)
    }
    
    /// Resumes a paused flow session
    func resumeSession() {
        guard let pauseStart = pauseStartTime else { return }
        totalPauseDuration += Date.now.timeIntervalSince(pauseStart)
        pauseStartTime = nil

        FlowLiveActivityManager.shared.updateLiveActivity(isPaused: false, pausedTime: totalPauseDuration)
    }
    
    /// Returns whether the current session is paused
    var isPaused: Bool {
        return pauseStartTime != nil
    }
    
    /// Returns the active duration of the current session (excluding pauses)
    var currentSessionDuration: TimeInterval {
        guard let session = currentSession else { return 0 }
        
        let totalElapsed = Date.now.timeIntervalSince(session.start)
        var pauseDuration = totalPauseDuration
        
        // If currently paused, add the current pause duration
        if let pauseStart = pauseStartTime {
            pauseDuration += Date.now.timeIntervalSince(pauseStart)
        }
        
        return totalElapsed - pauseDuration
    }
    
    // MARK: - Session Queries
    
    /// Retrieves all flow sessions
    func getSessions() async -> [FlowSession] {
        return await FlowPersistence.shared.fetchAllSessions()
    }
    
    /// Retrieves sessions within a date range
    func getSessions(from startDate: Date, to endDate: Date) async -> [FlowSession] {
        return await FlowPersistence.shared.fetchSessions(from: startDate, to: endDate)
    }
    
    // MARK: - Analytics
    
    /// Calculates and returns analytics for all flow sessions
    func getStats() async -> FlowAnalytics {
        let allSessions = await getSessions().filter { $0.duration != nil }
        
        // Calculate date boundaries
        let now = Date.now
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: now)
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: now)?.start ?? now
        let startOfMonth = calendar.dateInterval(of: .month, for: now)?.start ?? now
        
        // Total stats
        let totalSessions = allSessions.count
        let totalDuration = allSessions.reduce(0) { $0 + ($1.duration ?? 0) }
        let averageDuration = totalSessions > 0 ? totalDuration / Double(totalSessions) : 0
        let longestSession = allSessions.map { $0.duration ?? 0 }.max() ?? 0
        let shortestSession = allSessions.map { $0.duration ?? 0 }.min() ?? 0
        
        // Today stats
        let sessionsToday = allSessions.filter { $0.start >= startOfToday }
        let todayCount = sessionsToday.count
        let todayDuration = sessionsToday.reduce(0) { $0 + ($1.duration ?? 0) }
        
        // Week stats
        let sessionsThisWeek = allSessions.filter { $0.start >= startOfWeek }
        let weekCount = sessionsThisWeek.count
        let weekDuration = sessionsThisWeek.reduce(0) { $0 + ($1.duration ?? 0) }
        
        // Month stats
        let sessionsThisMonth = allSessions.filter { $0.start >= startOfMonth }
        let monthCount = sessionsThisMonth.count
        let monthDuration = sessionsThisMonth.reduce(0) { $0 + ($1.duration ?? 0) }
        
        return FlowAnalytics(
            totalSessions: totalSessions,
            totalDuration: totalDuration,
            averageDuration: averageDuration,
            longestSession: longestSession,
            shortestSession: shortestSession,
            sessionsToday: todayCount,
            durationToday: todayDuration,
            sessionsThisWeek: weekCount,
            durationThisWeek: weekDuration,
            sessionsThisMonth: monthCount,
            durationThisMonth: monthDuration
        )
    }
}
