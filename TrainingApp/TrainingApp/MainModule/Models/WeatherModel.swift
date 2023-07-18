//
//  WeatherModel.swift
//  TrainingApp
//
//  Created by Grigore on 17.07.2023.
//

import Foundation
import UIKit

struct WeatherModel: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
    
    var temperatureCelsius: Int {
        Int(temp - 273.15)
    }
}

struct Weather: Decodable {
    let weatherDescription: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription  = "description"
        case icon
    }    
}

