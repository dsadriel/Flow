//
//  FlowApp.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import SwiftUI
import SwiftData

@main
struct FlowApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: [FlowSession.self])
    }
}
