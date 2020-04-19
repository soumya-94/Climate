//
//  WeatherManager.swift
//  Clima
//
//  Created by Soumya Bhatnagar on 14/04/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager
{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=0bfd99e81ca07cb1036972c730278124&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
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
                    if let weather = self.parseJson(weatherData: safeData)
                    {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data) -> WeatherModel?
    {
        let decoder = JSONDecoder()
        do
        {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        }
        catch
        {
            print(error)
            return nil
        }
    }
    
    
}
