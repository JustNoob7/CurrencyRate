//
//  CurrencyTableViewCell.swift
//  CurrencyRate
//
//  Created by Ярослав Бойко on 18.02.2022.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var differenceLabel: UILabel!
    
    @IBOutlet weak var changesImageView: UIImageView!
    
    static let identifier = "CurrencyTableViewCell"
    
    func configure(with currency: Valute) {
        nameLabel.text = currency.charCode
        exchangeLabel.text = "\(currency.nominal) \(currency.name)"
        
        let formattedValue = String(format: "%.2f", currency.value)
        valueLabel.text = "\(formattedValue)р."
        
        let difference = currency.value - currency.previous
        differenceLabel.text = String(format: "%.2f", difference)

        if currency.value > currency.previous {
            changesImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
            changesImageView.tintColor = .green
            differenceLabel.textColor = .green
        } else {
            changesImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
            changesImageView.tintColor = .red
            differenceLabel.textColor = .red
        }
    }
    
}
