//
//  CurrenciesListViewController.swift
//  CurrencyRate
//
//  Created by Ярослав Бойко on 25.01.2022.
//

import UIKit

class CurrenciesListViewController: UITableViewController {
    
    let url = "https://www.cbr-xml-daily.ru/daily_json.js"
    
    var currencies: [Valute] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 85
        getCurrencies()
    }
    
    private func getCurrencies() {
        NetworkManager.shared.fetchCurrencies(from: url) { result in
            switch result {
            case .success(let currenciesInfo):
                self.currencies = currenciesInfo.valute.map { $0.value }
                self.tableView.reloadData()
                self.title = currenciesInfo.date
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Table view data source
extension CurrenciesListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currency", for: indexPath) as! CurrencyTableViewCell
        let currency = currencies[indexPath.row]
        cell.configure(with: currency)
        return cell
    }
// MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
