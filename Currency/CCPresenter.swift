//
//  CCPresenter.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import Foundation

class CCPresenter {
    
    weak var interactor : CCInteractor?
    weak var view : CCViewController?
    
    func notifyUpdateButtonClicked(currency: String, value: Double) {
        interactor?.requestExchangeRates(baseCurrency: currency, baseCurrencyValue: value) {[weak self] (response, updateTime, updateSuccessful) in
            self?.view?.updateTable(response: response, updateTime: updateTime, updateSuccessful: updateSuccessful)
        }
    }
}
