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
    var onEdit: () -> Void
    var onAdd: () -> Void

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 2)

            HStack {
                Rectangle()
                    .fill(Color(personnel.color))
                    .frame(width: 8)
                    .cornerRadius(4)

                VStack(alignment: .leading, spacing: 4) {
                    Text(personnel.name)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(event.title)
                        .font(.headline)
                    Text(event.detail ?? "No Details") 
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(event.startTime ?? "N/A") - \(event.endTime ?? "N/A")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 8)

                Spacer()

                // Buttons for editing and adding events
                HStack {
                    Button(action: onEdit) {
                        Image(systemName: "pencil")
                            .frame(width: 30, height: 30)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    Button(action: onAdd) {
                        Image(systemName: "plus")
                            .frame(width: 30, height: 30)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                }
                .padding(.trailing, 8)
            }
            .padding()
        }
    }
}
