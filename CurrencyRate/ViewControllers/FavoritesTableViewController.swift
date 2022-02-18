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
        tableView.register(UINib(nibName: CurrencyTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        tableView.rowHeight = 80
        getFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
        tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as! CurrencyTableViewCell
        
        let currency = favoriteCurrencies[indexPath.row]
        
        cell.configure(with: currency)
        
        return cell
    }
    
// MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle ==  .delete {
            StorageManager.shared.deleteCurrency(at: indexPath.row)
            favoriteCurrencies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
