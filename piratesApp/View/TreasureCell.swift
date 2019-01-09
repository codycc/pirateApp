//
//  TreasureCell.swift
//  piratesApp
//
//  Created by Cody Condon on 2019-01-09.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import UIKit

class TreasureCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var treasureName: UILabel!
    
    @IBOutlet weak var questionMarkImage: UILabel!
    @IBOutlet weak var treasureImage: UIImageView!
    
    func configureCell(treasureItem: Treasure) {
       
        
        if treasureItem.isUnlocked {
            questionMarkImage.isHidden = true
            let treasureUIImage = UIImage(named: "treasure0\(treasureItem.id)")!
            treasureImage.image = treasureUIImage
            
            treasureName.text = "\(treasureItem.name!)"
            
            let treasureCategoryImage = UIImage(named: "category\(treasureItem.categoryId)")!
            categoryImage.image = treasureCategoryImage
        } else {
            questionMarkImage.isHidden = false
//            treasureName.text = "\(treasureItem.id)/78"
            treasureName.text = ""
        }
       
        
    }
}
