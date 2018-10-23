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
    }
    
    
    func changePirateImageRight(pirate: Pirate) {
        var imgArray = [UIImage]()
        for x in 0...pirate.numberOfImagesRun {
            var img = UIImage(named:"pirate\(pirate.id)run\(x)")
            imgArray.append(img!)
        }
        setPirateImages(imgArray: imgArray)
    }
    
    func changePirateImageLeft(pirate: Pirate) {
        var imgArray = [UIImage]()
        for x in 0...pirate.numberOfImagesRun {
            var img = UIImage(named:"pirate\(pirate.id)runLeft\(x)")
            imgArray.append(img!)
        }
        setPirateImages(imgArray: imgArray)
    }
    
    func animatePirate(pirate: Pirate) {
        if pirate.isAnimating {
            // store the pirates current location when the cell disappears
            // then reset it here to continue finishing off animation

            if pirate.currentTime > 3000 {
                self.pirateImg.transform = CGAffineTransform(translationX: CGFloat(((6000 - pirate.currentTime) / 10)  * 1.4), y: 0)
            } else {
                self.pirateImg.transform = CGAffineTransform(translationX: CGFloat(((( pirate.currentTime - 6000) / 10)  * 1.4)) + 810, y: 0)
            }
            
                
            
            
//            switch pirate.currentTime {
//            case 5000:
//                    self.pirateImg.transform = CGAffineTransform(translationX: 100, y: 0)
//            case 4000:
//                UIView.animate(withDuration: 1) {
//                    self.pirateImg.transform = CGAffineTransform(translationX: 250, y: 0)
//                }
//            case 3000:
//                UIView.animate(withDuration: 1) {
//                    self.pirateImg.transform = CGAffineTransform(translationX: 400, y: 0)
//                }
//            case 2000:
//                UIView.animate(withDuration: 1) {
//                    self.pirateImg.transform = CGAffineTransform(translationX: 250, y: 0)
//                }
//            case 1000:
//                UIView.animate(withDuration: 1) {
//                    self.pirateImg.transform = CGAffineTransform(translationX: 100, y: 0)
//                }
//            default:
//                UIView.animate(withDuration: 1) {
//                    self.pirateImg.transform = CGAffineTransform(translationX: 20, y: 0)
//                }
//            }
            
            
//            func animateLeft() {
//                UIView.animate(withDuration: 3, animations: {
//                    self.pirateImg.layer.transform =
//                    self.changePirateImageRight(pirate:pirate)
//                }, completion: { _ in
//                    animateRight()
//                })
//            }
//            
//            func animateRight() {
//                UIView.animate(withDuration: 3, animations: {
//
//                    self.changePirateImageLeft(pirate:pirate)
//                }, completion: { _ in
//                    animateLeft()
//                })
//            }
//           animateLeft()
            
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
