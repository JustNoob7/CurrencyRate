//
//  CurrenciesInfo.swift
//  CurrencyRate
//
//  Created by Ярослав Бойко on 25.01.2022.
//

import Foundation

struct CurrenciesInfo {
    let Date: String?
    let PreviousDate: String?
    let PreviousURL: String?
    let Timestamp: String
    let Valute: [String: Valute]
}

struct Valute {
    let ID: String?
    let NumCode: String?
    let CharCode: String?
    let Nominal: Int?
    let Name: String?
    let Value: Double?
    let Previous: Double?
}
