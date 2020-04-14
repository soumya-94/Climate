//
//  WeatherManager.swift
//  Clima
//
//  Created by Soumya Bhatnagar on 14/04/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager
{
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=0bfd99e81ca07cb1036972c730278124&units=metric"
    
    func fetchWeather(cityName: String)
    {
        let urlString = "\(weatherURL)q=\(cityName)"
    }
}
