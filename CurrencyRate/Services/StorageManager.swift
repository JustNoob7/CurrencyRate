//
//  StorageManager.swift
//  CurrencyRate
//
//  Created by Ярослав Бойко on 02.02.2022.
//

import UIKit

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "favorites"
    
    private init() {}
    
    func saveCurrency(currency: Valute) {
        var currencies = fetchCurrencies()
        currencies.append(currency)
        guard let data = try? JSONEncoder().encode(currencies) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func fetchCurrencies() -> [Valute] {
        guard let data = userDefaults.data(forKey: key) else { return [] }
        guard let currencies = try? JSONDecoder().decode([Valute].self, from: data) else { return [] }
        return currencies
    }
    
    func deleteCurrency(at index: Int) {
        var currencies = fetchCurrencies()
        currencies.remove(at: index)
        guard let data = try? JSONEncoder().encode(currencies) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func checkAddition(currency: Valute) -> Bool {
        let currencies = fetchCurrencies()
        if currencies.contains(currency) {
            return true
        } else {
            return false
        }
    }
}
