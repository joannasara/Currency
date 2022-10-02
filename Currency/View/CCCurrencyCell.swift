//
//  CCTableViewCell.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import UIKit

class CCCurrencyCell: CCBaseCell, UITextViewDelegate {
   
    let currencyLabel = UILabel()
    let valueTextView = UITextView()
    let updateButton = UIButton()

    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(currencyLabel)
        
        valueTextView.layer.borderColor = UIColor.lightGray.cgColor
        valueTextView.layer.borderWidth = 0.5
        valueTextView.keyboardType = UIKeyboardType.numberPad
        valueTextView.delegate = self
        self.contentView.addSubview(valueTextView)
        
        // todojo need to disable button when loading
        updateButton.isHidden = true
        updateButton.setImage(UIImage(systemName: "arrow.right"), for: UIControl.State.normal)
        updateButton.addTarget(self, action: #selector(handleButtonClick), for: UIControl.Event.touchUpInside)
        self.contentView.addSubview(updateButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let frameWidth = contentView.frame.width
        currencyLabel.frame = CGRect(x: 20, y: 10, width: 90, height: 30)
        valueTextView.frame = CGRect(x: 120, y: 10, width:frameWidth-180, height: 30)
        updateButton.frame = CGRect(x: frameWidth-50, y: 10, width: 30, height: 30)
    }
    
    @objc func handleButtonClick() {
        valueTextView.resignFirstResponder()
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        updateButton.isHidden = false
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updateButton.isHidden = true
        presenter?.tableViewCellEdited(labelString: currencyLabel.text ?? "", textViewValue: Double(textView.text) ?? 0.0)
    }
}