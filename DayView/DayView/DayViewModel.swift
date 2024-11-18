//
//  DayViewModel.swift
//  DayView
//
//  Created by Parker Vines on 11/14/24.
//

import Foundation
import FirebaseFirestore

/* Defines model to represent our data from Firebase/
   We use Codable for encoding and decoding*/
struct DayViewModel: Codable, Identifiable {
    @DocumentID var id: String? //ocumentID tells firebase to assign this property the document ID from Firestore
    var name: String? // '?' for Optional Variable
    var date: String?
    var day: Int?
    var month: String?
    var year: Int?
    var type: String?
    
}
