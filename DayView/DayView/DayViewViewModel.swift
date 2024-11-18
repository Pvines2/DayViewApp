//
//  DayViewViewModel.swift
//  DayView
//
//  Created by Parker Vines on 11/14/24.
//

import FirebaseFirestore
import FirebaseFirestore

class DayViewViewModel: ObservableObject {
    @Published var personnel = [Personnel]()
    @Published var events = [EventModel]()
    @Published var calendar = [DayViewModel]()  

    private var db = Firestore.firestore()

    func testFetchFromFirestore() {
        // Test fetching from the "personnel" collection
        db.collection("personnel").getDocuments { snapshot, error in
            if let error = error {
                            print("Error connecting to Firebase: \(error.localizedDescription)")
                        } else {
                            print("Successfully connected to Firebase.")
                        }
            if let error = error {
                print("Error fetching personnel: \(error)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No documents found in personnel collection.")
                return
            }

            for document in documents {
                print("Personnel Data: \(document.data())")
            }
        }
    }
    
    func addPersonnel(name: String, color: String) {
            let newPersonnel = [
                "name": name,
                "color": color
            ]
            
            db.collection("personnel").addDocument(data: newPersonnel) { error in
                if let error = error {
                    print("Error adding personnel: \(error.localizedDescription)")
                } else {
                    print("Successfully added personnel: \(name)")
                }
            }
        }

        func fetchPersonnelData() {
            db.collection("personnel").getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching personnel data: \(error.localizedDescription)")
                } else {
                    self.personnel = snapshot?.documents.compactMap { document in
                        let data = document.data()
                        guard let name = data["name"] as? String,
                              let color = data["color"] as? String else { return nil }
                        return Personnel(id: document.documentID, name: name, color: color)
                    } ?? []
                }
            }
        }

}


