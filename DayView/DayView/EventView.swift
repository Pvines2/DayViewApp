//
//  EventView.swift
//  DayView
//
//  Created by Parker Vines on 11/17/24.
//

import Foundation
import SwiftUI

struct EventRow: View {
    let event: EventModel 
    let personnel: Personnel

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 2)

            HStack {
                // Color strip representing personnel
                Rectangle()
                    .fill(Color(personnel.color))
                    .frame(width: 8)
                    .cornerRadius(4)

                VStack(alignment: .leading, spacing: 4) {
                    Text(personnel.name) // Personnel name
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(event.title) // Event title
                        .font(.headline)
                    Text(event.detail ?? "No Details") // Event description or type
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(event.startTime ?? "N/A") - \(event.endTime ?? "N/A")") // Event time
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 8)
            }
            .padding()
        }
    }
}
