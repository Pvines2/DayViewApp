//
//  WeatherViewModel.swift
//  DayView
//
//  Created by Parker Vines on 11/30/24.
//


import Foundation

struct WeatherResponse: Codable {
    let current: CurrentWeatherData
}

struct CurrentWeatherData: Codable {
    let temperature: Int
    let weather_descriptions: [String]
    let wind_speed: Int
    let humidity: Int
}

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var temperature: String = "--"
    @Published var description: String = "N/A"
    @Published var windSpeed: String = "--"
    @Published var humidity: String = "--"
    @Published var errorMessage: String?

    func fetchWeather(for city: String) async {
        let apiKey = "5cb220a95859fd40933ffd39b8422f23"
        let query = city.replacingOccurrences(of: " ", with: "%20")  
        let urlString = "https://api.weatherstack.com/current?access_key=\(apiKey)&query=\(query)&units=f"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
            
            self.temperature = "\(weatherResponse.current.temperature)°F"
            self.description = weatherResponse.current.weather_descriptions.first ?? "N/A"
            self.windSpeed = "\(weatherResponse.current.wind_speed) km/h"
            self.humidity = "\(weatherResponse.current.humidity)%"
            self.errorMessage = nil
        } catch {
            errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
            print("Error decoding weather data: \(error)")
        }
    }
}
