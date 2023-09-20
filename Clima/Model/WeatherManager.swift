//
//  WeatherManager.swift
//  Clima
//
//  Created by Aysha Hameed on 12/09/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,weather: WeatherModel)
    func didFailWithError(error: Error)
}

class WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?APPID=b8d5fa6c6e1b4d66c03e30f5bf407578&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(city: String) {
        let urlString = "\(weatherUrl)&q=\(city)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let urlString = "\(weatherUrl)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        
        //Create url
        if let url = URL(string: urlString) {
          
            //Create urlsession
            let session = URLSession(configuration: .default)
        
            //Give task to session
            let task = session.dataTask(with: url){ data, response, error in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        self.delegate?.didUpdateWeather(self ,weather: weather)
                    }
                }
            }
        
            //Start task
            task.resume()
        }
    }
    
    func parseJson(_ weatherData: Data) -> WeatherModel? {
        
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString)
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            print("Temperature: \(decodeData.main.temp)",
                  "\nDescription: \(decodeData.weather[0].description)",
                  "\nId: \(decodeData.weather[0].id)")
            
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather.conditionName)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
