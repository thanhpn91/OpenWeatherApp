//
//  SearchViewControllerTests.swift
//  WeatherTests
//
//  Created by Thanh Pham on 8/1/20.
//  Copyright © 2020 Thanh Pham. All rights reserved.
//

import XCTest

class SearchViewControllerTests: XCTestCase {

    class MockSearchInteractor: MVP_SearchInteractorInterface {
        var view: MVP_SearchViewControllerInterface?
        
        var searchSuccessWithWeather: WeatherForecast?
        var searchErrorWithError: Error?
        
        func onViewReadyToLoad() {
        }
        
        func onViewReceivedSearchText(_ text: String) {
            if let _ = searchSuccessWithWeather {
                view?.display([])
            }
            
            if let _ = searchErrorWithError {
                view?.display("")
            }
        }
    }
    
    class MockSearchViewController: MVP_SearchViewController {
        var loadDisplayItems = false
        var diplayError = false
        
        override func display(_ displayItems: [SearchDisplayItem]) {
            loadDisplayItems = true
        }
        
        override func display(_ error: String) {
            diplayError = true
        }
    }
    
    var viewController = MockSearchViewController()
    var interactor: MockSearchInteractor?
    
    override func setUp() {
        interactor = MockSearchInteractor()
        interactor?.view = viewController
        viewController.interactor = interactor
    }

    override func tearDown() {
        interactor?.searchSuccessWithWeather = nil
        interactor?.searchErrorWithError = nil
    }
    
    func testThatListOfWeatherResultIsDisplay() {
        interactor?.searchSuccessWithWeather = WeatherForecast(cityName: "", list: [])
        interactor?.onViewReceivedSearchText("")
        XCTAssertEqual(viewController.loadDisplayItems, true)
    }
    
    func testThatErrorIsDisplay() {
        interactor?.searchErrorWithError = AppError()
        interactor?.onViewReceivedSearchText("")
        XCTAssertEqual(viewController.diplayError, true)
    }
}
