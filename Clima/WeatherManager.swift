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
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=0bfd99e81ca07cb1036972c730278124&units=metric"
    
    func fetchWeather(cityName: String)
    {
        let urlString = "\(weatherURL)&q=\(cityName)"
        //print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String)
    {
        if let url = URL(string: urlString)
        {
            let session  = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?)
    {
        if error != nil{
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
