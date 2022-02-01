//
//  CurrencyTableViewCell.swift
//  CurrencyRate
//
//  Created by Ярослав Бойко on 01.02.2022.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var exchangeLabel: UILabel!
    @IBOutlet var changesLabel: UILabel!
    @IBOutlet var changesImageView: UIImageView!
    
    func configure(with currency: Valute) {
        nameLabel.text = currency.charCode
        exchangeLabel.text = "\(currency.nominal) \(currency.name)"
        
        let formattedValue = String(format: "%.2f", currency.value)

        if currency.value > currency.previous {
            changesLabel.text = "\(formattedValue)"
            changesImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
            changesImageView.tintColor = .green
        } else {
            changesLabel.text = "\(formattedValue)"
            changesImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
            changesImageView.tintColor = .red
        }
    }
}
