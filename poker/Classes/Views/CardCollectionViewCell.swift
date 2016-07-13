//
//  CardCollectionViewCell.swift
//  poker
//
//  Created by 高橋洸介 on 2016/07/12.
//  Copyright © 2016年 高橋洸介. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImage(card: String) {
        self.cardImage.image = UIImage(named: card)
    }
}
