//
//  LocationCell.swift
//  piratesAppRemake
//
//  Created by Cody Condon on 2019-03-07.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import UIKit
import Spring

class LocationCell: UITableViewCell {
    
    @IBOutlet weak var locationLbl: UILabel!

    @IBOutlet weak var locationPricesLbl: SpringLabel!
    @IBOutlet weak var locationTreasureLbl: UILabel!

    @IBOutlet weak var treasureImg: UIImageView!
    
    @IBOutlet weak var locationsImg: UIImageView!
    
    @IBOutlet weak var pirateUnlocksLbl: UILabel!
    
    @IBOutlet weak var imageTop: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        locationsImg.clipsToBounds = true
        
    }

    func configureCell(location: Location, currentHighestLocation: Int32) {
        locationLbl.text = location.name
        
        
        switch location.treasureLevel {
        case 0:
            locationTreasureLbl.text = "Common Treasures"
            let treasureImageName = UIImage(named: "category1")!
            treasureImg.image = treasureImageName
        case 1:
            locationTreasureLbl.text = "Rare Treasures"
            let treasureImageName = UIImage(named: "category2")!
            treasureImg.image = treasureImageName
        case 2:
            locationTreasureLbl.text = "Epic Treasures"
            let treasureImageName = UIImage(named: "category3")!
            treasureImg.image = treasureImageName
        default:
            print("default")
        }
        
        
        let locationImageName = UIImage(named: "\(location.image!)")!
        locationsImg.image = locationImageName
        
        switch location.id {
        case 0:
            pirateUnlocksLbl.text = "Pirates: Scolly & Plunder Pete"
        case 1:
            pirateUnlocksLbl.text = "Pirates: Cutler & Bandit"
        case 2:
            pirateUnlocksLbl.text = "Pirates: Landlubber & Roger"
        case 3:
            pirateUnlocksLbl.text = "Pirates: Crook & Buccaneer"
        case 4:
            pirateUnlocksLbl.text = "Pirates: Thief & Gunna"
        case 5:
            pirateUnlocksLbl.text = "Pirates: Bayou Benny, Privateer, & Redbeard"
        case 6:
            pirateUnlocksLbl.text = "Pirates: Bluebeard & Blackbeard"
        default:
            print("hello")
        }
        
        
       
        var string = ""
        let locationAmount = location.amountToUnlock
       
      
        
        
        if locationAmount >= 1000000000000 {
            let str = "\(locationAmount)"
            let digits = str.compactMap{Int(String($0))}
            string = "\(digits[0]).\(digits[1])) Trillion"
            
        } else if locationAmount >= 100000000000 {
            let str = "\(locationAmount)"
            let digits = str.compactMap{Int(String($0))}
            string = "\(digits[0])\(digits[1])\(digits[2]) Billion"
            
            
        } else if locationAmount >= 10000000000 {
            let str = "\(locationAmount)"
            let digits = str.compactMap{Int(String($0))}
            string = "\(digits[0])\(digits[1])) Billion"
            
            
        } else if locationAmount >= 1000000000 {
            let str = "\(locationAmount)"
            let digits = str.compactMap{Int(String($0))}
            string = "\(digits[0]).\(digits[1]) Billion"
            
        } else if locationAmount >= 100000000 {
            let str = "\(locationAmount)"
            let digits = str.compactMap{Int(String($0))}
            string = "\(digits[0])\(digits[1])\(digits[2]) Million"
            
        } else if locationAmount >= 10000000 {
            let str = "\(locationAmount)"
            let digits = str.compactMap{Int(String($0))}
            string = "\(digits[0])\(digits[1]) Million"
            
        } else if locationAmount >= 1000000 {
            let str = "\(locationAmount)"
            let digits = str.compactMap{Int(String($0))}
            string = "\(digits[0]).\(digits[1]) Million"
            
        } else {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = ""
            string = formatter.string(for: locationAmount)!
           
        }
        

        if location.isCurrent {
            locationPricesLbl.text = "Current"
        } else if location.isUnlocked {
            locationPricesLbl.text = "Unlocked"
        } else if location.id  > currentHighestLocation + 1 {
                locationLbl.text = "Locked"
                locationPricesLbl.text = "Not Available"
        } else {
             locationPricesLbl.text = string
        }
        
        

    }
    

    
   

}
