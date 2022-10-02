//
//  CCRoutes.swift
//  Currency
//
//  Created by Joanna Sara on 2/10/22.
//

import Foundation
import UIKit

class CCRouter {
    
    weak var navigationController : UINavigationController?
    
    func showCurrencyPickerPopupWindow() {
        let popupWindow = CCCurrencyPickerPopupWindow()
        
        CCPresenter.shared.currencyPickerPopup = popupWindow
        CCPresenter.shared.navigationController?.present(popupWindow, animated: true)
    }
}
