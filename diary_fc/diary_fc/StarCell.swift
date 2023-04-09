//
//  StarCell.swift
//  diary_fc
//
//  Created by 이현호 on 2023/03/20.
//

import UIKit

class StarCell: UICollectionViewCell {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        self.contentView.layer.cornerRadius = 3.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
}
