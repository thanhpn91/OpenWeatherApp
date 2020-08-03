//
//  MVC_SearchViewController.swift
//  Weather
//
//  Created by Thanh Pham on 8/3/20.
//  Copyright © 2020 Thanh Pham. All rights reserved.
//

import UIKit
import SnapKit

class MVC_SearchViewController: UIViewController {

    var searchBar: UISearchBar!
    var searchController: UISearchController!
    var tableView: UITableView!
    
    fileprivate var debouncer = Debouncer(delay: 0.2)
    fileprivate var displayItems: [SearchDisplayItem] = []
    fileprivate var weatherServices: WeatherServices!
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        
        
        tableView = UITableView()
        tableView.keyboardDismissMode = .onDrag
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        tableView.backgroundColor = UIColor.clear
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func display(_ displayItems: [SearchDisplayItem]) {
        self.displayItems = displayItems
        self.tableView.reloadData()
    }
    
    func display(_ error: String) {
        debugPrint(error)
    }
}

extension MVC_SearchViewController: UISearchResultsUpdating {
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
    
    fileprivate func requestSearchText(_ text: String) {
        weatherServices.getWeatherData(from: text, numberOfDays: 7, unit: .Celsius) { [weak self](weather, error) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if let _ = error {
                    self.display("Error happened")
                } else {
                    var displayItems = [SearchDisplayItem]()
                    if let weather = weather {
                        displayItems = self.parse(weather)
                    }
                    self.display(displayItems)
                }
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        debouncer.callback = { [weak self] in
            guard let self = self else {return}
            self.requestSearchText(text)
        }
        debouncer.call()
    }
}

extension MVC_SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as! SearchResultCell
        
        if indexPath.row < displayItems.count {
            let displayItem = self.displayItems[indexPath.row]
            cell.dateLabel.text = displayItem.date
            cell.tempLabel.text = displayItem.temperature
            cell.pressureLabel.text = displayItem.pressure
            cell.humidityLabel.text = displayItem.humidity
            cell.descriptionLabel.text = displayItem.description
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
