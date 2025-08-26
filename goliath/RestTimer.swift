//
//  RestTimer.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-22.
//

import SwiftUI
import Combine
import UserNotifications

struct RestTimerSheet: View {
    @Binding var preferredDuration: TimeInterval

    var onFinish: () -> Void = { }
    var onSkip: () -> Void = { }
    var onNextExercise: () -> Void = { }

    @State private var remaining: TimeInterval = 0
    @State private var total: TimeInterval = 0
    @State private var endDate: Date? = nil

    @State private var ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Label("Rest", systemImage: "hourglass").font(.headline)
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
                Button { adjust(by: -10) } label: { Label("-10s", systemImage: "minus.circle") }
                    .buttonStyle(.bordered)
                Button { resetToPreferred() } label: { Label("Reset", systemImage: "arrow.clockwise") }
                    .buttonStyle(.bordered)
                Button { adjust(by: +10) } label: { Label("+10s", systemImage: "plus.circle") }
                    .buttonStyle(.bordered)
            }

            Spacer(minLength: 8)

            if remaining > 0 {
                HStack {
                    Button(role: .cancel) {
                        stopTicker()
                        cancelCompletionNotification()
                        onSkip()
                        dismiss()
                    } label: {
                        Label("Skip Rest", systemImage: "forward.end")
                    }
                    .buttonStyle(.bordered)

                    Spacer()

                    Button {
                        stopTicker()
                        cancelCompletionNotification()
                        onNextExercise()
                        dismiss()
                    } label: {
                        Label("Next Exercise", systemImage: "arrow.right.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                Button {
                    cancelCompletionNotification()
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
        .onAppear {
            resetToPreferred()
            requestNotificationAuthorizationIfNeeded()
            scheduleCompletionNotificationIfNeeded()
        }
        .onReceive(ticker) { _ in recomputeRemaining() }
        .onChange(of: scenePhase) { _, _ in
            // Recompute when going background/foreground so countdown reflects real time passed
            recomputeRemaining()
        }
        .onDisappear {
            stopTicker()
            // keep/cancel notifications based on your preference; we cancel here to be safe
            // cancelCompletionNotification()
        }
        .presentationDetents([.fraction(0.5)])
        .presentationDragIndicator(.visible)
    }

    // MARK: - Logic

    private var progress: Double {
        guard total > 0 else { return 0 }
        return (total - remaining) / total
    }

    private func recomputeRemaining() {
        guard let endDate else { return }
        let now = Date()
        remaining = max(0, endDate.timeIntervalSince(now).rounded(.down))
        if remaining <= 0 {
            remaining = 0
        }
    }

    private func tick() {
        // Not used directly anymore; we derive from endDate for resilience.
        recomputeRemaining()
    }

    /// Adjust both the *current* countdown and the *preferred* default by shifting the endDate.
    private func adjust(by seconds: TimeInterval) {
        // Update saved preference
        preferredDuration = max(0, preferredDuration + seconds)

        // Shift endDate accordingly (create one if absent)
        let now = Date()
        if endDate == nil { endDate = now.addingTimeInterval(max(0, preferredDuration)) }
        endDate = (endDate ?? now).addingTimeInterval(seconds)

        // Clamp: endDate shouldn't be in the past
        if let ed = endDate, ed < now { endDate = now }

        // Update totals/remaining
        total = max(total + seconds, 0)
        recomputeRemaining()

        // Refresh completion notification
        scheduleCompletionNotificationIfNeeded()
    }

    private func resetToPreferred() {
        total = max(1, preferredDuration.rounded())
        endDate = Date().addingTimeInterval(total)
        recomputeRemaining()
        scheduleCompletionNotificationIfNeeded()
    }

    private func stopTicker() {
        ticker.upstream.connect().cancel()
    }

    private func format(_ t: TimeInterval) -> String {
        let s = max(0, Int(t))
        return String(format: "%02d:%02d", s / 60, s % 60)
    }

    // MARK: - Local notification (optional but recommended)

    private let restNotificationId = "rest-finished-notification"

    private func requestNotificationAuthorizationIfNeeded() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .notDetermined else { return }
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
        }
    }

    private func scheduleCompletionNotificationIfNeeded() {
        guard let endDate, remaining > 0 else { return }
        cancelCompletionNotification()

        let content = UNMutableNotificationContent()
        content.title = "Rest complete"
        content.body = "Time to start your next set."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: max(1, endDate.timeIntervalSinceNow), repeats: false)
        let req = UNNotificationRequest(identifier: restNotificationId, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }

    private func cancelCompletionNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [restNotificationId])
    }
}
