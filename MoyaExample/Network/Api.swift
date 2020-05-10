//
//  Api.swift
//  MoyaExample
//
//  Created by Kittikawin Sontinarakul on 10/5/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import Foundation
import Moya

enum WeatherService {
    case fecthWeatherCity(name: String)
    case fecthWeatherLocation(lat: Double, long: Double)
}

extension WeatherService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=340a49144aaab9230733ae2d5b114fb4&units=metric")!
    }
    
    var path: String {
        switch self {
        case .fecthWeatherCity(_):
            return ""
        case .fecthWeatherLocation(_,_):
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fecthWeatherCity(_):
            return .get
        case .fecthWeatherLocation(_,_):
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .fecthWeatherCity(let cityName):
            return .requestParameters(parameters: ["q": cityName], encoding:
                URLEncoding.queryString)
        case .fecthWeatherLocation(let lat, let long):
            return .requestParameters(parameters: ["lat": lat, "lon": long], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
