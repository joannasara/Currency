//
//  PopUpWindow.swift
//  Currency
//
//  Created by Joanna Sara on 2/10/22.
//


import Foundation
import UIKit

class CCCurrencyPickerPopupWindow: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    var chosenCurrency = ""
    var data : [String] = [String]() {
        didSet {
            if (!data.isEmpty) {
                chosenCurrency = data[0]
            }
        }
    }
    private let popUpWindowView = CCCurrencyPickerPopupWindowView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
                                
        popUpWindowView.picker.delegate = self
        popUpWindowView.picker.dataSource = self
        popUpWindowView.popupTitle.text = "Pick a Currency"
        popUpWindowView.popupButton.setTitle("OK", for: .normal)
        popUpWindowView.popupButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        view = popUpWindowView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func dismissView(){
        CCPresenter.shared.pickerCurrencyChosen(currency: chosenCurrency)
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenCurrency = data[row]
    }

}

private class CCCurrencyPickerPopupWindowView: UIView {

    let popupView = UIView()
    let popupTitle = UILabel()
    let picker = UIPickerView()
    let popupButton = UIButton()
        
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.2)
        addSubview(popupView)
        
        popupView.layer.masksToBounds = true
        popupView.layer.backgroundColor = UIColor.white.cgColor
        popupView.layer.cornerRadius = 10
        
        popupTitle.layer.masksToBounds = true
        popupTitle.adjustsFontSizeToFitWidth = true
        popupTitle.clipsToBounds = true
        popupTitle.font = UIFont.systemFont(ofSize: 18)
        popupTitle.numberOfLines = 1
        popupTitle.textAlignment = .center
        popupView.addSubview(popupTitle)
        
        popupView.addSubview(picker)
        
        popupButton.setTitleColor(UIColor.black, for: .normal)
        popupButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        popupView.addSubview(popupButton)
    }
    
    override func layoutSubviews() {
        let screenWith = UIScreen.main.bounds.width
        
        popupView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupView.widthAnchor.constraint(equalToConstant: screenWith * 0.75),
            popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        
        popupTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupTitle.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 2),
            popupTitle.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -2),
            popupTitle.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 2),
            popupTitle.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picker.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            picker.topAnchor.constraint(equalTo: popupTitle.bottomAnchor, constant: 8),
            picker.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15),
            picker.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15),
            picker.bottomAnchor.constraint(equalTo: popupButton.topAnchor, constant: -8)
            ])
        
        popupButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupButton.heightAnchor.constraint(equalToConstant: 50),
            popupButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 2),
            popupButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -2),
            popupButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -2)
            ])
    }
}
