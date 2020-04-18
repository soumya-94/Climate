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
            //closure used here
            let task = session.dataTask(with: url) { (data, response, error) in
                 if error != nil
                 {
                    print(error!)
                    return
                }
                       
                if let safeData = data
                {
                    self.parseJson(weatherData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data)
    {
        let decoder = JSONDecoder()
        do
        {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        }
        catch{
            print(error)
        }
    }

}
