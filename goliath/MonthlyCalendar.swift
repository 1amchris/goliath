//
//  MonthlyCalendar.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-22.
//

import SwiftUI
import SwiftData

struct MonthlyStreakCalendarView: View {
    @State var monthAnchor: Date = .now
    @State var selectedDate: Date? = nil

    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 6), count: 7)
    
    @Query private var workouts: [Workout]

    init() {
        let comps = calendar.dateComponents([.year, .month], from: monthAnchor)
        let startOfMonth = calendar.date(from: comps)!
        let startOfNextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
        
        _workouts = Query(
            filter: #Predicate<Workout> { w in
                w.dateCompleted >= startOfMonth && w.dateCompleted < startOfNextMonth
            },
            sort: [SortDescriptor(\.dateCompleted, order: .forward)]
        )
    }

    var body: some View {
        VStack(spacing: 8) {
//            header
            weekdayHeader
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(daysForMonth(), id: \.self) { day in
                    DayCell(day: day,
                            isToday: isToday(day),
                            inCurrentMonth: isInCurrentMonth(day),
                            hasWorkouts: isInWorkoutDays(day))
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
            WorkoutsOnDayView(day: date, workouts: findWorkouts(for: date))
        }
    }

    // MARK: - Header
    private var header: some View {
        Text(monthTitle(monthAnchor))
            .font(.headline)
            .monospacedDigit()
    }

    private var weekdayHeader: some View {
        let symbols = calendar.veryShortWeekdaySymbols
        let firstWeekdayIndex = calendar.firstWeekday - 1

        // rotate to respect firstWeekday
        let ordered = Array(symbols[firstWeekdayIndex...])
                    + Array(symbols[..<firstWeekdayIndex])

        return HStack {
            ForEach(ordered, id: \.self) { s in
                Text(s.uppercased())
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 8)
    }

    // MARK: - Date helpers

    private func monthTitle(_ date: Date) -> AttributedString {
        let comps = calendar.dateComponents([.year, .month], from: date)
        let monthDate = calendar.date(from: comps) ?? date
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.setLocalizedDateFormatFromTemplate("yMMMM") // e.g., September 2025
        return AttributedString(formatter.string(from: monthDate))
    }

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

        // Locale-aware leading blanks
        let firstWeekdayIndex = calendar.firstWeekday - 1   // 0-based (e.g. Sunday=0)
        let weekdayIndex = weekdayOfFirst - 1               // 0-based
        let leading = (weekdayIndex - firstWeekdayIndex + 7) % 7

        var days: [Date] = []

        // Leading padding: days before the 1st, counting back from start
        if leading > 0 {
            for i in stride(from: leading, to: 0, by: -1) {
                let d = calendar.date(byAdding: .day, value: -i, to: start)!
                days.append(calendar.startOfDay(for: d))
            }
        }

        // Current month days
        for offset in 0..<(monthRange.count) {
            let d = calendar.date(byAdding: .day, value: offset, to: start)!
            days.append(calendar.startOfDay(for: d))
        }

        // Trailing padding to fill the last week
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
    
    private func isInWorkoutDays(_ date: Date) -> Bool {
        workouts.contains { workout in
            calendar.isDate(date, inSameDayAs: workout.dateCompleted)
        }
    }
    
    private func findWorkouts(for date: Date) -> [Workout] {
        workouts
            .filter { workout in calendar.isDate(date, inSameDayAs: workout.dateCompleted) }
            .sorted { $0.dateCompleted < $1.dateCompleted }
    }

    private func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
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
                } else {
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
