//
//  Networking.swift
//  Homework4
//
//  Created by Вова Благой on 25.01.2021.
//

import Foundation


class CityWeatherParse {
    private let apiKey = "05793cef486fd59ca88afc300d93b597"
    
    func parseCurrentTemperature(city: String, temperatureCompletionHandler: @escaping (Double?, Error?) -> Void) {
        
        let request = cityRecuest(city: city, type: .current)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let dataWeather = try? JSONDecoder().decode(WeatherData.self, from: data!)
            if let temp = dataWeather?.main.temp {
                temperatureCompletionHandler(temp, nil)
            } else {
                temperatureCompletionHandler(nil, error)
            }
        }.resume()
    }
    
    func parseForecastData(city: String, temperatureCompletionHandler: @escaping (CityMain?, Error?) -> Void) {
        
        let request = cityRecuest(city: city, type: .forecast)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let dataWeather = try? JSONDecoder().decode(CityMain.self, from: data!)
            if let data = dataWeather {
                temperatureCompletionHandler(data, nil)
            } else {
                temperatureCompletionHandler(nil, error)
            }
        }.resume()
    }
    
    
    private func cityURL(city: String, type: DataTypeParsing) -> URL {
        switch type {
        case .current:
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
            )!
        case .forecast:
            return URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric")!
        }
        
    }
    
    private func cityRecuest(city: String, type: DataTypeParsing) -> URLRequest {
        return URLRequest(url: cityURL(city: city, type: type))
    }
    
}

enum DataTypeParsing {
    case current
    case forecast
}
