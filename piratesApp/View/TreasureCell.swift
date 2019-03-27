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
    @IBOutlet weak var newTreasureHeight: NSLayoutConstraint!
    
    @IBOutlet weak var newTreasureImage: UIImageView!
    @IBOutlet weak var newTreasureWidth: NSLayoutConstraint!
    @IBOutlet weak var questionMarkImage: UILabel!
    @IBOutlet weak var treasureImage: UIImageView!
    
    @IBOutlet weak var numberOfTreasures: UILabel!
    func configureCell(treasureItem: Treasure) {
       
        
        if treasureItem.isUnlocked {
            questionMarkImage.isHidden = true
            treasureImage.isHidden = false
            categoryImage.isHidden = false
            numberOfTreasures.isHidden = false
            let treasureUIImage = UIImage(named: "treasure0\(treasureItem.id)")!
            treasureImage.image = treasureUIImage
            treasureName.text = "\(treasureItem.name!)"
            let treasureCategoryImage = UIImage(named: "category\(treasureItem.categoryId)")!
            categoryImage.image = treasureCategoryImage
            numberOfTreasures.text = "x\(treasureItem.numberOfTreasures)"
            
        } else {
            questionMarkImage.isHidden = false
            treasureImage.isHidden = true
            categoryImage.isHidden = true
            numberOfTreasures.isHidden = true
            treasureName.text = " "
            numberOfTreasures.text = " "
        }
        let timeInterval = NSDate().timeIntervalSince1970
        
        if Int32(timeInterval - 86400) < treasureItem.timeUnlocked {
            newTreasureImage.isHidden = false
        } else {
            newTreasureImage.isHidden = true
        }
       
        
    }
}
