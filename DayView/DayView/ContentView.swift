//
//  ContentView.swift
//  DayView
//
//  Created by Parker Vines on 11/14/24.
//

import SwiftUI


struct AddPersonView: View {
    
    @ObservedObject var viewModel: DayViewViewModel
    
    // State properties for input fields
    @State private var personnelName: String = ""
    @State private var personnelColor: String = ""
    @Environment(\.dismiss) var dismiss  
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personnel Details")) {
                    TextField("Name", text: $personnelName)
                    TextField("Color", text: $personnelColor)
                }
                
                Section {
                    Button(action: {
                        guard !personnelName.isEmpty, !personnelColor.isEmpty else {
                            print("Both fields are required.")
                            return
                        }
                        viewModel.addPersonnel(name: personnelName, color: personnelColor)
                        dismiss()
                    }) {
                        Text("Add")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("Add Person")
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            })
        }
    }
}


struct ContentView: View {
    // Define IdentifiableDay to make Int conform to Identifiable
    struct IdentifiableDay: Identifiable {
        let id: Int  // use day number as  unique identifier
    }

    // ViewModel for Firestore operations
    @ObservedObject var viewModel = DayViewViewModel()
    @State private var showAddPersonSheet = false
    @State private var selectedDay: IdentifiableDay? = nil

    var body: some View {
        VStack {
            // Month and Weather
            VStack {
                Text("November")  // placeholder: static month title
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Weather: 68°F, Cloudy")  // placeholder for dynamic weather data
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()

            // calendar layout
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(1...30, id: \.self) { day in
                    CalendarDayView(day: day)
                        .onTapGesture {
                            selectedDay = IdentifiableDay(id: day)
                        }
                }
            }
            .padding()

            Spacer()

            // add person button
            Button(action: {
                showAddPersonSheet.toggle()
            }) {
                Text("Add Person")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .sheet(item: $selectedDay) { identifiableDay in
            DayDetailView(day: identifiableDay.id)
        }
        .sheet(isPresented: $showAddPersonSheet) {
            AddPersonView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.fetchPersonnelData()  // fetch personnel data from Firestore
        }
    }
}



struct CalendarDayView: View {
    let day: Int

    var body: some View {
        ZStack(alignment: .topLeading) {  // Align contents to the top-left corner
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(radius: 1)

            Text("\(day)")  // Display the day number
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding([.top, .leading], 8)  // Add padding to position the text
        }
        .frame(height: 100)  // Static size for each calendar cell
    }
}




struct DayDetailView: View {
    let day: Int
    @State private var selectedEvent: Bool = false  // Tracks whether an event is selected
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            // Top Section: Back Button and Day
            HStack {
                Button("Back") {
                    dismiss()
                }
                .padding()
                Spacer()
            }
            
            Text("Day \(day)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // Placeholder Event Section
            ScrollView {
                VStack(spacing: 16) {
                    Text("No events for this day")
                        .foregroundColor(.gray)
                        .italic()
                }
                .padding()
            }
            
            Spacer()
            
            // Bottom Buttons
            HStack {
                Button(action: {
                    // Edit Event Action
                }) {
                    Text("Edit Event")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedEvent ? Color.blue : Color.gray)  // Gray if no event selected
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(!selectedEvent)  // Disable if no event selected
                
                Button(action: {
                    // Add Event Action
                }) {
                    Text("Add Event")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
    
}



#Preview {
    ContentView()
}



