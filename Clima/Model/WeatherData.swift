//
//  WeatherData.swift
//  Clima
//
//  Created by Aysha Hameed on 12/09/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: MainItem
    let weather: [Weather]
}

struct MainItem: Decodable {
    let temp: Double
    let pressure: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
}
