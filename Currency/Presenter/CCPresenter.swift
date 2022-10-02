//
//  CCPresenter.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import UIKit

class CCPresenter {
    
    static let shared = CCPresenter()
    private init() {}
    
    let interactor = CCInteractor()
    let router = CCRouter()
    var navigationController : UINavigationController?
    
    weak var view : CCViewController? {
        didSet {
            interactor.exchangeRates()
        }
    }
    weak var popupWindow : CCCurrencyPickerPopupWindow? {
        didSet {
            popupWindow?.data = interactor.availableCurrencies()
        }
    }
    
    func tableViewCellEdited(labelString: String, textViewValue: Double) {
        interactor.exchangeRates(baseCurrency: labelString, baseCurrencyValue: textViewValue)
    }
    
    func tableViewDeleteRow(index: Int) {
        interactor.removeCurrency(index: index)
    }
    
    func tableViewDidPullDown() {
        interactor.exchangeRates()
    }
    
    func addButtonClicked() {
        router.showCurrencyPickerPopupWindow()
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
