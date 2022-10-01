//
//  CCTableViewCell.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import UIKit

class CCTableViewCell: UITableViewCell {
    
    static let cellHeight = 65.0
        
    let currencyNameLabel = UILabel()
    let valueTextView = UITextView()
    let updateButton = UIButton()
    
    weak var presenter: CCPresenter?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // todojo
//        UIApplication.shared.sendAction(#selector(self.resignFirstResponder), to:nil, from:nil, for:nil)
    }
    
    func setupUI() {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        self.contentView.backgroundColor = UIColor.white
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.2
        self.contentView.layer.shadowOffset = .zero
        self.contentView.layer.shadowRadius = 2
        
        contentView.addSubview(currencyNameLabel)
        
        valueTextView.layer.borderColor = UIColor.lightGray.cgColor
        valueTextView.layer.borderWidth = 0.5
        valueTextView.keyboardType = UIKeyboardType.numberPad
        self.contentView.addSubview(valueTextView)
        
        updateButton.setImage(UIImage(systemName: "arrow.right"), for: UIControl.State.normal)
        updateButton.addTarget(self, action: #selector(handleButtonClick), for: UIControl.Event.touchUpInside)
        self.contentView.addSubview(updateButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = CGRect(x: 10, y: 10, width: contentView.frame.width-20, height: 50)
        contentView.layer.cornerRadius = 10
        
        let frameWidth = contentView.frame.width
        
        currencyNameLabel.frame = CGRect(x: 10, y: 10, width: 100, height: 30)
        valueTextView.frame = CGRect(x: 120, y: 10, width:frameWidth-180, height: 30)
        updateButton.frame = CGRect(x: frameWidth-50, y: 10, width: 30, height: 30)
    }
    
    @objc func handleButtonClick() {
        presenter?.notifyUpdateButtonClicked(currency: currencyNameLabel.text ?? "", value: Double(valueTextView.text) ?? 0.0) // todojo need to disable button when loading
        valueTextView.resignFirstResponder()
    }
}
