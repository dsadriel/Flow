//
//  ActionButtons.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import SwiftUI
import AppIntents

struct ActionButtons: View {
    var onPause: () -> Void = {}
    var onResume: () -> Void = {}
    var onStop: () -> Void = {}

    var isPaused: Bool


    var body: some View {
        HStack(spacing: 6) {
            Button {
                isPaused ? onResume() : onPause()
            } label: {
                Image(systemName: isPaused ? "play.circle.fill" : "pause.circle.fill")
                    .font(.largeTitle)
            }
            .tint(isPaused ? Color.Flow.tertiary : Color.Flow.secondary)

            Button {
                onStop()
            } label: {
                Image(systemName: "stop.circle.fill")
                    .font(.largeTitle)
            }
            .tint(.red)
        }
    }
}
