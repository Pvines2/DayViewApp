//
//  EditEventView.swift
//  DayView
//
//  Created by Parker Vines on 11/26/24.
//
import SwiftUI

struct EditEventView: View {
    @ObservedObject var viewModel: DayViewViewModel
    var event: EventModel
    var onSave: () -> Void

    @State private var eventName: String
    @State private var eventDescription: String
    @State private var timeStart: String
    @State private var timeEnd: String
    @State private var selectedPersonnelID: String
    @State private var targetDate: Int

    init(viewModel: DayViewViewModel, event: EventModel, onSave: @escaping () -> Void) {
        self.viewModel = viewModel
        self.event = event
        self.onSave = onSave

        _eventName = State(initialValue: event.title)
        _eventDescription = State(initialValue: event.detail ?? "")
        _timeStart = State(initialValue: event.startTime ?? "")
        _timeEnd = State(initialValue: event.endTime ?? "")
        _selectedPersonnelID = State(initialValue: event.personnelId)
        _targetDate = State(initialValue: event.date ?? 0)
    }

    var body: some View {
        VStack {
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
                    viewModel.updateEvent(
                        event: event,
                        name: eventName,
                        description: eventDescription,
                        timeStart: timeStart,
                        timeEnd: timeEnd,
                        personnelID: selectedPersonnelID,
                        date: targetDate
                    )
                    onSave()
                }) {
                    Text("Save Changes")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Edit Event")
            .navigationBarTitleDisplayMode(.inline) 
        }
    }
}
