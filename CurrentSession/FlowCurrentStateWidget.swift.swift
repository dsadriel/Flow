//
//  FlowCurrentStateWidget.swift.swift
//  Flow
//
//  Created by sofia leitao on 22/10/25.
//
import WidgetKit
import SwiftUI

struct CurrentStateEntry: TimelineEntry {
    let date: Date
}

struct CurrentStateProvider: TimelineProvider {
    func placeholder(in context: Context) -> CurrentStateEntry { .init(date: .now) }
    func getSnapshot(in context: Context, completion: @escaping (CurrentStateEntry) -> Void) {
        completion(.init(date: .now))
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<CurrentStateEntry>) -> Void) {
        let entry = CurrentStateEntry(date: .now)
        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60)))
        completion(timeline)
    }
}

struct CurrentStateView: View {
    let entry: CurrentStateEntry
    
    var body: some View {
        ZStack {
            Color.black
            VStack(spacing: 6) {
                Image(systemName: "waveform.circle.fill")
                    .font(.system(size: 26))
                    .foregroundStyle(.white)
                Text("In Flow")
                    .font(.caption)
                    .foregroundStyle(.white)
                Text()
                    .font(.headline)
                    .monospacedDigit()
                    .foregroundStyle(.white)
            }
            .padding(8)
        }
    }
}

struct FlowCurrentStateWidget: Widget {   
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "FlowCurrentState", provider: CurrentStateProvider()) { entry in
            CurrentStateView(entry: entry)
        }
        .configurationDisplayName("Current State")
        .description("Quick view of your current flow state.")
        .supportedFamilies([.systemSmall])
    }
}
