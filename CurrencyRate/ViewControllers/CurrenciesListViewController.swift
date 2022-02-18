//
//  CurrenciesListViewController.swift
//  CurrencyRate
//
//  Created by Ярослав Бойко on 25.01.2022.
//

import UIKit

class CurrenciesListViewController: UITableViewController {
    
    private let url = "https://www.cbr-xml-daily.ru/daily_json.js"
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var currencies: [Valute] = []
    private var filteredCurrencies: [Valute] = []
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: CurrencyTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        tableView.rowHeight = 80
        getCurrencies()
        setupSearchController()
    }
    
//MARK: - Private methods
    private func getCurrencies() {
        NetworkManager.shared.fetchCurrencies(from: url) { [unowned self] result in
            switch result {
            case .success(let currenciesInfo):
                navigationController?.navigationBar.topItem?.title = "Курс на \(makeDate(from: currenciesInfo.date))"
                currencies = currenciesInfo.valute.map { $0.value }
                tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func makeDate(from date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = formatter.date(from: date) else { return ""}
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: - Table view data source
extension CurrenciesListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredCurrencies.count : currencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as! CurrencyTableViewCell
        
        let currency = isFiltering ? filteredCurrencies[indexPath.row] : currencies[indexPath.row]
        
        cell.configure(with: currency)
        
        return cell
    }
    
// MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let currency = isFiltering ? filteredCurrencies[indexPath.row] : currencies[indexPath.row]

        let addToFavorites = UIContextualAction(style: .normal, title: "Add to favorites") { _, _, isDone in
            if StorageManager.shared.checkAddition(currency: currency) {
                self.showAlert(title: "Ooops", message: "It is already in favorites")
            } else {
                StorageManager.shared.saveCurrency(currency: currency)
                self.showAlert(title: "Yeeeey", message: "Successfully added")
            }
            isDone(true)
        }

        return UISwipeActionsConfiguration(actions: [addToFavorites])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension CurrenciesListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCurrencies = currencies.filter{ $0.name.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
}
