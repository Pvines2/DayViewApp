//
//  WeatherView.swift
//  DayView
//
//  Created by Parker Vines on 11/30/24.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    @State private var city: String = "Auburn, United States"  // Default city

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("Enter city name", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    Task {
                        await weatherViewModel.fetchWeather(for: city)
                    }
                }) {
                    Text("Get Weather")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                if let errorMessage = weatherViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding()
                } else {
                    VStack(spacing: 8) {
                        Text("Temperature: \(weatherViewModel.temperature)")
                        Text("Description: \(weatherViewModel.description)")
                        Text("Wind Speed: \(weatherViewModel.windSpeed)")
                        Text("Humidity: \(weatherViewModel.humidity)")
                    }
                    .font(.headline)
                    .padding()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Weather Info")
        }
    }
}
