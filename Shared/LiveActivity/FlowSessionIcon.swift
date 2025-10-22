//
//  FlowSessionIcon.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//


import SwiftUI

struct FlowSessionIcon: View {
    var color: Color
    var supplementaryIconName: String?

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(.waveSymbol)
                .foregroundStyle(color)
                .padding(3)
                .clipShape(Circle())

            if let supplementaryIconName {
                Image(systemName: supplementaryIconName)
                    .font(.callout)
                    .foregroundStyle(.white)
            }
        }
    }

    init(color: Color = .primary) {
        self.color = color
    }

    init(isPaused: Bool, showIcon: Bool = true) {
        self.color = isPaused ? .Flow.tertiary : .Flow.secondary
        if showIcon {
            self.supplementaryIconName = "\(isPaused ? "pause" : "play").circle.fill"
        }
    }
}

#Preview {
    FlowSessionIcon(isPaused: true)
}
