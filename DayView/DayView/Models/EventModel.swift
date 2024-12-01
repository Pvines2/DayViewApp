//
//  EventModel.swift
//  DayView
//
//  Created by Parker Vines on 11/17/24.
//

import Foundation
import FirebaseFirestore

struct EventModel: Identifiable, Codable {
    @DocumentID var id: String?  // Firestore assigns the document ID
    var personnelId: String
    var title: String
    var detail: String?
    var startTime: String?
    var endTime: String?
    var date: Int?               
}
