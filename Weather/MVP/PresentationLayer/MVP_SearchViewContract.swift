//
//  SearchViewContract.swift
//  Weather
//
//  Created by Thanh Pham on 8/1/20.
//  Copyright © 2020 Thanh Pham. All rights reserved.
//

import UIKit

struct SearchDisplayItem {
    var date: String
    var temperature: String
    var pressure: String
    var humidity: String
    var description: String
}

protocol MVP_SearchViewControllerInterface: class {
    var interactor: MVP_SearchInteractorInterface? {get set}
    
    func display(_ displayItems: [SearchDisplayItem])
    func display(_ error: String)
}

protocol MVP_SearchInteractorInterface {
    var view: MVP_SearchViewControllerInterface? {get set}
    
    func onViewReadyToLoad()
    func onViewReceivedSearchText(_ text: String)
}
