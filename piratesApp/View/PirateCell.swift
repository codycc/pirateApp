//
//  PirateCell.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-10-20.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit

class PirateCell: UITableViewCell {

    @IBOutlet weak var pirateNameLbl: UILabel!
    @IBOutlet weak var pirateImg: UIImageView!
    @IBOutlet var plankImg: UIImageView!
    @IBOutlet var groundImg: UIImageView!
    @IBOutlet var backgroundImg: UIImageView!
    

    func configureCell(pirate: Pirate) {
        self.pirateNameLbl.text =  String(describing: pirate.name!)
        setPlank(pirate:pirate)
        setUpDynamicBackgrounds(pirate: pirate)
        addImagesForAnimation(pirate: pirate)
    }
    
    func setPlank(pirate: Pirate) {
        if pirate.isUnlocked {
            self.plankImg.isHidden = true
            self.pirateNameLbl.isHidden = true
        } else {
            self.plankImg.isHidden = false
            self.pirateNameLbl.isHidden = false
        }
    }
    
    func setUpDynamicBackgrounds(pirate: Pirate) {
        let groundImage: UIImage = UIImage(named: "ground\(pirate.groundNumber)")!
        groundImg.image = groundImage
       let backgroundImage: UIImage = UIImage(named: "background2")!
        backgroundImg.image = backgroundImage
        
    }
    
    func addImagesForAnimation(pirate: Pirate) {
        var imgArray = [UIImage]()
        for x in 0...pirate.numberOfImages {
            let img = UIImage(named:"pirate\(pirate.id)idle\(x)")
            imgArray.append(img!)
        }
        setPirateImages(imgArray: imgArray)
    }
    
    func setPirateImages(imgArray: Array<UIImage>) {
        pirateImg.animationImages = imgArray
        pirateImg.animationDuration = 0.8
        pirateImg.animationRepeatCount = 0
        pirateImg.startAnimating()
    }
}
