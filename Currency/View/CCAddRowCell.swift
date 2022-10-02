//
//  CCAddRowCell.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import UIKit

class CCAddRowCell: CCBaseCell {
    
    let addButton = UIButton()

    override func setupUI() {
        super.setupUI()
        
        addButton.setImage(UIImage(systemName: "plus"), for: UIControl.State.normal)
        addButton.addTarget(self, action: #selector(handleButtonClick), for: UIControl.Event.touchUpInside)
        contentView.addSubview(addButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let frameWidth = contentView.frame.width
        addButton.frame = CGRect(x: (frameWidth-50)/2, y: 0, width: 50, height: 50)
    }
    
    @objc func handleButtonClick() {
        presenter?.addButtonClicked()
    }
}
