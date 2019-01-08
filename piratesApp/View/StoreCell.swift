//
//  StoreCell.swift
//  piratesApp
//
//  Created by Cody Condon on 2019-01-03.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import UIKit

class StoreCell: UITableViewCell {

    @IBOutlet weak var imageBluePhoto: UIImageView!
    @IBOutlet weak var amountOfLootLbl: UILabel!
    @IBOutlet weak var itemPricePhoto: UIImageView!
    @IBOutlet weak var itemPhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(storeItem: StoreItem) {
        amountOfLootLbl.text = "\(storeItem.amountOfLoot)"
        let amountImage: UIImage = UIImage(named: "\(storeItem.image!)")!
        itemPhoto.image = amountImage
        
        let amountBlueImage: UIImage = UIImage(named: "\(storeItem.imageBlue!)")!
        imageBluePhoto.image = amountBlueImage
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        let result = formatter.string(for: storeItem.amountOfLoot)
        amountOfLootLbl.text = "\(result!)"
        
        switch storeItem.id {
        case 6:
            amountOfLootLbl.text = "3 Prestige"
        case 5:
            amountOfLootLbl.text = "10 Million"
        default:
            print("default")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
