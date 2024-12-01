//
//  DayDetailView.swift
//  DayView
//
//  Created by Parker Vines on 11/26/24.
//

import SwiftUI

struct DayDetailView: View {
    let date: Int // YYYYMMDD format
    @ObservedObject var viewModel: DayViewViewModel

    @State private var showAddEventSheet = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Events for \(formattedDate)")
                    .font(.largeTitle)
                    .padding()

                if viewModel.events.isEmpty {
                    Text("No events for this day.")
                        .foregroundColor(.gray)
                } else {
                    List(viewModel.events.filter { $0.date == date }) { event in
                        NavigationLink(destination: EditEventView(viewModel: viewModel, event: event) {
                            viewModel.fetchEvents(forDate: date)
                        }) {
                            VStack(alignment: .leading) {
                                Text(event.title)
                                    .font(.headline)
                                Text(event.detail ?? "No description")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }

                Spacer()

                Button(action: {
                    showAddEventSheet.toggle()
                }) {
                    Text("Add Event")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .onAppear {
                viewModel.fetchEvents(forDate: date)
            }
            .sheet(isPresented: $showAddEventSheet) {
                AddEventView(viewModel: viewModel, date: date)
            }
        }
    }

    private var formattedDate: String {
        let year = date / 10000
        let month = (date / 100) % 100
        let day = date % 100
        return "\(year)-\(month)-\(day)"
    }
}
