//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    // Outlets
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    // Properties
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        searchTextField.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField.endEditing(true)
        return true
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter a city"
            return false
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // Get the weather data for that city.
        if let city = searchTextField.text {
            weatherManager.fetchWeather(city: city)
        }
        
        searchTextField.text = ""
        
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage.init(systemName: weather.conditionName)
            self.cityLabel.text = weather.city
        }
        
    }
    
    func didFailWithError(_ error: Error) {
        
        print(error)
        
    }
    
}
