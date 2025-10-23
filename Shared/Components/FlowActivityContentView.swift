//
//  FlowActivityContentView.swift
//  Flow
//
//  Created by Adriel de Souza on 22/10/25.
//

import SwiftUI
import WidgetKit

// MARK: - Content View
struct FlowActivityContentView: View {
    @Environment(\.activityFamily) var activityFamily
    
    let name: String?
    let startDate: Date
    let accumulatedTime: TimeInterval
    let isPaused: Bool

    var body: some View {
        Group {
            if activityFamily == .small {
                smallWidgetView
            } else {
                notificationView
            }
        }
    }
    
    private var smallWidgetView: some View {
        VStack(alignment: .center) {
            if let name {
                Text(name)
            }

            HStack {
                FlowSessionIcon(color: .white)
                TimerTextView(
                    startDate: startDate,
                    accumulatedTime: accumulatedTime,
                    isPaused: isPaused
                )
            }
        }
        .padding()
    }
    
    private var notificationView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Image(.waveSymbol)
                        .padding(3)
                        .font(.largeTitle)
                        .clipShape(Circle())
                }

                Spacer()

                VStack(alignment: .trailing) {
                    TimerTextView(
                        startDate: startDate,
                        accumulatedTime: accumulatedTime,
                        isPaused: isPaused
                    )

                    if let name {
                        Text(name)
                    }
                }
            }

            if isPaused {
                pausedLabel
            }
        }
        .foregroundStyle(.white)
        .padding()
        .background(isPaused ? Color.Flow.tertiary : Color.Flow.secondary)
    }
    
    private var pausedLabel: some View {
        Label("PAUSED", systemImage: "pause.circle.fill")
            .padding(.vertical, 8)
            .font(.callout)
            .bold()
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
