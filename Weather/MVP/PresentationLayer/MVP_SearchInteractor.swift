//
//  SearchInteractor.swift
//  Weather
//
//  Created by Thanh Pham on 8/1/20.
//  Copyright © 2020 Thanh Pham. All rights reserved.
//

import UIKit

class MVP_SearchInteractor: MVP_SearchInteractorInterface {
    weak var view: MVP_SearchViewControllerInterface?
    
    private var weatherServices: WeatherServicesProtocol!
    
    init(services: WeatherServicesProtocol) {
        weatherServices = services
    }
    
    func onViewReadyToLoad() {
        
    }
    
    func onViewReceivedSearchText(_ text: String) {
        weatherServices.getWeatherData(from: text, numberOfDays: 7, unit: .Celsius) { [weak self](weather, error) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if let _ = error {
                    self.view?.display("Error happened")
                } else {
                    var displayItems = [SearchDisplayItem]()
                    if let weather = weather {
                        displayItems = self.parse(weather)
                    }
                    self.view?.display(displayItems)
                }
            }
        }
    }
    
    fileprivate func parse(_ weather: WeatherForecast) -> [SearchDisplayItem] {
        let displayItems = weather.list.compactMap { (weatherInfo) -> SearchDisplayItem in
            let date = "Date:  " + weatherInfo.date.getFormattedDate(format: "E, dd MMM yyyy")
            let temperature = "Average Temperature:  " + "\(Int(weatherInfo.temperature))°C"
            let pressure = "Pressure:  " + "\(Int(weatherInfo.pressure))"
            let humidity = "Humidity: " + "\(weatherInfo.humidity)%"
            let description = "Description:  " + weatherInfo.description
            
            return SearchDisplayItem(date: date,
                                     temperature: temperature,
                                     pressure: pressure,
                                     humidity: humidity,
                                     description: description)
        }
        
         return displayItems
    }
}
