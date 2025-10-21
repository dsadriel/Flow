//
//  FlowActivityConfiguration.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct FlowActivityConfiguration: Widget {
    var isPaused = true

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FlowActivityAttributes.self) { context in
            // Here goes the Notification Center view
            FlowActivityContentView(context: context)
                .activityBackgroundTint(context.state.isPaused ? .Flow.tertiary : .Flow.secondary)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    FlowSessionIcon(isPaused: context.state.isPaused, showIcon: false)
                        .font(.largeTitle)
                }

                DynamicIslandExpandedRegion(.trailing) {
                }

                DynamicIslandExpandedRegion(.center) {
                    if let name = context.attributes.name {
                        Text(name)
                    }
                }

                DynamicIslandExpandedRegion(.bottom) {
                    HStack(alignment: .center) {
                        ActionButtons(isPaused: context.state.isPaused)

                        Spacer()

                        TimerTextView(startDate: context.attributes.startedOn, accumulatedTime: context.state.accumulatedTime, isPaused: context.state.isPaused)
                    }
                }
            } compactLeading: {
                FlowSessionIcon(isPaused: context.state.isPaused, showIcon: false)
            } compactTrailing: {
                TimerTextView(startDate: context.attributes.startedOn, accumulatedTime: context.state.accumulatedTime, isPaused: context.state.isPaused)
            } minimal: {
                FlowSessionIcon(isPaused: context.state.isPaused)
            }
        }
        .supplementalActivityFamilies([.small])
    }
}

struct FlowActivityContentView: View {
    @Environment(\.activityFamily) var activityFamily
    var context: ActivityViewContext<FlowActivityAttributes>

    var body: some View {
        Group {
            if activityFamily == .small {
                VStack(alignment: .center){
                    if let name = context.attributes.name {
                        Text(name)
                    }

                    HStack {
                        FlowSessionIcon(color: .white)

                        TimerTextView(startDate: context.attributes.startedOn, accumulatedTime: context.state.accumulatedTime, isPaused: context.state.isPaused)
                    }

                }
                .padding()
            } else {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Image(.waveSymbol)
                                .padding(3)
                                .font(.largeTitle)
                                .clipShape(Circle())
                        }


                        Spacer()

                        VStack(alignment: .trailing){
                            TimerTextView(startDate: context.attributes.startedOn, accumulatedTime: context.state.accumulatedTime, isPaused: context.state.isPaused)

                            if let name = context.attributes.name {
                                Text(name)
                            }
                        }
                    }

                    if context.state.isPaused {
                        Label("PAUSED", systemImage: "pause.circle.fill")
                            .padding(.vertical, 8)
                            .font(.callout)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .background(Color.black.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .foregroundStyle(.white)
                .padding()
                .background(context.state.isPaused ? Color.Flow.tertiary : Color.Flow.secondary)

            }
        }
    }
}

/// Live Activity previews work differently than regular widget previews
/// You need to provide sample attributes and content states
#Preview(
    "Notification",
    as: .content,  // Preview type - can be .content, .dynamicIsland, etc.
    using: FlowActivityAttributes(name: "Estudar Geometria", startedOn: .now.addingTimeInterval(-5*60), id: UUID())
) {
    FlowActivityConfiguration()
} contentStates: {
    // Multiple content states for previewing different scenarios
    FlowActivityAttributes.ContentState(isPaused: false, accumulatedTime: 0)

    FlowActivityAttributes.ContentState(isPaused: true, accumulatedTime: 12)
}
