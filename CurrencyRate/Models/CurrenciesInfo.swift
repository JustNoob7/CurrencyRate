//
//  CurrenciesInfo.swift
//  CurrencyRate
//
//  Created by Ярослав Бойко on 25.01.2022.
//

import Foundation

struct CurrenciesInfo: Codable {
    let date: String
    let previousURL: String
    let valute: [String: Valute]
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case previousURL = "PreviousURL"
        case valute = "Valute"
    }
}

struct Valute: Codable {
    let id: String?
    let numCode: String?
    let charCode: String
    let nominal: Int
    let name: String
    let value: Double
    let previous: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case numCode = "NumCode"
        case charCode = "CharCode"
        case nominal = "Nominal"
        case name = "Name"
        case value = "Value"
        case previous = "Previous"
    }
}
