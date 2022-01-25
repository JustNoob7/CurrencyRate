//
//  CurrenciesListViewController.swift
//  CurrencyRate
//
//  Created by Ярослав Бойко on 25.01.2022.
//

import UIKit

class CurrenciesListViewController: UITableViewController {
    
    var currencies: [Valute] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currency", for: indexPath)

        return cell
    }

}
