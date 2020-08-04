//
//  SearchViewController.swift
//  Weather
//
//  Created by Thanh Pham on 8/1/20.
//  Copyright © 2020 Thanh Pham. All rights reserved.
//

import UIKit
import SnapKit

class MVP_SearchViewController: UIViewController, MVP_SearchViewControllerInterface {
    var interactor: MVP_SearchInteractorInterface? = MVP_SearchInteractor(services: WeatherServices.shared)
    
    var searchBar: UISearchBar!
    var searchController: UISearchController!
    var tableView: UITableView!
    
    fileprivate var debouncer = Debouncer(delay: 0.2)
    fileprivate var displayItems: [SearchDisplayItem] = []
    
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
        interactor?.view = self
        interactor?.onViewReadyToLoad()
    }
    
    func display(_ displayItems: [SearchDisplayItem]) {
        self.displayItems = displayItems
        self.tableView.reloadData()
    }
    
    func display(_ error: String) {
        debugPrint(error)
    }
}

extension MVP_SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        debouncer.run { [weak self] in
            guard let self = self else {return}
            self.interactor?.onViewReceivedSearchText(text)
        }
    }
}

extension MVP_SearchViewController: UITableViewDataSource, UITableViewDelegate {
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

class SearchResultCell: UITableViewCell {
    var dateLabel: UILabel!
    var tempLabel: UILabel!
    var pressureLabel: UILabel!
    var humidityLabel: UILabel!
    var descriptionLabel: UILabel!
    
    fileprivate let paddingBetweenItem = 12
    fileprivate let horizontalPadding = 16
    fileprivate let fontSize: CGFloat = 22
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func commonInit() {
        backgroundColor = UIColor.clear
        dateLabel = UILabel()
        dateLabel.numberOfLines = 0
        dateLabel.font = UIFont.systemFont(ofSize: fontSize)
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(paddingBetweenItem)
            make.left.right.equalToSuperview().inset(horizontalPadding)
        }
        
        tempLabel = UILabel()
        tempLabel.numberOfLines = 0
        tempLabel.font = UIFont.systemFont(ofSize: fontSize)
        addSubview(tempLabel)
        tempLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(paddingBetweenItem)
            make.left.right.equalToSuperview().inset(horizontalPadding)
            
        }
        
        pressureLabel = UILabel()
        pressureLabel.numberOfLines = 0
        pressureLabel.font = UIFont.systemFont(ofSize: fontSize)
        addSubview(pressureLabel)
        pressureLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tempLabel.snp.bottom).offset(paddingBetweenItem)
            make.left.right.equalToSuperview().inset(horizontalPadding)
            
        }
        
        humidityLabel = UILabel()
        humidityLabel.numberOfLines = 0
        humidityLabel.font = UIFont.systemFont(ofSize: fontSize)
        addSubview(humidityLabel)
        humidityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pressureLabel.snp.bottom).offset(paddingBetweenItem)
            make.left.right.equalToSuperview().inset(horizontalPadding)
            
        }
        descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: fontSize)
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(humidityLabel.snp.bottom).offset(paddingBetweenItem)
            make.left.right.equalToSuperview().inset(horizontalPadding)
            make.bottom.equalToSuperview().offset(-paddingBetweenItem)
        }
    }
}
