//
//  RestTimer.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-22.
//

import SwiftUI
import Combine

struct RestTimerSheet: View {
    @Binding var preferredDuration: TimeInterval

    var onFinish: () -> Void = { }
    var onSkip: () -> Void = { }
    var onNextExercise: () -> Void = { }

    @State private var remaining: TimeInterval = 0
    @State private var total: TimeInterval = 0
    @State private var ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Label("Rest", systemImage: "hourglass")
                    .font(.headline)
                Spacer()
                Text("From: \(format(total))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }

            Text(format(remaining))
                .font(.system(size: 44, weight: .bold, design: .rounded))
                .monospacedDigit()
                .frame(maxWidth: .infinity)

            ProgressView(value: progress)
                .animation(.linear(duration: 0.2), value: progress)

            HStack(spacing: 12) {
                Button { adjust(by: -10) } label: {
                    Label("-10s", systemImage: "minus.circle")
                }
                .buttonStyle(.bordered)

                Button { resetToPreferred() } label: {
                    Label("Reset", systemImage: "arrow.clockwise")
                }
                .buttonStyle(.bordered)

                Button { adjust(by: +10) } label: {
                    Label("+10s", systemImage: "plus.circle")
                }
                .buttonStyle(.bordered)
            }

            Spacer(minLength: 8)

            // Actions
            if remaining > 0 {
                HStack {
                    Button(role: .cancel) {
                        stopTicker()
                        onSkip()
                        dismiss()
                    } label: {
                        Label("Skip Rest", systemImage: "forward.end")
                    }
                    .buttonStyle(.bordered)

                    Spacer()

                    Button {
                        stopTicker()
                        onNextExercise()
                        dismiss()
                    } label: {
                        Label("Next Exercise", systemImage: "arrow.right.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                Button {
                    onFinish()
                    dismiss()
                } label: {
                    Label("Start Next Set", systemImage: "play.circle.fill")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(.horizontal)
        .padding(.top, 12)
        .onAppear { resetToPreferred() }
        .onReceive(ticker) { _ in tick() }
        .onDisappear { stopTicker() }
        .presentationDetents([.fraction(0.5)])
        .presentationDragIndicator(.visible)
    }

    // MARK: - Logic

    private var progress: Double {
        guard total > 0 else { return 0 }
        return (total - remaining) / total
    }

    private func tick() {
        guard remaining > 0 else { return }
        remaining -= 1
        if remaining <= 0 {
            remaining = 0
            // (Optionally auto-call onFinish here)
        }
    }

    /// Adjust both the *current* countdown and the *preferred* default.
    private func adjust(by seconds: TimeInterval) {
        // Update the saved preference first
        preferredDuration = max(0, preferredDuration + seconds)

        // Keep total in sync with the saved preference
        total = max(0, preferredDuration)

        // Adjust remaining similarly, but never above new total or below 0
        remaining = min(max(0, remaining + seconds), total)
    }

    private func resetToPreferred() {
        total = max(1, preferredDuration.rounded())
        remaining = total
    }

    private func stopTicker() {
        ticker.upstream.connect().cancel()
    }

    private func format(_ t: TimeInterval) -> String {
        let s = max(0, Int(t))
        return String(format: "%02d:%02d", s / 60, s % 60)
    }
}
