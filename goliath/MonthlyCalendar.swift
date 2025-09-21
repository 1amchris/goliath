//
//  MonthlyCalendar.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-22.
//

import SwiftUI
import SwiftData

struct MonthlyStreakCalendarView: View {
    // Drives which month is shown
    @State private var monthAnchor: Date = .now
    @State private var selectedDate: Date? = nil

    // For detecting day rollovers
    @State private var now: Date = .now
    private let minuteTicker = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 6), count: 7)

    // Fetch broadly; filter by month in-memory
    @Query(sort: [SortDescriptor(\Workout.dateCompleted, order: .forward)])
    private var allWorkouts: [Workout]

    // Workouts within the currently displayed month
    private var workoutsThisMonth: [Workout] {
        let start = startOfMonth(monthAnchor)
        let next  = calendar.date(byAdding: .month, value: 1, to: start)!
        return allWorkouts.filter { $0.dateCompleted >= start && $0.dateCompleted < next }
    }

    var body: some View {
        VStack(spacing: 8) {
            weekdayHeader
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(daysForMonth(), id: \.self) { day in
                    DayCell(
                        day: day,
                        isToday: isToday(day),
                        inCurrentMonth: isInCurrentMonth(day),
                        hasWorkouts: hasWorkouts(on: day)
                    )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        guard isInCurrentMonth(day) else { return }
                        selectedDate = day
                    }
                }
            }
            .padding(.horizontal, 8)
        }
        .padding(.vertical, 8)
        .sheet(item: $selectedDate) { date in
            WorkoutsOnDayView(
                day: date,
                workouts: workoutsOn(date)
            )
        }
        // Keep initial anchor in sync with "now"
        .onAppear { monthAnchor = .now }
        // Recompute at minute granularity; detect day change
        .onReceive(minuteTicker) { tick in
            // only act when the day actually changes (avoids extra re-renders)
            if !calendar.isDate(now, inSameDayAs: tick) {
                now = tick
                // If we’re showing “current month”, ensure anchor follows into the new month
                // (e.g., at midnight on Mar 1st while viewing Feb, leave anchor alone)
                if calendar.isDate(monthAnchor, inSameMonthAs: .now) {
                    monthAnchor = .now
                }
            }
        }
    }

    // MARK: - Header
    private var weekdayHeader: some View {
        let symbols = calendar.veryShortWeekdaySymbols
        let firstWeekdayIndex = calendar.firstWeekday - 1
        let ordered = Array(symbols[firstWeekdayIndex...]) + Array(symbols[..<firstWeekdayIndex])

        return HStack {
            ForEach(Array(ordered.enumerated()), id: \.offset) { _, s in
                Text(s.uppercased())
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 8)
    }

    // MARK: - Date helpers

    private func startOfMonth(_ date: Date) -> Date {
        let comps = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: comps)!
    }

    private func daysForMonth() -> [Date] {
        let start = calendar.startOfDay(for: startOfMonth(monthAnchor))

        guard
            let monthRange = calendar.range(of: .day, in: .month, for: start),
            let weekdayOfFirst = calendar.dateComponents([.weekday], from: start).weekday
        else { return [] }

        let firstWeekdayIndex = calendar.firstWeekday - 1   // 0-based
        let weekdayIndex = weekdayOfFirst - 1               // 0-based
        let leading = (weekdayIndex - firstWeekdayIndex + 7) % 7

        var days: [Date] = []

        if leading > 0 {
            for i in stride(from: leading, to: 0, by: -1) {
                let d = calendar.date(byAdding: .day, value: -i, to: start)!
                days.append(calendar.startOfDay(for: d))
            }
        }

        for offset in 0..<monthRange.count {
            let d = calendar.date(byAdding: .day, value: offset, to: start)!
            days.append(calendar.startOfDay(for: d))
        }

        let remainder = days.count % 7
        if remainder != 0 {
            let need = 7 - remainder
            let nextStart = calendar.date(byAdding: .month, value: 1, to: start)!
            for i in 0..<need {
                let d = calendar.date(byAdding: .day, value: i, to: nextStart)!
                days.append(calendar.startOfDay(for: d))
            }
        }

        return days
    }

    private func isInCurrentMonth(_ date: Date) -> Bool {
        calendar.isDate(date, equalTo: monthAnchor, toGranularity: .month)
    }

    private func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }

    private func hasWorkouts(on date: Date) -> Bool {
        workoutsThisMonth.contains { calendar.isDate($0.dateCompleted, inSameDayAs: date) }
    }

    private func workoutsOn(_ date: Date) -> [Workout] {
        workoutsThisMonth
            .filter { calendar.isDate($0.dateCompleted, inSameDayAs: date) }
            .sorted { $0.dateCompleted < $1.dateCompleted }
    }
}

// MARK: - Tiny helper for month compare
private extension Calendar {
    func isDate(_ d1: Date, inSameMonthAs d2: Date) -> Bool {
        isDate(d1, equalTo: d2, toGranularity: .month)
    }
}


private struct WorkoutsOnDayView: View {
    let day: Date
    let workouts: [Workout]

    var body: some View {
        NavigationStack {
            Group {
                if workouts.isEmpty {
                    ContentUnavailableView(
                        "No workouts",
                        systemImage: "figure.run",
                        description: Text("There are no registered workouts for this day. Remember to use the app when working out so they show up here :)")
                    )
                } else if workouts.count == 1, let workout = workouts.first {
                    // Automatically show the detail when only one workout
                    ReviewWorkoutView(workout: workout)
                } else {
                    // Otherwise show the list
                    List(workouts) { w in
                        NavigationLink {
                            ReviewWorkoutView(workout: w)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(w.preset?.name ?? "Workout")
                                    .font(.headline)
                                Text(w.dateCompleted, style: .time)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle(day.formatted(date: .abbreviated, time: .omitted))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Day Cell

private struct DayCell: View {
    let day: Date
    let isToday: Bool
    let inCurrentMonth: Bool
    var hasWorkouts: Bool = false

    private let calendar = Calendar.current

    var body: some View {
        let number = calendar.component(.day, from: day)

        ZStack {
            if isToday {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.accentColor, lineWidth: 1.5)
            }

            if hasWorkouts {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.orange.opacity(0.12))
            }

            Text("\(number)")
                .font(.body)
                .monospacedDigit()
                .foregroundStyle(inCurrentMonth ? .primary : .secondary)
                .opacity(inCurrentMonth ? 1 : 0.4)
                .frame(maxWidth: .infinity, minHeight: 36)
                .overlay(alignment: .topTrailing) {
                    if hasWorkouts {
                        Text("🔥")
                            .font(.caption2)
                            .padding(.top, 2)
                            .padding(.trailing, 3)
                            .accessibilityHidden(true)
                    }
                }
        }
        .frame(height: 36)
        .contentShape(Rectangle())
    }
}
