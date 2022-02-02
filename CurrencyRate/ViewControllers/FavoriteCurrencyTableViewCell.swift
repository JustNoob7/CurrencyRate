//
//  FavoriteCurrencyTableViewCell.swift
//  CurrencyRate
//
//  Created by Ярослав Бойко on 02.02.2022.
//

import UIKit

class FavoriteCurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var exchangeLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var changesLabel: UILabel!
    @IBOutlet var changesImageView: UIImageView!
    
    func configure(with currency: Valute) {
        nameLabel.text = currency.charCode
        exchangeLabel.text = "\(currency.nominal) \(currency.name)"
        
        let formattedValue = String(format: "%.2f", currency.value)
        valueLabel.text = "\(formattedValue)р."
        
        let difference = currency.value - currency.previous
        changesLabel.text = String(format: "%.2f", difference)

        if currency.value > currency.previous {
            changesImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
            changesImageView.tintColor = .green
            changesLabel.textColor = .green
        } else {
            changesImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
            changesImageView.tintColor = .red
            changesLabel.textColor = .red
        }
        
    }
}
