//
//  TimerTextView.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import SwiftUI


 struct TimerTextView: View {
        let startDate: Date
        let accumulatedTime: TimeInterval   // keeping your spelling
        let isPaused: Bool

        var body: some View {
            let now = Date()
            // Elapsed based on current run state
            let elapsed = isPaused
                ? accumulatedTime
                : accumulatedTime + now.timeIntervalSince(startDate)

            // Make the timer count up indefinitely from a point in the past
            let lowerBound = now.addingTimeInterval(-elapsed)
            let upperBound = Date.distantFuture

            Text(
                timerInterval: lowerBound...upperBound,
                pauseTime: isPaused ? now : nil,
                countsDown: false,
                showsHours: true
            )
            .multilineTextAlignment(.trailing)
            .monospacedDigit()
            .font(.largeTitle.bold())
        }
    }
