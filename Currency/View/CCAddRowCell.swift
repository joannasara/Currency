//
//  CCAddRowCell.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import UIKit

class CCAddRowCell: CCBaseCell {
    
    let plusImage = UIImageView()

    override func setupUI() {
        super.setupUI()
                
        plusImage.image = UIImage(systemName: "plus")
        contentView.addSubview(plusImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        plusImage.frame = CGRect(x: (contentView.frame.width-20)/2, y: (contentView.frame.height-20)/2, width: 20, height: 20)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if (selected) {
            CCPresenter.shared.addButtonClicked()
        }
    }
}
