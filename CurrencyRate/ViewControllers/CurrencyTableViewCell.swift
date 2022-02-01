//
//  CurrencyTableViewCell.swift
//  CurrencyRate
//
//  Created by Ярослав Бойко on 01.02.2022.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var excahngeLabel: UILabel!
    @IBOutlet var changesLabel: UILabel!
        
    func configure(with currency: Valute) {
        nameLabel.text = currency.charCode
        excahngeLabel.text = "\(currency.nominal ?? 0) \(currency.name ?? "")"
        changesLabel.text = "\(String(format: "%.2f", currency.value ?? 0))"
    }
}
