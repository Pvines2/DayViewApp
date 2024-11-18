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
    var personnelId: String?     // Links to a Personnel document
    var title: String            // Title of the event
    var detail: String?          // Description or location of the event
    var startTime: String?       // Start time
    var endTime: String?         // End time
}
