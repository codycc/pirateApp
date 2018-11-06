//
//  PirateCell.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-10-20.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit
import Spring

class PirateCell: UITableViewCell {

    @IBOutlet weak var pirateNameLbl: UILabel!
    @IBOutlet weak var pirateNameLbl2: UILabel!
    
    @IBOutlet weak var plankImg: UIImageView!
    @IBOutlet weak var groundImg: UIImageView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var upgradePlankImg: UIImageView!

    @IBOutlet weak var buyPlankColorTin: SpringImageView!
    
    @IBOutlet weak var lockImg: SpringImageView!
    
    @IBOutlet weak var plankBtn: UIButton!
    
    @IBOutlet weak var timePlankImg: UIImageView!
    @IBOutlet weak var pirateImgBtn: UIButton!
    @IBOutlet weak var lootLbl: UILabel!
    @IBOutlet weak var pirateImg: UIImageView!
    @IBOutlet weak var lootImg: SpringImageView!
    
    @IBOutlet weak var pirateLootTimeLbl: UILabel!
    @IBOutlet weak var numberOfPiratesLbl: UILabel!
    @IBOutlet weak var buyPlankBtn: UIButton!
    @IBOutlet weak var buyPlankImg: UIImageView!
    @IBOutlet weak var piratePriceLbl: UILabel!
    @IBOutlet weak var piratePriceLblPlank: UILabel!
    
    @IBOutlet weak var maxPiratesReachedView: UIView!
    
    @IBOutlet weak var maxPiratesReachedLbl: UILabel!
    @IBOutlet var pirateImgConstraint: NSLayoutConstraint!
    

    
    
    var imgArray = [UIImage]()
    
    func configureCell(pirate: Pirate, wallet: Wallet) {
        self.pirateNameLbl.text =  String(describing: pirate.name!)
        setPlankUnlock(pirate:pirate)
        setUpDynamicPlanks(pirate:pirate)
        setUpDynamicBackgrounds(pirate: pirate)
        addImagesForAnimation(pirate: pirate)
        setLootLbl(pirate: pirate)
        checkIfPiratesAffordable(pirate: pirate, wallet: wallet)
        setNumberOfPiratesLbl(pirate: pirate)
        updatePiratePrice(pirate: pirate)
        updatePirateLootTime(pirate: pirate)
        setPirateNameLbl(pirate: pirate)
        setPiratePricePlankLbl(pirate: pirate)
        checkIfMaxPiratesReached(pirate: pirate)
        checkHowToChangeConstraint(pirate: pirate)
    }
    
    func setPlankUnlock(pirate: Pirate) {
        if pirate.isUnlocked {
            self.plankImg.isHidden = true
            self.pirateNameLbl.isHidden = true
            self.upgradePlankImg.isHidden = false
            self.lootLbl.isHidden = false
            self.buyPlankImg.isHidden = false
            self.buyPlankBtn.isHidden = false
            self.pirateLootTimeLbl.isHidden = false
            self.buyPlankColorTin.isHidden = false
            self.piratePriceLbl.isHidden = false
            self.pirateNameLbl2.isHidden = false
            self.timePlankImg.isHidden = false
            self.lockImg.isHidden = true
            self.piratePriceLblPlank.isHidden = true
            self.pirateImgBtn.isEnabled = true
            
        } else {
            self.plankImg.isHidden = false
            self.pirateNameLbl.isHidden = false
            self.upgradePlankImg.isHidden = true
            self.lootLbl.isHidden = true
            self.buyPlankImg.isHidden = true
            self.buyPlankBtn.isHidden = true
            self.pirateImgBtn.isEnabled = false
            self.pirateLootTimeLbl.isHidden = true
            self.buyPlankColorTin.isHidden = true
            self.piratePriceLbl.isHidden = true
            self.pirateNameLbl2.isHidden = true
            self.timePlankImg.isHidden = true
            self.lockImg.isHidden = false
            self.piratePriceLblPlank.isHidden = false
         
        }
    }
    
    func checkHowToChangeConstraint(pirate: Pirate) {
        switch pirate.id {
        case 0:
            self.pirateImgConstraint.constant = -20
        case 1:
            self.pirateImgConstraint.constant = -30
        case 2:
            self.pirateImgConstraint.constant = -40
        case 3:
            self.pirateImgConstraint.constant = -35
        case 4:
            self.pirateImgConstraint.constant = -20
        case 5:
            self.pirateImgConstraint.constant = -20
        case 6:
            self.pirateImgConstraint.constant = -20
        case 7:
            self.pirateImgConstraint.constant = -20
        default:
            print("default")
        }
    }
    
    func checkIfMaxPiratesReached(pirate: Pirate) {
        if pirate.numberOfPirates >= 100 {
            self.maxPiratesReachedLbl.isHidden = false
            self.maxPiratesReachedView.isHidden = false
        } else {
            self.maxPiratesReachedLbl.isHidden = true
            self.maxPiratesReachedView.isHidden = true 
        }
    }
    
    func checkIfPiratesAffordable(pirate: Pirate, wallet: Wallet) {
        if pirate.isUnlocked && pirate.piratePrice <= wallet.totalLootAmount {
            self.buyPlankBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            self.buyPlankBtn.alpha = 1
            self.buyPlankBtn.isEnabled = true
            self.plankBtn.isEnabled = false
        } else if !pirate.isUnlocked && pirate.piratePrice <= wallet.totalLootAmount {
            self.pirateNameLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.plankBtn.isEnabled = true
            self.lockImg.alpha = 1
            self.piratePriceLblPlank.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            self.buyPlankBtn.setTitleColor(#colorLiteral(red: 0.3593182173, green: 1, blue: 0.9866703255, alpha: 1), for: .normal)
            self.buyPlankBtn.alpha = 0.7
            self.buyPlankBtn.isEnabled = false
            self.pirateNameLbl.textColor = #colorLiteral(red: 0.667081356, green: 0.4763708115, blue: 0.2563533485, alpha: 1)
            self.piratePriceLblPlank.textColor = #colorLiteral(red: 0.667081356, green: 0.4763708115, blue: 0.2563533485, alpha: 1)
            self.plankBtn.isEnabled = false
            self.lockImg.alpha = 0.7
        }
        
        
    }
    
    func setLootLbl(pirate: Pirate) {
        lootLbl.text = String(format: "$%.2f", pirate.lootAmount)
    }
    
    func setNumberOfPiratesLbl(pirate: Pirate) {
        numberOfPiratesLbl.text = "\(pirate.numberOfPirates)"
    }
    
    func updatePiratePrice(pirate: Pirate) {
        piratePriceLbl.text = String(format: "$%.2f", pirate.piratePrice)
    }
    
    func setPirateNameLbl(pirate: Pirate) {
        self.pirateNameLbl2.text = "\(pirate.name!)"
    }
    
    func setPiratePricePlankLbl(pirate: Pirate) {
        self.piratePriceLblPlank.text = String(format: "$%.2f", pirate.piratePrice)
    }
    
    func updatePirateLootTime(pirate: Pirate) {
        let pirateLootTimeInSeconds = pirate.currentTime
        let hours = Int(pirateLootTimeInSeconds) / 3600
        let minutes = Int(pirateLootTimeInSeconds) / 60 % 60
        let seconds = Int(pirateLootTimeInSeconds) % 60
        
        
        pirateLootTimeLbl.text = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
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
        let img = UIImage(named:"pirate\(pirate.id)idle\(0)")
        pirateImg.image = img
    }
    

    
    func setPirateImages(imgArray: Array<UIImage>) {
//        pirateImg.stopAnimating()
//        pirateImg.animationImages = imgArray
//        pirateImg.animationDuration = 0.8
//        pirateImg.animationRepeatCount = 0
//        pirateImg.startAnimating()
    }

}
