//
//  PersonnelModel.swift
//  DayView
//
//  Created by Parker Vines on 11/16/24.
//

import Foundation
import FirebaseFirestore

struct Personnel: Identifiable, Codable {
    @DocumentID var id: String?  // Firestore assigns the document ID
    var name: String
    var color: String  // Color associated with the personnel
    
}

