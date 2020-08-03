//
//  WeatherURL.swift
//  Weather
//
//  Created by Thanh Pham on 8/1/20.
//  Copyright © 2020 Thanh Pham. All rights reserved.
//

import UIKit

struct AppData {
    static let appId = "60c6fbeb4b93ac653c492ba806fc346d"
}

struct WeatherURL {
    static let API_FORECAST_DAILY = "/forecast/daily"
    
    enum RequestParam {
        static let appId = "appid"
        static let city = "q"
        static let units = "units"
        static let count = "cnt"
    }
}

extension String {
    var url: String {
        let baseUrl = "https://api.openweathermap.org/data/2.5"
        return baseUrl + self
    }
}
