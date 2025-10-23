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
    private var pauseStartTime: Date? // non-nil while paused

    private init() {}

    // MARK: - Session Actions

    func startSession(note: String? = nil) {
        if currentSession != nil { endSession() }

        let session = FlowSession(start: .now, note: note)
        session.pausedTime = 0
        session.end = nil
        session.duration = nil

        currentSession = session
        pauseStartTime = nil

        Task { await FlowPersistence.shared.insert(session) }
        FlowLiveActivityManager.shared.startLiveActivity(startedOn: session.start, id: session.id)
    }

    func endSession() {
        guard let session = currentSession else { return }

        // If currently paused, close that pause window first
        if let pauseStart = pauseStartTime {
            session.pausedTime += Date.now.timeIntervalSince(pauseStart)
            pauseStartTime = nil
        }

        session.end = .now
        let totalElapsed = session.end!.timeIntervalSince(session.start)
        session.duration = max(0, totalElapsed - session.pausedTime) // never negative

        // Persist or discard short sessions (< 30s active)
        Task {
            if (session.duration ?? 0) >= 30 {
                await FlowPersistence.shared.update(session)
            } else {
                await FlowPersistence.shared.delete(session)
            }
        }

        // Update live activity and clear
        FlowLiveActivityManager.shared.endLiveActivity()
        currentSession = nil
    }

    func pauseSession() {
        guard currentSession != nil, pauseStartTime == nil else { return }
        pauseStartTime = .now

        // Report total paused INCLUDING the just-started window as 0 added
        FlowLiveActivityManager.shared.updateLiveActivity(
            isPaused: true,
            pausedTime: pausedTimeSoFar()
        )
    }

    func resumeSession() {
        guard let session = currentSession, let pauseStart = pauseStartTime else { return }

        // Close the pause window and accumulate into session.pausedTime
        session.pausedTime += Date.now.timeIntervalSince(pauseStart)
        currentSession = session
        pauseStartTime = nil

        FlowLiveActivityManager.shared.updateLiveActivity(
            isPaused: false,
            pausedTime: pausedTimeSoFar()
        )
    }

    // MARK: - Derived State

    var isPaused: Bool { pauseStartTime != nil }

    /// Active duration (now - start - paused) while running.
    var currentSessionDuration: TimeInterval {
        guard let session = currentSession else { return 0 }
        let now = Date.now
        let totalElapsed = (session.end ?? now).timeIntervalSince(session.start)
        return max(0, totalElapsed - pausedTimeSoFar())
    }

    /// Returns session.pausedTime plus any in-flight pause window.
    private func pausedTimeSoFar() -> TimeInterval {
        guard let session = currentSession else { return 0 }
        let inFlight = pauseStartTime.map { Date.now.timeIntervalSince($0) } ?? 0
        return session.pausedTime + inFlight
    }

    // MARK: - Session Queries

    func getSessions() async -> [FlowSession] {
        await FlowPersistence.shared.fetchAllSessions()
    }

    func getSessions(from startDate: Date, to endDate: Date) async -> [FlowSession] {
        await FlowPersistence.shared.fetchSessions(from: startDate, to: endDate)
    }

    // MARK: - Analytics

    func getStats() async -> FlowAnalytics {
        let all = await getSessions().filter { $0.duration != nil }

        let now = Date.now
        let cal = Calendar.current
        let startOfToday = cal.startOfDay(for: now)
        let startOfWeek = cal.dateInterval(of: .weekOfYear, for: now)?.start ?? now
        let startOfMonth = cal.dateInterval(of: .month, for: now)?.start ?? now

        func sum(_ arr: [FlowSession]) -> TimeInterval { arr.reduce(0) { $0 + ($1.duration ?? 0) } }

        let totalSessions = all.count
        let totalDuration = sum(all)
        let averageDuration = totalSessions > 0 ? totalDuration / Double(totalSessions) : 0
        let longest = all.map { $0.duration ?? 0 }.max() ?? 0
        let shortest = all.map { $0.duration ?? 0 }.min() ?? 0

        let today = all.filter { $0.start >= startOfToday }
        let week = all.filter { $0.start >= startOfWeek }
        let month = all.filter { $0.start >= startOfMonth }

        return FlowAnalytics(
            totalSessions: totalSessions,
            totalDuration: totalDuration,
            averageDuration: averageDuration,
            longestSession: longest,
            shortestSession: shortest,
            sessionsToday: today.count,
            durationToday: sum(today),
            sessionsThisWeek: week.count,
            durationThisWeek: sum(week),
            sessionsThisMonth: month.count,
            durationThisMonth: sum(month)
        )
    }
}
