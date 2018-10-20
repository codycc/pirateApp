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
   
    @IBOutlet var groundImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(pirate: Pirate) {
       
        self.pirateNameLbl.text =  String(describing: pirate.name!)
        let image: UIImage = UIImage(named: "ground\(pirate.groundNumber)")!
        groundImg.image = image
        
        addImagesForAnimation(pirate: pirate)
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
