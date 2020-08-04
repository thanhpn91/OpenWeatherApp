//
//  SearchViewControllerTests.swift
//  WeatherTests
//
//  Created by Thanh Pham on 8/1/20.
//  Copyright © 2020 Thanh Pham. All rights reserved.
//

import XCTest

class MockWeatherServices: WeatherServicesProtocol {
    var weatherForcast: WeatherForecast?
    var error: Error?

    var getWeatherDataGetCalled = false
    var getWeatherDataWithCity = ""
    
    func getWeatherData(from city: String, numberOfDays: Int, unit: Unit, completion: ((WeatherForecast?, Error?) -> Void)?) {
        getWeatherDataGetCalled = true
        getWeatherDataWithCity = city
        completion?(weatherForcast, error)
    }
}

struct AppError: Error {
    
}

class SearchInteractorTests: XCTestCase {
    class MockSearchViewController: MVP_SearchViewControllerInterface {
        var interactor: MVP_SearchInteractorInterface?
        
        var loadDisplayItems: Bool = false
        var diplayError: Bool = false
        
        func display(_ displayItems: [SearchDisplayItem]) {
            loadDisplayItems = true
        }
        
        func display(_ error: String) {
            diplayError = true
        }
    }
    
    var viewController: MockSearchViewController?
    var interactor: MVP_SearchInteractor?
    let mockServices = MockWeatherServices()
    
    override func setUp() {
        viewController = MockSearchViewController()
        interactor = MVP_SearchInteractor(services: mockServices)
        interactor?.view = viewController
        viewController?.interactor = interactor
    }

    override func tearDown() {
        mockServices.weatherForcast = nil
        mockServices.error = nil
    }
    
    func testThatInteractorShouldCallService() {
        interactor?.onViewReceivedSearchText("")
        XCTAssertEqual(mockServices.getWeatherDataGetCalled, true)
    }
    
    func testThatInteractorShouldCallServiceWithCity() {
        interactor?.onViewReceivedSearchText("saigon")
        XCTAssertEqual(mockServices.getWeatherDataWithCity, "saigon")
    }
}
