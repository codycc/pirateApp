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
    @IBOutlet var pirateNameLbl2: UILabel!
    
    @IBOutlet var plankImg: UIImageView!
    @IBOutlet var groundImg: UIImageView!
    @IBOutlet var backgroundImg: UIImageView!
    @IBOutlet var upgradePlankImg: UIImageView!
    
    @IBOutlet var buyPlankColorTin: SpringImageView!
    
    @IBOutlet var lockImg: SpringImageView!
    
    @IBOutlet var plankBtn: UIButton!
    
    @IBOutlet var timePlankImg: UIImageView!
    @IBOutlet var pirateImgBtn: UIButton!
    @IBOutlet var lootLbl: UILabel!
    @IBOutlet var pirateImg: UIImageView!
    @IBOutlet var lootImg: SpringImageView!
    
    @IBOutlet var pirateLootTimeLbl: UILabel!
    @IBOutlet var numberOfPiratesLbl: UILabel!
    @IBOutlet var buyPlankBtn: UIButton!
    @IBOutlet var buyPlankImg: UIImageView!
    @IBOutlet var piratePriceLbl: UILabel!
    
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
    }
    
    func setPlankUnlock(pirate: Pirate) {
        if pirate.isUnlocked {
            self.plankImg.isHidden = true
            self.pirateNameLbl.isHidden = true
            self.upgradePlankImg.isHidden = false
            self.lootLbl.isHidden = false
            self.buyPlankImg.isHidden = false
            self.buyPlankBtn.isHidden = false
            self.lootImg.isHidden = false
            self.pirateLootTimeLbl.isHidden = false
            self.buyPlankColorTin.isHidden = false
            self.piratePriceLbl.isHidden = false
            self.pirateNameLbl2.isHidden = false
            self.timePlankImg.isHidden = false
            self.lockImg.isHidden = true
        } else {
            self.plankImg.isHidden = false
            self.pirateNameLbl.isHidden = false
            self.upgradePlankImg.isHidden = true
            self.lootLbl.isHidden = true
            self.buyPlankImg.isHidden = true
            self.buyPlankBtn.isHidden = true
            self.lootImg.isHidden = true
            self.pirateLootTimeLbl.isHidden = true
            self.buyPlankColorTin.isHidden = true
            self.piratePriceLbl.isHidden = true
            self.pirateNameLbl2.isHidden = true
            self.timePlankImg.isHidden = true
            self.lockImg.isHidden = false
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
        } else {
            self.buyPlankBtn.setTitleColor(#colorLiteral(red: 0.3593182173, green: 1, blue: 0.9866703255, alpha: 1), for: .normal)
            self.buyPlankBtn.alpha = 0.7
            self.buyPlankBtn.isEnabled = false
            self.pirateNameLbl.textColor = #colorLiteral(red: 0.667081356, green: 0.4763708115, blue: 0.2563533485, alpha: 1)
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
    
    
    func updatePirateLootTime(pirate: Pirate) {
        let pirateLootTimeInSeconds = pirate.currentTime
        var extraVariable = ""
        if pirateLootTimeInSeconds == 1 {
            extraVariable = " second"
        }
        else if pirateLootTimeInSeconds < 60 {
            extraVariable = " seconds"
        }
        
        if pirateLootTimeInSeconds > 60000 {
         (pirateLootTimeInSeconds / 3600, (pirateLootTimeInSeconds % 3600) / 60, (pirateLootTimeInSeconds % 3600) % 60)
        }
        
        pirateLootTimeLbl.text = "\(pirateLootTimeInSeconds)\(extraVariable)"
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
        pirateImg.stopAnimating()
        pirateImg.animationImages = imgArray
        pirateImg.animationDuration = 0.8
        pirateImg.animationRepeatCount = 0
        pirateImg.startAnimating()
    }

}
