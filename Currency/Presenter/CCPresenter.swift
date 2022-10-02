//
//  CCPresenter.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import Foundation

class CCPresenter {
    
    let interactor = CCInteractor()
    weak var view : CCViewController?
    weak var popupWindow : CCCurrencyPickerPopupWindow? {
        didSet {
            popupWindow?.data = interactor.availableCurrencies()
        }
    }
    
    init() {
        interactor.presenter = self
        interactor.requestExchangeRates(baseCurrency: "SGD", baseCurrencyValue: 1000.0)
    }
    
    func tableViewCellEdited(labelString: String, textViewValue: Double) {
        interactor.requestExchangeRates(baseCurrency: labelString, baseCurrencyValue: textViewValue)
    }
    
    func tableViewDeleteRow(index: Int) {
        interactor.removeCurrency(index: index)
    }
    
    func addButtonClicked() {
        view?.showPopup()
    }
    
    func pickerCurrencyChosen(currency: String) {
        interactor.addCurrency(currency: currency)
    }
    
    func exchangeRatesUpdated(data: [[String]], lastUpdateTime:Date, updateSuccessful:Bool) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM YYYY, hh:mm:ss"
        let dateString = formatter.string(from: lastUpdateTime)
        
        if (updateSuccessful) {
            self.view?.updateUI(data: data, headingText: "Last Update: \(dateString)")
        } else {
            self.view?.updateUI(data: data, headingText: "Update failed!! Last Update: \(dateString)")
        }
    }
}
