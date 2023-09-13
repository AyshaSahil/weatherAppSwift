//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel) {
        print(weather.temperature)
    }
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var manager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        searchTextField.delegate = self
    }

    @IBAction func searchClicked(_ sender: UIButton) {
        searchAction()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchAction()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            manager.fetchWeather(city: city)
        }
        searchTextField.text = ""
    }
    
    func searchAction() {
        searchTextField.endEditing(true)
        print(searchTextField.text ?? "")
    }
    
}

