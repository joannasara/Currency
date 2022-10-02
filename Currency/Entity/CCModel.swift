//
//  CCModel.swift
//  Currency
//
//  Created by Joanna Sara on 2/10/22.
//

import Foundation

class CCModel : Identifiable, Codable {
    var currentBaseCurrency = "SGD"
    var currentBaseCurrencyValue = 1000.0
    
    var addedCurrencies = ["SGD", "USD", "JPY"]
    var conversionRates = [String:Double]()
    var lastUpdateTime = Date(timeIntervalSince1970: 0)
}

