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
    
    @IBOutlet weak var backImgTwo: UIImageView!
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
    
    @IBOutlet weak var goldPlateImage: UIImageView!
    @IBOutlet weak var maxPiratesReachedView: UIView!
    
    @IBOutlet weak var resetPirateBtn: UIButton!
    
    @IBOutlet weak var subTitleLbl: UILabel!
    
    @IBOutlet weak var secondSubTitleLbl: UILabel!
    @IBOutlet weak var maxPiratesReachedLbl: UILabel!
    @IBOutlet var pirateImgConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pirateHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundHeight: NSLayoutConstraint!
    @IBOutlet weak var backgroundTop: NSLayoutConstraint!
    
    @IBOutlet weak var labelLeadingConstraint: NSLayoutConstraint!
    
    var imgArray = [UIImage]()
    var pirateImgArray = [UIImage]()
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backImgTwo.clipsToBounds = true 
    }
    
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
            self.goldPlateImage.isHidden = true
            
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
            self.goldPlateImage.isHidden = false
        }
    }
    //change
    func checkHowToChangeConstraint(pirate: Pirate) {
        switch pirate.id {
        case 0:
            self.pirateImgConstraint.constant = -22
            self.pirateHeightConstraint.constant = 180
        case 1:
            self.pirateImgConstraint.constant = -30
            self.pirateHeightConstraint.constant = 180
        case 2:
            self.pirateImgConstraint.constant = -35
            self.pirateHeightConstraint.constant = 170
        case 3:
            self.pirateImgConstraint.constant = -23
            self.pirateHeightConstraint.constant = 180
        case 4:
            self.pirateImgConstraint.constant = -27
            self.pirateHeightConstraint.constant = 180
        case 5:
            self.pirateImgConstraint.constant = -27
            self.pirateHeightConstraint.constant = 180
        case 6:
            self.pirateImgConstraint.constant = -26
            self.pirateHeightConstraint.constant = 160
        case 7:
            self.pirateImgConstraint.constant = -43
            self.pirateHeightConstraint.constant = 160
        case 8:
            self.pirateImgConstraint.constant = -36
            self.pirateHeightConstraint.constant = 180
        case 9:
            self.pirateImgConstraint.constant = -30
            self.pirateHeightConstraint.constant = 190
        case 10:
            self.pirateImgConstraint.constant = -16
            self.pirateHeightConstraint.constant = 190
        case 11:
            self.pirateImgConstraint.constant = -20
            self.pirateHeightConstraint.constant = 190
        case 12:
            self.pirateImgConstraint.constant = -22
            self.pirateHeightConstraint.constant = 190
        case 13:
            self.pirateImgConstraint.constant = -22
            self.pirateHeightConstraint.constant = 190
        case 14:
            self.pirateImgConstraint.constant = -22
            self.pirateHeightConstraint.constant = 190
        default:
            print("default")
        }
    }
    
    func checkIfMaxPiratesReached(pirate: Pirate) {
        if pirate.numberOfPirates >= 100 {
            self.maxPiratesReachedLbl.isHidden = false
            self.maxPiratesReachedView.isHidden = false
            self.resetPirateBtn.isHidden = false
            self.subTitleLbl.isHidden = false
            self.secondSubTitleLbl.isHidden = false
        } else {
            self.maxPiratesReachedLbl.isHidden = true
            self.maxPiratesReachedView.isHidden = true
            self.resetPirateBtn.isHidden = true
            self.subTitleLbl.isHidden = true
            self.secondSubTitleLbl.isHidden = true
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
            self.piratePriceLblPlank.alpha = 0.8
           
        } else {
            self.buyPlankBtn.setTitleColor(#colorLiteral(red: 0.3593182173, green: 1, blue: 0.9866703255, alpha: 1), for: .normal)
            self.buyPlankBtn.alpha = 0.7
            self.buyPlankBtn.isEnabled = false
            self.pirateNameLbl.textColor = #colorLiteral(red: 0.667081356, green: 0.4763708115, blue: 0.2563533485, alpha: 1)
            self.piratePriceLblPlank.alpha = 0.4
         
            self.plankBtn.isEnabled = false
            self.lockImg.alpha = 0.7
        }
        
        
    }
    
    func setLootLbl(pirate: Pirate) {
        let string = NumberFormatter.localizedString(from: NSNumber(value: pirate.lootAmount), number: NumberFormatter.Style.currency)
        lootLbl.text = string
    }
    
    func setNumberOfPiratesLbl(pirate: Pirate) {
        numberOfPiratesLbl.text = "\(pirate.numberOfPirates)"
    }
    
    func updatePiratePrice(pirate: Pirate) {
        let string = NumberFormatter.localizedString(from: NSNumber(value: pirate.piratePrice), number: NumberFormatter.Style.currency)
        
        piratePriceLbl.text = string
    }
    
    func setPirateNameLbl(pirate: Pirate) {
        self.pirateNameLbl2.text = "\(pirate.name!)"
    }
    
    func setPiratePricePlankLbl(pirate: Pirate) {
        let string = NumberFormatter.localizedString(from: NSNumber(value: pirate.piratePrice), number: NumberFormatter.Style.currency)
        
        self.piratePriceLblPlank.text = string
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
        var groundImage: UIImage = UIImage(named: "ground\(pirate.groundNumber)")!
        groundImg.image = groundImage
        var  backgroundImage: UIImage!
        switch pirate.id {
        case 0...1:
            backgroundImage = UIImage(named: "gamebg9")!
            groundImg.isHidden = false
        case 2...3:
            backgroundImage = UIImage(named: "tropical2")!
            groundImage = UIImage(named: "ground2")!
            groundImg.isHidden = false
        case 4...5:
            backgroundImage = UIImage(named: "gamebg12")!
            groundImg.isHidden = true
        case 6...7:
            backgroundImage = UIImage(named: "gamebg5")!
            groundImage = UIImage(named: "ocean-beach-fg")!
              groundImg.isHidden = false
        case 8...9:
            backgroundImage = UIImage(named: "coralbg")!
              groundImg.isHidden = false
        case 10...12:
            backgroundImage = UIImage(named: "gamebg3")!
              groundImg.isHidden = false
        case 13...14:
             backgroundImage = UIImage(named: "gamebg7")!
              groundImg.isHidden = false
        default:
            print("default")
        }
        
       
        backImgTwo.image = backgroundImage
        
    }
    
    func movePlankDown() {
        UIView.animate(withDuration: 2.0, animations: {
            self.plankImg.frame.origin.y += 1000
        }) { (finished) in
            self.plankImg.isHidden = true
        }
        
    }
    
    func addImagesForAnimation(pirate: Pirate) {
        let img = UIImage(named:"pirate\(pirate.id)attack\(0)")
        pirateImg.image = img
    }
    
    func setPirateImages() {
        pirateImg.stopAnimating()
        pirateImg.animationImages = pirateImgArray
        pirateImg.animationDuration = 0.8
        pirateImg.animationRepeatCount = 1
        pirateImg.startAnimating()
    }

}
