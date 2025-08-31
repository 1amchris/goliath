//
//  RestTimer.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-22.
//

import SwiftUI
import Combine
import UserNotifications
import UIKit

private let feedback = UINotificationFeedbackGenerator()

struct RestTimerSheet: View {
    @Binding var preferredDuration: TimeInterval

    var onFinish: () -> Void = { }
    var onSkip: () -> Void = { }
    var onNextExercise: () -> Void = { }

    @State private var remaining: TimeInterval = 0
    { didSet { if oldValue != remaining && remaining == 0 {
        feedback.notificationOccurred(.success)
    }}}
    @State private var total: TimeInterval = 0
    @State private var endDate: Date? = nil

    @State private var ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.scenePhase) private var scenePhase

    // Notification IDs
    private let restNotificationId = "rest-finished"
    private let restFollowUpId = "rest-finished.followup"

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
                        cancelCompletionNotifications()
                        onSkip()
                        dismiss()
                    } label: {
                        Label("Skip Rest", systemImage: "forward.end")
                    }
                    .buttonStyle(.bordered)

                    Spacer()

                    Button {
                        stopTicker()
                        cancelCompletionNotifications()
                        onNextExercise()
                        dismiss()
                    } label: {
                        Label("Next Exercise", systemImage: "arrow.right.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                Button {
                    cancelCompletionNotifications()
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
            scheduleCompletionNotificationsIfNeeded()
            feedback.prepare()
        }
        .onReceive(ticker) { _ in recomputeRemaining() }
        .onChange(of: scenePhase) { _, _ in recomputeRemaining() } // stay accurate across bg/fg
        .onDisappear {
            stopTicker()
            // if you prefer to keep pending notifications when dismissing, comment this out:
            // cancelCompletionNotifications()
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

    /// Adjusts current countdown and preferred default by shifting the endDate.
    private func adjust(by seconds: TimeInterval) {
        preferredDuration = max(0, preferredDuration + seconds)

        let now = Date()
        if endDate == nil { endDate = now.addingTimeInterval(max(0, preferredDuration)) }
        endDate = (endDate ?? now).addingTimeInterval(seconds)

        if let ed = endDate, ed < now { endDate = now }

        total = max(0, total + seconds)
        recomputeRemaining()
        scheduleCompletionNotificationsIfNeeded()
    }

    private func resetToPreferred() {
        total = max(1, preferredDuration.rounded())
        endDate = Date().addingTimeInterval(total)
        recomputeRemaining()
        scheduleCompletionNotificationsIfNeeded()
    }

    private func stopTicker() {
        ticker.upstream.connect().cancel()
    }

    private func format(_ t: TimeInterval) -> String {
        let s = max(0, Int(t))
        return String(format: "%02d:%02d", s / 60, s % 60)
    }

    // MARK: - Local notifications (prominent)

    private func scheduleCompletionNotificationsIfNeeded() {
        guard let endDate, remaining > 0 else { return }
        cancelCompletionNotifications()

        let content = UNMutableNotificationContent()
        content.title = "⏱️ Rest Done"
        content.body = "Let’s start your next set."
        content.threadIdentifier = "rest-session"
        content.badge = 1

        if #available(iOS 15.0, *) {
            content.interruptionLevel = .timeSensitive
            content.relevanceScore = 0.9
        }

        let notification = UNNotificationRequest(
            identifier: restNotificationId,
            content: content,
            trigger: UNTimeIntervalNotificationTrigger(timeInterval: max(1, endDate.timeIntervalSinceNow), repeats: false)
        )
        UNUserNotificationCenter.current().add(notification, withCompletionHandler: nil)
    }

    private func cancelCompletionNotifications() {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [restNotificationId, restFollowUpId])
    }
}

