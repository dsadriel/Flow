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
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FlowActivityAttributes.self) { context in
            // FlowActivityContentView
            // .activityBackgroundTint(context.state.isPaused ? .Flow.tertiary : .Flow.secondary)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    // FlowSessionIcon
                    //    .font(.largeTitle)
                }

                DynamicIslandExpandedRegion(.trailing) {
                    // Empty
                }

                DynamicIslandExpandedRegion(.center) {
                    // Name
                }

                DynamicIslandExpandedRegion(.bottom) {
                    // HStack
                    // Spacer
                    // TimerTextView
                }
            } compactLeading: {
                // FlowSessionIcon
            } compactTrailing: {
                // TimerTextView
            } minimal: {
                // FlowSessionIcon
            }
        }
        .supplementalActivityFamilies([.small])
    }
}

// MARK: - Previews
/// Live Activity previews work differently than regular widget previews
/// You need to provide sample attributes and content states
#Preview(
    "Notification",
    as: .content,  // Preview type - can be .content, .dynamicIsland, etc.
    using: FlowActivityAttributes()
) {
    FlowActivityConfiguration()
} contentStates: {
    // Multiple content states for previewing different scenarios
    FlowActivityAttributes.ContentState()

    FlowActivityAttributes.ContentState()
}
