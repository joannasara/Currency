//
//  CCInteractor.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import Foundation

class CCInteractor {
    
    var model = CCStorage.getModel()
        
    func addCurrency(currency: String) {
        if (model.addedCurrencies.isEmpty) {
            model.currentBaseCurrency = currency
            model.currentBaseCurrencyValue = 1000
        }
        model.addedCurrencies.append(currency)
        exchangeRates()
    }
    
    func removeCurrency(index: Int) {
        model.addedCurrencies.remove(at: index)
        exchangeRates()
    }
    
    func availableCurrencies() -> [String] {
        return Array(model.conversionRates.keys)
    }
    
    func exchangeRates() {
        exchangeRates(baseCurrency: model.currentBaseCurrency, baseCurrencyValue: model.currentBaseCurrencyValue)
    }
    
    func exchangeRates(baseCurrency: String, baseCurrencyValue: Double) {
        CCRequester.requestExchangeRates(baseCurrency: baseCurrency, baseCurrencyValue: baseCurrencyValue) { data, requestTime, requestSuccessful in
            
            if (!requestSuccessful) {
                CCPresenter.shared.exchangeRatesUpdated(data:[[String]](), lastUpdateTime:self.model.lastUpdateTime, updateSuccessful:false)
                return
            }
            
            self.model.conversionRates.removeAll()
            for (key,value) in data {
                self.model.conversionRates[key as! String] = (value as! Double)
            }
            
            self.model.lastUpdateTime = requestTime
            
            var result = [[String]]()
            for currency in self.model.addedCurrencies {
                if let value = self.model.conversionRates[currency] {
                    result.append([currency, String(Int(value * baseCurrencyValue))])
                } else {
                    result.append([currency, ""])
                }
            }
            
            self.model.currentBaseCurrency = baseCurrency
            self.model.currentBaseCurrencyValue = baseCurrencyValue
            
            CCStorage.saveModel(self.model)
            
            CCPresenter.shared.exchangeRatesUpdated(data:result, lastUpdateTime:self.model.lastUpdateTime, updateSuccessful:true)
            
        }
    }
}
