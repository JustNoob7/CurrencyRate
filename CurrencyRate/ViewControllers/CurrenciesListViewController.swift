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
        NetworkManager.shared.fetchCurrencies(from: url) { result in
            switch result {
            case .success(let currenciesInfo):
                self.currencies = currenciesInfo.Valute.map { $0.value }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currency", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = currencies[indexPath.row].Name
        cell.contentConfiguration = content
        return cell
    }

}
