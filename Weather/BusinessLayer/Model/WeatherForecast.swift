//
//  WeatherForecast.swift
//  Weather
//
//  Created by Thanh Pham on 8/1/20.
//  Copyright © 2020 Thanh Pham. All rights reserved.
//

import UIKit

struct WeatherForecast: Decodable {
    var cityName: String
    var list: [WeatherInfo]
    
    enum CodingKeys: String, CodingKey {
        case city
        case list
    }
    
    enum CityKeys: String, CodingKey {
        case name = "name"
    }
    
    init(cityName: String, list: [WeatherInfo]) {
        self.cityName = cityName
        self.list = list
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let cityContainer = try values.nestedContainer(keyedBy: CityKeys.self, forKey: .city)
        cityName = try cityContainer.decode(String.self, forKey: .name)
        list = try values.decode([WeatherInfo].self, forKey: .list)
    }
}
struct Weather: Decodable {
    let id: Int
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
    }
}

struct WeatherInfo: Decodable {
    let date: Date
    let temperature: Float
    let pressure: Int
    let humidity: Float
    let description: String

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temp
        case weather
        case main
        case humidity
        case pressure
    }
    
    enum TempKeys: String, CodingKey {
        case day
        case night
    }
    
    enum WeatherCodingKeys: String, CodingKey {
        case description
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let timeInterval = try values.decode(Double.self, forKey: .date)
        date = Date(timeIntervalSince1970: timeInterval)
        pressure = try values.decode(Int.self, forKey: .pressure)
        humidity = try values.decode(Float.self, forKey: .humidity)
        
        let tempValues = try values.nestedContainer(keyedBy: TempKeys.self, forKey: .temp)
        let dayTemp = try tempValues.decode(Float.self, forKey: .day)
        let nightTemp = try tempValues.decode(Float.self, forKey: .night)
        temperature = (dayTemp + nightTemp) * 0.5
        
        let weathers = try values.decode([Weather].self, forKey: .weather)
        description = weathers.first?.description ?? ""
    }
}
