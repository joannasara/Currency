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
        popUpWindowView.okButton.setTitle("OK", for: .normal)
        popUpWindowView.okButton.addTarget(self, action: #selector(handleOKButtonClicked), for: .touchUpInside)
        popUpWindowView.cancelButton.setTitle("Cancel", for: .normal)
        popUpWindowView.cancelButton.addTarget(self, action: #selector(handleCancelButtonClicked), for: .touchUpInside)
        
        view = popUpWindowView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleOKButtonClicked() {
        CCPresenter.shared.pickerCurrencyChosen(currency: chosenCurrency)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCancelButtonClicked() {
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
    let okButton = UIButton()
    let cancelButton = UIButton()
        
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.25)
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
        
        okButton.setTitleColor(UIColor.black, for: .normal)
        okButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        popupView.addSubview(okButton)
        
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        popupView.addSubview(cancelButton)
    }
    
    override func layoutSubviews() {
        let popupWidth = UIScreen.main.bounds.width * 0.75
        
        popupView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupView.widthAnchor.constraint(equalToConstant:popupWidth),
            popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        
        popupTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupTitle.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
            popupTitle.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
            popupTitle.topAnchor.constraint(equalTo: popupView.topAnchor),
            popupTitle.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picker.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            picker.topAnchor.constraint(equalTo: popupTitle.bottomAnchor),
            picker.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: okButton.topAnchor)
            ])
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: popupWidth/2),
            cancelButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor)
            ])
        
        okButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            okButton.heightAnchor.constraint(equalToConstant: 50),
            okButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor),
            okButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
            okButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor)
            ])
        
        
    }
}
