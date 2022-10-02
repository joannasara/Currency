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
                
        plusImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusImage.heightAnchor.constraint(equalToConstant: 20),
            plusImage.widthAnchor.constraint(equalToConstant: 20),
            plusImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            plusImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            CCPresenter.shared.addButtonClicked()
        }
    }
}
