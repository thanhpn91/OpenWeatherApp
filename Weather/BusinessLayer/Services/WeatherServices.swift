//
//  WeatherServices.swift
//  Weather
//
//  Created by Thanh Pham on 8/1/20.
//  Copyright © 2020 Thanh Pham. All rights reserved.
//

import UIKit

enum Unit: String {
    case Kelvin = "default"
    case Celsius = "metric"
    case Fahrenheit = "imperial"
}

protocol WeatherServicesProtocol {
    func getWeatherData(from city: String, numberOfDays: Int, unit: Unit, completion: ((WeatherForecast?, Error?) -> Void)?)
}

class WeatherServices: WeatherServicesProtocol {
    static let shared = WeatherServices()
    
    private init() {
        networkRequest = HTTPRequest()
    }
    
    private let networkRequest: HTTPRequest!
    
    func getWeatherData(from city: String, numberOfDays: Int, unit: Unit, completion: ((WeatherForecast?, Error?) -> Void)?) {
        var urlComponent = URLComponents(string: WeatherURL.API_FORECAST_DAILY.url)
        urlComponent?.queryItems = [
            URLQueryItem(name: WeatherURL.RequestParam.city, value: city),
            URLQueryItem(name: WeatherURL.RequestParam.appId, value: AppData.appId),
            URLQueryItem(name: WeatherURL.RequestParam.units, value: unit.rawValue),
            URLQueryItem(name: WeatherURL.RequestParam.count, value: "\(numberOfDays)")
        ]
        
        guard let request = HTTPRequest.makeURLRequest(urlComponent: urlComponent) else {return}
        HTTPRequest.GET_request(urlRequest: request) {(result) in
            switch result {
            case .success(let data):
                if let data = data {
                    do {
                        let weathers = try JSONDecoder().decode(WeatherForecast.self, from: data)
                        completion?(weathers, nil)
                    } catch _ {
                        completion?(nil, APIError.responseError("can not parse response"))
                    }
                }
                break
            case .failure(let error):
                completion?(nil, error)
                break
            }
        }
    }
}
