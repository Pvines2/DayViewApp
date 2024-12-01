//
//  CalendarView.swift
//  DayView
//
//  Created by Parker Vines on 11/30/24.
//


import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: DayViewViewModel
    @State private var currentMonth: Date = Date() // Tracks the currently displayed month
    @State private var showAddPersonSheet = false
    @State private var showWeatherView = false

    var body: some View {
        NavigationView {
            VStack {
                // Month and navigation controls
                HStack {
                    Button(action: { moveMonth(by: -1) }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                    }
                    Spacer()
                    Text(currentMonthFormatted)
                        .font(.title)
                        .bold()
                    Spacer()
                    Button(action: { moveMonth(by: 1) }) {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                    }
                }
                .padding()

                // Days of the week header
                HStack {
                    ForEach(Calendar.current.shortWeekdaySymbols, id: \.self) { day in
                        Text(day)
                            .frame(maxWidth: .infinity)
                            .font(.subheadline)
                            .bold()
                    }
                }
                .padding(.bottom, 5)

                // Calendar grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                    ForEach(datesForCurrentMonth, id: \.self) { date in
                        if Calendar.current.isDate(date, equalTo: currentMonth, toGranularity: .month) {
                            NavigationLink(
                                destination: DayDetailView(
                                    date: Calendar.current.component(.year, from: date) * 10000 +
                                          Calendar.current.component(.month, from: date) * 100 +
                                          Calendar.current.component(.day, from: date),
                                    viewModel: viewModel
                                )
                            ) {
                                CalendarDayView(
                                    date: date,
                                    events: viewModel.events,
                                    personnel: viewModel.personnel,
                                    predefinedColors: viewModel.predefinedColors
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        } else {
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()

                // Bottom Button Bar with Icons
                HStack {
                    Spacer()

                    // Add Person Button
                    Button(action: {
                        showAddPersonSheet = true
                    }) {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.largeTitle)
                            Text("Add Person")
                                .font(.caption)
                        }
                    }
                    .sheet(isPresented: $showAddPersonSheet) {
                        AddPersonView(viewModel: viewModel)
                    }

                    Spacer()

                    // Weather Info Button
                    Button(action: {
                        showWeatherView = true
                    }) {
                        VStack {
                            Image(systemName: "cloud.fill")
                                .font(.largeTitle)
                            Text("Weather")
                                .font(.caption)
                        }
                    }
                    .sheet(isPresented: $showWeatherView) {
                        WeatherView()
                    }

                    Spacer()

                    // Log Out Button
                    Button(action: {
                        AuthViewModel().logOut()
                    }) {
                        VStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                .font(.largeTitle)
                            Text("Log Out")
                                .font(.caption)
                        }
                    }

                    Spacer()
                }
                .padding(.vertical)
                .background(Color(UIColor.systemGray6))
            }
            .onAppear {
                viewModel.fetchAllEvents()
                viewModel.fetchPersonnelData()
            }
            .navigationBarHidden(true)
        }
    }

    // Helpers
    private var currentMonthFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth)
    }

    private var datesForCurrentMonth: [Date] {
        let calendar = Calendar.current
        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))!
        let range = calendar.range(of: .day, in: .month, for: currentMonth)!

        // padding for the first week of the month
        let weekday = calendar.component(.weekday, from: firstOfMonth) - 1
        let padding = (0..<weekday).map { _ in Date.distantPast }

        // Add dates for the month
        let dates = range.compactMap { day -> Date? in
            calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth)
        }

        return padding + dates
    }

    private func moveMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }
}
