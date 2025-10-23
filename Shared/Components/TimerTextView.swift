//
//  TimerTextView.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import SwiftUI

struct TimerTextView: View {
    let startDate: Date
    let accumulatedTime: TimeInterval 
    let isPaused: Bool

    var body: some View {
        let now = Date()
        
        // When running: timer counts from startDate
        // When paused: timer is frozen at accumulatedTime
        // We offset the startDate by accumulated time to include previous active periods
        let effectiveStart = startDate.addingTimeInterval(-accumulatedTime)

        Text("00:00")
            .hidden()
            .overlay {
                Text(
                    timerInterval: effectiveStart...Date.distantFuture,
                    pauseTime: isPaused ? now : nil,
                    countsDown: false,
                    showsHours: true
                )
                .clipped()
                .multilineTextAlignment(.trailing)
                .monospacedDigit()
                .font(.largeTitle.bold())
            }
            .multilineTextAlignment(.trailing)
            .monospacedDigit()
            .font(.largeTitle.bold())
    }
}
