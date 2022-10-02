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
    
    var valueBeforeEdit = ""

    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(currencyLabel)
        
        valueTextView.font = UIFont.systemFont(ofSize: 14)
        valueTextView.layer.borderColor = UIColor.lightGray.cgColor
        valueTextView.layer.borderWidth = 0.5
        valueTextView.keyboardType = UIKeyboardType.decimalPad
        valueTextView.delegate = self
        self.contentView.addSubview(valueTextView)
        
        updateButton.isHidden = true
        updateButton.setImage(UIImage(systemName: "arrow.right"), for: UIControl.State.normal)
        updateButton.addTarget(self, action: #selector(handleButtonClick), for: UIControl.Event.touchUpInside)
        self.contentView.addSubview(updateButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            currencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            currencyLabel.widthAnchor.constraint(equalToConstant: 90),
            currencyLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            updateButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            updateButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            updateButton.widthAnchor.constraint(equalToConstant: 30),
            updateButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        valueTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            valueTextView.leftAnchor.constraint(equalTo: currencyLabel.rightAnchor, constant: 10),
            valueTextView.rightAnchor.constraint(equalTo: updateButton.leftAnchor, constant: -10),
            valueTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            valueTextView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func handleButtonClick() {
        valueTextView.resignFirstResponder()
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        updateButton.isHidden = false
        valueBeforeEdit = textView.text
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updateButton.isHidden = true
        if (textView.text != valueBeforeEdit) {
            CCPresenter.shared.tableViewCellEdited(labelString: currencyLabel.text ?? "", textViewValue: Double(textView.text) ?? 0.0)
        }
        valueBeforeEdit = ""
    }
}
