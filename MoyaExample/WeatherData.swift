//
//  WeatherData.swift
//  Clima
//
//  Created by Kittikawin Sontinarakul on 16/2/2563 BE.
//  Copyright © 2563 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable{
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
