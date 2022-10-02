//
//  CCBaseTableViewCell.swift
//  Currency
//
//  Created by Joanna Sara on 2/10/22.
//

import UIKit

class CCBaseCell: UITableViewCell {
    
    static let cellHeight = 65.0
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        self.contentView.backgroundColor = UIColor.white
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.2
        self.contentView.layer.shadowOffset = .zero
        self.contentView.layer.shadowRadius = 2
        self.contentView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        UIApplication.shared.sendAction(#selector(self.resignFirstResponder), to:nil, from:nil, for:nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = CGRect(x: 10, y: 10, width: contentView.frame.width-20, height: 50)
    }
}
