//
//  CurrenciesInfo.swift
//  CurrencyRate
//
//  Created by Ярослав Бойко on 25.01.2022.
//

import Foundation

struct CurrenciesInfo: Codable, Equatable {
    let date: String
    let previousURL: String
    let valute: [String: Valute]
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case previousURL = "PreviousURL"
        case valute = "Valute"
    }
}

struct Valute: Codable, Equatable {
    let charCode: String
    let nominal: Int
    let name: String
    let value: Double
    let previous: Double
    
    enum CodingKeys: String, CodingKey {
        case charCode = "CharCode"
        case nominal = "Nominal"
        case name = "Name"
        case value = "Value"
        case previous = "Previous"
    }
}
