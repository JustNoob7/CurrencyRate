//
//  FavoritesTableViewController.swift
//  CurrencyRate
//
//  Created by Ярослав Бойко on 02.02.2022.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    private var favoriteCurrencies: [Valute] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        self.navigationController?.navigationBar.topItem?.title = "Избранное"
        getFavorites()
    }

    private func getFavorites() {
        favoriteCurrencies = StorageManager.shared.fetchCurrencies()
    }
   
}
// MARK: - Table view data source
extension FavoritesTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteCurrencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCurrency", for: indexPath) as! FavoriteCurrencyTableViewCell
        let currency = favoriteCurrencies[indexPath.row]
        cell.configure(with: currency)
        return cell
    }
}
