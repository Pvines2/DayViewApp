//
//  CalendarDayView.swift
//  DayView
//
//  Created by Parker Vines on 11/26/24.
//


import SwiftUI

struct CalendarDayView: View {
    let date: Date
    let events: [EventModel]
    let personnel: [Personnel]
    let predefinedColors: [(name: String, color: Color)]

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(radius: 1)

            VStack(alignment: .leading, spacing: 2) {
                Text("\(Calendar.current.component(.day, from: date))")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding([.top, .leading], 8)

                let todayInt = Calendar.current.component(.year, from: date) * 10000 +
                               Calendar.current.component(.month, from: date) * 100 +
                               Calendar.current.component(.day, from: date)

                ForEach(events.filter { $0.date == todayInt }, id: \.id) { event in
                    if let person = personnel.first(where: { $0.id == event.personnelId }) {
                        let color = predefinedColors.first(where: { $0.name.lowercased() == person.color.lowercased() })?.color ?? Color.gray
                        Rectangle()
                            .fill(color)
                            .frame(height: 4)
                            .cornerRadius(2)
                            .padding(.horizontal, 4)
                    }
                }
            }
        }
        .frame(height: 100)
    }
}

