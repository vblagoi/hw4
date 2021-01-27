//
//  DataStruc.swift
//  Homework4
//
//  Created by Вова Благой on 25.01.2021.
//

import Foundation

struct WeatherData: Codable {
    let id: Int
    let name: String
    let main: Main
}

struct Main: Codable {
    let temp: Double
}

struct CityMain: Codable {
    let city: CityData
    let list: [ForecastModel]
}

struct CityData: Codable {
    let coord: Coordinates
    let name: String
    let country: String
    let population: Int
}

struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}

struct ForecastTemperature: Codable {
    let temp: Double
}

struct ForecastModel: Codable {
    let main: ForecastTemperature
    let dt_txt: String
    
}
