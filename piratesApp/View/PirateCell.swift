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

    @IBOutlet var plankImg: UIImageView!
    @IBOutlet var groundImg: UIImageView!
    @IBOutlet var backgroundImg: UIImageView!
    @IBOutlet var upgradePlankImg: UIImageView!
    @IBOutlet var upgradePlankLbl: UILabel!
    @IBOutlet var pirateImg: UIImageView!
  
    
    
    func configureCell(pirate: Pirate) {
        self.pirateNameLbl.text =  String(describing: pirate.name!)
        setPlankUnlock(pirate:pirate)
        setUpDynamicPlanks(pirate:pirate)
        setUpDynamicBackgrounds(pirate: pirate)
        addImagesForAnimation(pirate: pirate)
        animatePirate(pirate: pirate)
        checkPiratePosition(pirate:pirate)
    }
    
    func checkPiratePosition(pirate: Pirate) {
//        if pirate.currentTime == 5990.0 {
//            print("ITS 5990")
//            pirateImg.loadGif(name: "pirate1")
//        } else if pirate.currentTime == 0.0 {
//
//        } else {
//
//        }
    }
    
    func changePirateImageRight(pirate: Pirate) {
        var imgArray = [UIImage]()
        for x in 0...pirate.numberOfImagesRun {
            let img = UIImage(named:"pirate\(pirate.id)run\(x)")
            imgArray.append(img!)
        }
        setPirateImages(imgArray: imgArray)
    }
    
    func changePirateImageLeft(pirate: Pirate) {
        var imgArray = [UIImage]()
        for x in 0...pirate.numberOfImagesRun {
            let img = UIImage(named:"pirate\(pirate.id)runLeft\(x)")
            imgArray.append(img!)
        }
        setPirateImages(imgArray: imgArray)
    }
    
    func animatePirate(number: Int32, pirate: Pirate, addOnWord: String) {
        switch number {
        case 0 ... 9, 136 ... 144, 270 ... 279:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(0)")
            pirateImg.image = img
        case 10 ... 18, 145 ... 153, 280 ... 288:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(1)")
            pirateImg.image = img
        case 19 ... 27, 154 ... 162, 289 ... 297:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(2)")
            pirateImg.image = img
        case 28 ... 36, 163 ... 171, 298 ... 306:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(3)")
            pirateImg.image = img
        case 37 ... 45, 172 ... 180, 306 ... 315:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(4)")
            pirateImg.image = img
        case 46 ... 54, 181 ... 189, 316 ... 324:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(5)")
            pirateImg.image = img
        case 55 ... 63, 190 ... 198, 325 ... 333:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(6)")
            pirateImg.image = img
        case 64 ... 72, 199 ... 207, 333 ... 342:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(7)")
            pirateImg.image = img
        case 73 ... 81, 208 ... 216, 343 ... 351:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(8)")
            pirateImg.image = img
        case 82 ... 90, 217 ... 225, 352 ... 360:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(9)")
            pirateImg.image = img
        case 91 ... 99, 226 ... 234, 361 ... 369:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(10)")
            pirateImg.image = img
        case 100 ... 108, 235 ... 243, 370 ... 378:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(11)")
            pirateImg.image = img
        case 109 ... 117, 244 ... 252, 379 ... 387:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(12)")
            pirateImg.image = img
        case 118 ... 126, 253 ... 261, 388 ... 396:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(13)")
            pirateImg.image = img
        case 127 ... 135, 262 ... 270, 396 ... 405:
            let img = UIImage(named:"pirate\(pirate.id)run\(addOnWord)\(14)")
            pirateImg.image = img
        default:
            return
        }
    }
    
    func animatePirate(pirate: Pirate) {
        
        if pirate.isAnimating {
            let numberForward = Int32(floor(((6000 - pirate.currentTime) / 10)  * 1.4))
            let numberBackward = Int32(floor((((pirate.currentTime - 6000) / 10)  * 1.4) + 810))
            if pirate.currentTime > 3000 {

                print("number\(numberForward)")
                self.pirateImg.transform = CGAffineTransform(translationX: CGFloat(numberForward), y: 0)
                animatePirate(number: numberForward, pirate: pirate, addOnWord: "")

            } else {
                self.pirateImg.transform = CGAffineTransform(translationX: CGFloat(numberBackward), y: 0)
                animatePirate(number: numberBackward, pirate: pirate, addOnWord: "Left")
            }
            
        }
    }
    
  
    
    func setPlankUnlock(pirate: Pirate) {
        if pirate.isUnlocked {
            self.plankImg.isHidden = true
            self.pirateNameLbl.isHidden = true
            self.upgradePlankImg.isHidden = false
            self.upgradePlankLbl.isHidden = false
        } else {
            self.plankImg.isHidden = false
            self.pirateNameLbl.isHidden = false
            self.upgradePlankImg.isHidden = true
            self.upgradePlankLbl.isHidden = true
        }
    }
    
    
    func setUpDynamicPlanks(pirate: Pirate) {
        let plankImage: UIImage = UIImage(named: "plank\(pirate.plankNumber)")!
        plankImg.image = plankImage
    }
    
    func setUpDynamicBackgrounds(pirate: Pirate) {
        let groundImage: UIImage = UIImage(named: "ground\(pirate.groundNumber)")!
        groundImg.image = groundImage
       let backgroundImage: UIImage = UIImage(named: "background2")!
        backgroundImg.image = backgroundImage
        
    }
    
    func addImagesForAnimation(pirate: Pirate) {
//        var imgArray = [UIImage]()
//        for x in 0...pirate.numberOfImages {
//            let img = UIImage(named:"pirate\(pirate.id)idle\(x)")
//            imgArray.append(img!)
//        }
//        setPirateImages(imgArray: imgArray)
    }
    
    func setPirateImages(imgArray: Array<UIImage>) {
//        pirateImg.animationImages = imgArray
//        pirateImg.animationDuration = 0.8
//        pirateImg.animationRepeatCount = 0
//        pirateImg.startAnimating()
    }

}
