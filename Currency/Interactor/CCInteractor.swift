//
//  CCInteractor.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import Foundation

class CCInteractor {
    
    var model = CCModel()
    
    
    weak var presenter : CCPresenter?
    var currentBaseCurrency = "SGD"
    var currentBaseCurrencyValue = 1000.0
    
    init() {
        addCurrency(currency: "SGD")
        addCurrency(currency: "USD")
        addCurrency(currency: "CAD")
    }
    
    func addCurrency(currency: String) {
        if (model.addedCurrencies.isEmpty) {
            currentBaseCurrency = currency
            currentBaseCurrencyValue = 1000
        }
        model.addedCurrencies.append(currency)
        requestExchangeRates()
    }
    
    func removeCurrency(index: Int) {
        model.addedCurrencies.remove(at: index)
        requestExchangeRates()
    }
    
    func availableCurrencies() -> [String] {
        return Array(model.conversionRates.keys)
    }
    
    func requestExchangeRates() {
        requestExchangeRates(baseCurrency: currentBaseCurrency, baseCurrencyValue: currentBaseCurrencyValue)
    }
    
    func requestExchangeRates(baseCurrency: String, baseCurrencyValue: Double) {
        let requestTime = Date()
        
        let url = URL(string: "https://v6.exchangerate-api.com/v6/bd1f6d7d7449a1688a1cec16/latest/" + baseCurrency)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {[weak self] (data, response, error) in
            
            guard let self = self else { return }
            
            if (error != nil) {
                print("Unable to get supported currencies")
                self.presenter?.exchangeRatesUpdated(data:[[String]](), lastUpdateTime:self.model.lastUpdateTime, updateSuccessful:false)
                return
            }
            
            if let data = data {
                do {
                    let dataJson = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary
                    
                    guard let conversionRates = dataJson?["conversion_rates"] as? NSDictionary else {
                        self.presenter?.exchangeRatesUpdated(data: [[String]](), lastUpdateTime: self.model.lastUpdateTime, updateSuccessful: false)
                        return
                    }
                    
                    self.model.conversionRates.removeAll()
                    for (key,value) in conversionRates {
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

                    self.currentBaseCurrency = baseCurrency
                    self.currentBaseCurrencyValue = baseCurrencyValue
                    self.presenter?.exchangeRatesUpdated(data:result, lastUpdateTime:self.model.lastUpdateTime, updateSuccessful:true)
                } catch {
                    print("Failed to parse supported currencies")
                    self.presenter?.exchangeRatesUpdated(data:[[String]](), lastUpdateTime:self.model.lastUpdateTime, updateSuccessful:false)
                }
            }
        })
        
        task.resume()
    }
}