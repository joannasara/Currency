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
    
    private let interactor = CCInteractor()
    private let router = CCRouter()
    
    var navigationController : UINavigationController?
    
    weak var converterVC : CCConverterViewController? {
        didSet {
            interactor.exchangeRates()
        }
    }
    
    weak var currencyPickerPopup : CCCurrencyPickerPopupWindow? {
        didSet {
            currencyPickerPopup?.data = interactor.availableCurrencies()
        }
    }
    
    // MARK: - listen to view controller events
    
    func tableViewCellEdited(labelString: String, textViewValue: Double) {
        interactor.exchangeRates(baseCurrency: labelString, baseCurrencyValue: textViewValue)
    }
    
    func tableViewDidSwipeLeft(index: Int) {
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
    
    // MARK: - listen to interactor events
    
    func exchangeRatesUpdated(data: [[String]], lastUpdateTime:Date, updateSuccessful:Bool) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYYY, hh:mm:ss"
        let dateString = formatter.string(from: lastUpdateTime)
        
        if updateSuccessful {
            self.converterVC?.updateUI(data: data, headingText: "Last Update Time: \(dateString)")
        } else {
            self.converterVC?.updateUI(data: data, headingText: "Update failed!!")
        }
    }
}
