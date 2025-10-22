//
//  CurrentSessionWidget.swift
//  CurrentSessionWidget
//
//  Created by sofia leitao on 22/10/25.
//

import WidgetKit
import SwiftUI


struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct CurrentSessionWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color.clear
            Text("Clique aqui e comece seu flow")
                .multilineTextAlignment(.center)
                .font(.headline)
                .padding(.horizontal, 8)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct CurrentSessionWidget: Widget {
    let kind: String = "CurrentSessionWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            CurrentSessionWidgetEntryView(entry: entry)
        }
    }
}
