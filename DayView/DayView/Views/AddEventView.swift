//
//  AddEventView.swift
//  DayView
//
//  Created by Parker Vines on 11/26/24.
//


import SwiftUI

struct AddEventView: View {
    @ObservedObject var viewModel: DayViewViewModel
    @Environment(\.dismiss) var dismiss

    @State private var eventName: String = ""
    @State private var eventDescription: String = ""
    @State private var timeStart: String = ""
    @State private var timeEnd: String = ""
    @State private var selectedPersonnelID: String = ""

    let date: Int // YYYYMMDD format

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Event Name", text: $eventName)
                    TextField("Event Description", text: $eventDescription)
                    TextField("Start Time", text: $timeStart)
                    TextField("End Time", text: $timeEnd)
                }

                Section(header: Text("Assign Personnel")) {
                    Picker("Select Personnel", selection: $selectedPersonnelID) {
                        ForEach(viewModel.personnel, id: \.id) { person in
                            Text(person.name).tag(person.id ?? "")
                        }
                    }
                }

                Button(action: {
                    guard !eventName.isEmpty, !timeStart.isEmpty, !timeEnd.isEmpty, !selectedPersonnelID.isEmpty else {
                        print("All fields are required.")
                        return
                    }

                    viewModel.addEvent(
                        name: eventName,
                        description: eventDescription,
                        timeStart: timeStart,
                        timeEnd: timeEnd,
                        personnelID: selectedPersonnelID,
                        date: date
                    )
                    dismiss()
                }) {
                    Text("Add Event")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Add Event")
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            })
        }
    }
}
