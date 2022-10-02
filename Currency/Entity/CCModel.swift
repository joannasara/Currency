//
//  CCModel.swift
//  Currency
//
//  Created by Joanna Sara on 2/10/22.
//

import Foundation

class CCModel {
    var addedCurrencies = [String]()
    var conversionRates = [String:Double]()
    var lastUpdateTime = Date(timeIntervalSince1970: 0)
}

