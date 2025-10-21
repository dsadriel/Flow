//
//  ActionButtons.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import SwiftUI

struct ActionButtons: View {
        var isPaused: Bool

        var body: some View {
            HStack(spacing: 6) {
                Button {
                    // Pause/Play intent
                } label: {
                    Image(systemName: isPaused ? "play.circle.fill" : "pause.circle.fill")
                        .font(.largeTitle)
                }
                .tint(isPaused ? Color.Flow.tertiary : Color.Flow.secondary)

                Button {
                    // Stop intent
                } label: {
                    Image(systemName: "stop.circle.fill")
                        .font(.largeTitle)
                }
                .tint(.red)
            }
        }
    }
