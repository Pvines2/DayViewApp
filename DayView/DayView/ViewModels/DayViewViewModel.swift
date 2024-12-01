//
//  DayViewViewModel.swift
//  DayView
//
//  Created by Parker Vines on 11/14/24.
//

import Foundation
import FirebaseFirestore

class DayViewViewModel: ObservableObject {
    @Published var personnel: [Personnel] = []
    @Published var events: [EventModel] = []

    private var db = Firestore.firestore()
    
    let predefinedColors = ColorsUtility.predefinedColors
    
    // Fetch all events
    func fetchAllEvents() {
        db.collection("event").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching events: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.events = snapshot?.documents.compactMap { document in
                        let data = document.data()
                        return EventModel(
                            id: document.documentID,  // Firestore assigns the ID
                            personnelId: data["personnelID"] as? String ?? "",
                            title: data["eventName"] as? String ?? "",
                            detail: data["eventDescription"] as? String ?? "",
                            startTime: data["timeStart"] as? String ?? "",
                            endTime: data["timeEnd"] as? String ?? "",
                            date: data["date"] as? Int ?? 0
                        )
                    } ?? []
                    print("Fetched events: \(self.events)")
                }
            }
        }
    }

    // Fetch personnel data
    func fetchPersonnelData() {
        db.collection("personnel").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching personnel: \(error)")
            } else {
                self.personnel = snapshot?.documents.compactMap { doc in
                    let data = doc.data()
                    print("Personnel document: \(data)") // Debugging
                    return Personnel(
                        id: doc.documentID,
                        name: data["name"] as? String ?? "",
                        color: data["color"] as? String ?? ""
                    )
                } ?? []
                print("Personnel fetched: \(self.personnel)")
            }
        }
    }

    // Add personnel
    func addPersonnel(name: String, colorName: String) {
        guard let matchingColor = predefinedColors.first(where: { $0.name.lowercased() == colorName.lowercased() }) else {
            print("Invalid color name: \(colorName)") // Debugging
            return
        }
        
        db.collection("personnel").addDocument(data: [
            "name": name,
            "color": colorName  // Save color as name in the database
        ]) { error in
            if let error = error {
                print("Error adding personnel: \(error)")
            } else {
                print("Personnel successfully added: \(name), color: \(colorName)") // Debugging
            }
        }
    }

    // Fetch events for a specific date
    func fetchEvents(forDate date: Int) {
        db.collection("event")
            .whereField("date", isEqualTo: date)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching events: \(error)")
                } else {
                    self.events = snapshot?.documents.compactMap { document in
                        let data = document.data()
                        return EventModel(
                            id: document.documentID,
                            personnelId: data["personnelID"] as? String ?? "",
                            title: data["eventName"] as? String ?? "",
                            detail: data["eventDescription"] as? String ?? "",
                            startTime: data["timeStart"] as? String ?? "",
                            endTime: data["timeEnd"] as? String ?? "",
                            date: data["date"] as? Int ?? 0
                        )
                    } ?? []
                    print("Fetched events for date \(date): \(self.events)")
                }
            }
    }

    // Fetch events for the month
    func fetchEventsForMonth(year: Int, month: Int) {
        let startOfMonth = year * 10000 + month * 100 + 1
        let endOfMonth = year * 10000 + month * 100 + 31
        
        db.collection("event")
            .whereField("date", isGreaterThanOrEqualTo: startOfMonth)
            .whereField("date", isLessThanOrEqualTo: endOfMonth)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching events for month: \(error)")
                } else {
                    self.events = snapshot?.documents.compactMap { document in
                        let data = document.data()
                        return EventModel(
                            id: document.documentID,
                            personnelId: data["personnelID"] as? String ?? "",
                            title: data["eventName"] as? String ?? "",
                            detail: data["eventDescription"] as? String ?? "",
                            startTime: data["timeStart"] as? String ?? "",
                            endTime: data["timeEnd"] as? String ?? "",
                            date: data["date"] as? Int ?? 0
                        )
                    } ?? []
                    print("Fetched events for month \(month) of year \(year): \(self.events)")
                }
            }
    }

    // Add a new event
    func addEvent(name: String, description: String, timeStart: String, timeEnd: String, personnelID: String, date: Int) {
        db.collection("event").addDocument(data: [
            "eventName": name,
            "eventDescription": description,
            "timeStart": timeStart,
            "timeEnd": timeEnd,
            "personnelID": personnelID,
            "date": date  // Date in YYYYMMDD format
        ]) { error in
            if let error = error {
                print("Error adding event: \(error)")
            } else {
                print("Event successfully added!")
            }
        }
    }

    // Update an existing event
    func updateEvent(event: EventModel, name: String, description: String, timeStart: String, timeEnd: String, personnelID: String, date: Int) {
        guard let eventID = event.id else { return }  
        
        db.collection("event").document(eventID).updateData([
            "eventName": name,
            "eventDescription": description,
            "timeStart": timeStart,
            "timeEnd": timeEnd,
            "personnelID": personnelID,
            "date": date
        ]) { error in
            if let error = error {
                print("Error updating event: \(error)")
            } else {
                print("Event successfully updated!")
            }
        }
    }
}

