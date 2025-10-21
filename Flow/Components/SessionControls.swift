//
//  SessionControls.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import SwiftUI

struct SessionControls: View {
    let hasCurrentSession: Bool
    let isPaused: Bool
    let onStart: () -> Void
    let onPause: () -> Void
    let onResume: () -> Void
    let onEnd: () -> Void
    
    @State private var holdProgress: CGFloat = 0
    @State private var isHolding = false
    @State private var holdTimer: Timer?
    
    private let holdDuration: TimeInterval = 2.0
    
    var body: some View {
        HStack(spacing: 12) {
            if !hasCurrentSession {
                // Start Button
                Button {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    onStart()
                } label: {
                    Label("Start Session", systemImage: "play.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            } else {
                // Pause/Resume Button
                Button {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    if isPaused {
                        onResume()
                    } else {
                        onPause()
                    }
                } label: {
                    Label(
                        isPaused ? "Resume" : "Pause",
                        systemImage: isPaused ? "play.fill" : "pause.fill"
                    )
                    .frame(maxWidth: .infinity)
                }
                .tint(isPaused ? Color.Flow.secondary : Color.Flow.tertiary)
                .buttonStyle(.bordered)
                .controlSize(.large)
                
                // Hold to End Button
                HoldToEndButton(
                    holdProgress: $holdProgress,
                    isHolding: $isHolding,
                    onEnd: onEnd
                )
            }
        }
    }
}

struct HoldToEndButton: View {
    @Binding var holdProgress: CGFloat
    @Binding var isHolding: Bool
    let onEnd: () -> Void
    
    @State private var holdTimer: Timer?
    private let holdDuration: TimeInterval = 1.5

    var body: some View {
        Button {} label: {
            Label("Stop", systemImage: "stop.fill")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .tint(.red)
        .controlSize(.large)
        .background(
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.red.opacity(0.4))
                    .frame(width: geometry.size.width * holdProgress)
            }
            .clipShape(RoundedRectangle(cornerRadius: 32))
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !isHolding {
                        startHolding()
                    }
                }
                .onEnded { _ in
                    stopHolding()
                }
        )
    }
    
    private func startHolding() {
        isHolding = true
        holdProgress = 0
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        holdTimer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            withAnimation(.linear(duration: 0.016)) {
                holdProgress += CGFloat(0.016 / holdDuration)
            }
            
            if holdProgress >= 1.0 {
                stopHolding()
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                onEnd()
            }
        }
    }
    
    private func stopHolding() {
        isHolding = false
        holdTimer?.invalidate()
        holdTimer = nil
        
        if holdProgress > 0 && holdProgress < 1.0 {
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
        }
        
        withAnimation(.easeOut(duration: 0.2)) {
            holdProgress = 0
        }
    }
}

#Preview {
    SessionControls(hasCurrentSession: false, isPaused: false, onStart: {}, onPause: {}, onResume: {}, onEnd: {})

    SessionControls(hasCurrentSession: true, isPaused: false, onStart: {}, onPause: {}, onResume: {}, onEnd: {})

    SessionControls(hasCurrentSession: true, isPaused: true, onStart: {}, onPause: {}, onResume: {}, onEnd: {})
}
