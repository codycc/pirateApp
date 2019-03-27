//
//  DashboardVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2019-01-07.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import GoogleMobileAds
import StoreKit

class DashboardVC: UIViewController, GADBannerViewDelegate, GADRewardBasedVideoAdDelegate  {
    
    
    
    @IBOutlet weak var amountRewardedLbl: UILabel!
    
    @IBOutlet weak var wheelHeight: NSLayoutConstraint!
    @IBOutlet weak var plankLightImg: UIImageView!
    

    @IBOutlet weak var parrotImage: UIImageView!
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var pirateWidth: NSLayoutConstraint!
    
    @IBOutlet weak var spinNowImage: UIImageView!
    @IBOutlet weak var pirateHeight: NSLayoutConstraint!
    @IBOutlet weak var planksHeight: NSLayoutConstraint!
    @IBOutlet weak var wheelSpinnerHeight: NSLayoutConstraint!

    @IBOutlet weak var wheel: UIImageView!
    @IBOutlet weak var pirateWheel: UIImageView!
    var parrotImages = [UIImage]()
    var totalDegree = 0
    var walletArray = [Wallet]()
    var userArray = [User]()
    var treasureItems = [Treasure]()
    var userFinishedWatchingAd = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
    let requestUser = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    let requestTreasure = NSFetchRequest<NSFetchRequestResult>(entityName: "Treasure")
    var lootPlayer: AVAudioPlayer!
    var exitPlayer: AVAudioPlayer!
    var wheelPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let tapGestureWheel = UITapGestureRecognizer(target: self, action: #selector(DashboardVC.wheelSpinPressed(_:)))
        self.wheel.addGestureRecognizer(tapGestureWheel)
        
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-1067425139660844/7589813936")
        
        self.wheelHeight.constant = self.view.frame.height / 2 - 50
        self.wheelSpinnerHeight.constant = self.view.frame.height / 2 - 50
       
        grabWalletData()
        grabUserData()
        grabTreasureItems()
        pirateWidth.constant = UIScreen.main.bounds.width / 2
        pirateHeight.constant = UIScreen.main.bounds.height / 3
      
        checkIfSpinNowImageIsDisplayed()
        // Do any additional setup after loading the view.
    }
 
    func checkIfSpinNowImageIsDisplayed() {
        let timeInterval = NSDate().timeIntervalSince1970
        if !userArray[0].hasHadFirstFreeSpin {
           spinNowImage.image = UIImage(named: "spinnowtreasurewheel.png")
        } else if Int32(timeInterval - 86400) < userArray[0].lastFreeSpin {
           spinNowImage.image = UIImage(named: "watchadtospintreasurewheel.png")
        } else {
    
        }
    }
    func playLootSoundEffect() {
        let shopPath = Bundle.main.path(forResource: "loot", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: shopPath!)
        
        do {
            try lootPlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            lootPlayer.prepareToPlay()
            lootPlayer.numberOfLoops = 0
            lootPlayer.volume = 0.7
            lootPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
 
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        userFinishedWatchingAd = true
        self.doWheelSpin()
    }
    
    func grabWalletData() {
        let context = appDelegate.persistentContainer.viewContext
        walletArray = []
        // fetching Wallet Entity from CoreData
        do {
            let results = try context.fetch(requestWallet)
            if results.count > 0 {
                for result in results {
                    walletArray.append(result as! Wallet)
                }
            }
        } catch {
            // handle error
        }
    }
    
    func animateRewardLbl() {
        self.amountRewardedLbl.isHidden = false 
        UIView.animate(withDuration: 2.0, animations: {
            self.amountRewardedLbl.center.y -= UIScreen.main.bounds.height / 10
        }) { (finished) in
            
            
        }
        
    }
    
    func playWheelSoundEffect() {
        let path = Bundle.main.path(forResource: "soundeffect", ofType: "mp3")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
        try wheelPlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
        wheelPlayer.prepareToPlay()
        wheelPlayer.volume = 0.3
        wheelPlayer.play()
        } catch let err as NSError {
        print(err.debugDescription)
        }
    }
    
    func playExitSoundEffect() {
        let path = Bundle.main.path(forResource: "pop", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try exitPlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            exitPlayer.prepareToPlay()
            exitPlayer.volume = 0.3
            exitPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func grabUserData() {
        let context = appDelegate.persistentContainer.viewContext
        userArray = []
        // fetching Wallet Entity from CoreData
        do {
            let results = try context.fetch(requestUser)
            if results.count > 0 {
                for result in results {
                    userArray.append(result as! User)
                }
            }
        } catch {
            // handle error
        }
    }
    
    func radiansToDegress(radians: CGFloat) -> CGFloat {
        return radians * 180 / CGFloat(Double.pi)
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-1067425139660844/7589813936")
    }
    
    
    func grabTreasureItems() {
        let context = appDelegate.persistentContainer.viewContext
        treasureItems = []
        // fetching Wallet Entity from CoreData
        do {
            let results = try context.fetch(requestTreasure)
            if results.count > 0 {
                for result in results {
                    treasureItems.append(result as! Treasure)
                }
            }
        } catch {
            // handle error
        }
    }
    
    func doWheelSpin() {
        self.amountRewardedLbl.isHidden = true
        self.amountRewardedLbl.center.y += UIScreen.main.bounds.height / 10
        let timeInterval = NSDate().timeIntervalSince1970
        if Int32(timeInterval - 86400) > userArray[0].lastFreeSpin || !userArray[0].hasHadFirstFreeSpin || userFinishedWatchingAd  {
            if wheel.isUserInteractionEnabled {
                playWheelSoundEffect()
                userArray[0].lastFreeSpin = Int32(timeInterval)
                //change back eventually
                if userArray[0].hasHadFirstFreeSpin == false {
                    userArray[0].hasHadFirstFreeSpin = true
                }
                
                let rotateView = CABasicAnimation()
                let randonAngle = arc4random_uniform(361) + 1550

                rotateView.fromValue = 1
        
                rotateView.toValue = Int((Float(randonAngle) * 3.14) / 100)
                let randomSpeed = 6
                rotateView.duration = CFTimeInterval(randomSpeed)
                rotateView.repeatCount = 0
                rotateView.isRemovedOnCompletion = false
                rotateView.fillMode = CAMediaTimingFillMode.forwards
                rotateView.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
                pirateWheel.layer.add(rotateView, forKey: "transform.rotation.z")
                self.wheel.isUserInteractionEnabled = false
                
                var testAngle = CGFloat(0)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.2) {
                    let transform:CATransform3D = self.pirateWheel.layer.presentation()!.transform
                    let angle: CGFloat = atan2(transform.m12, transform.m11)
                    testAngle = self.radiansToDegress(radians: angle)
                    if testAngle < 0 {
                        testAngle = 360 + testAngle
                    }
                    self.amountRewardedLbl.isHidden = false
                    self.wheel.isUserInteractionEnabled = true
                    print("\(testAngle)")
                    switch testAngle {
                    case 0...20:
                        print("youve won common")
                        self.playLootSoundEffect()
                        self.amountRewardedLbl.text = "+1 Common Treasure"
                        let randomTreasure = Int.random(in: 1...27)
                        for treasure in self.treasureItems {
                            if treasure.id == randomTreasure {
                                treasure.isUnlocked = true
                                treasure.numberOfTreasures += 1
                                treasure.timeUnlocked = Int32(NSDate().timeIntervalSince1970)
                                print("\(treasure.name!)common")
                            }
                        }
                        
                    case 21...24:
                        print("youve won epic")
                        self.playLootSoundEffect()

                        self.amountRewardedLbl.text = "+1 Epic Treasure"
                        let randomTreasure = Int.random(in: 52...78)
                        for treasure in self.treasureItems {
                            if treasure.id == randomTreasure {
                                treasure.isUnlocked = true
                                treasure.numberOfTreasures += 1
                                treasure.timeUnlocked = Int32(NSDate().timeIntervalSince1970)
                                print("\(treasure.name!)common")
                            }
                        }
                        
                    case 25...36:
                        print("youve won rare")
                        self.playLootSoundEffect()
                        self.amountRewardedLbl.text = "+1 Rare Treasure"
                        let randomTreasure = Int.random(in: 28...51)
                        for treasure in self.treasureItems {
                            if treasure.id == randomTreasure {
                                treasure.isUnlocked = true
                                treasure.numberOfTreasures += 1
                                treasure.timeUnlocked = Int32(NSDate().timeIntervalSince1970)
                                print("\(treasure.name!)common")
                            }
                        }
                    case 37...72:
                        print("youve won 25k loot")
                        self.playLootSoundEffect()
                        self.walletArray[0].totalLootAmount += 25000
                         self.amountRewardedLbl.text = "+25k LOOT"
                    case 73...108:
                        print("youve won 10k loot ")
                        self.playLootSoundEffect()
                        self.walletArray[0].totalLootAmount += 10000
                         self.amountRewardedLbl.text = "+10K LOOT"
                    case 109...144:
                        print("youve won 50k loot ")
                        self.playLootSoundEffect()
                        self.walletArray[0].totalLootAmount += 50000
                         self.amountRewardedLbl.text = "+50K LOOT"
                    case 145...180:
                        print("youve won 2x gems ")
                        self.playLootSoundEffect()
                        self.walletArray[0].totalGemsAmount += 2
                         self.amountRewardedLbl.text = "+2 GEMS"
                    case 181...216:
                        print("youve won 25k loot")
                        self.playLootSoundEffect()
                        self.walletArray[0].totalLootAmount += 25000
                         self.amountRewardedLbl.text = "+25K LOOT"
                    case 217...252:
                        print("youve won 1 gem ")
                        self.playLootSoundEffect()
                        self.walletArray[0].totalGemsAmount += 1
                         self.amountRewardedLbl.text = "+1 GEM"
                    case 253...288:
                        print("youve won 50k loot ")
                        self.playLootSoundEffect()
                        self.walletArray[0].totalLootAmount += 50000
                         self.amountRewardedLbl.text = "+50K LOOT"
                    case 289...324:
                        print("youve won25k loot ")
                        self.playLootSoundEffect()
                        self.walletArray[0].totalLootAmount += 25000
                         self.amountRewardedLbl.text = "+25K LOOT"
                    case 324...360:
                        print("youve won 100k loot")
                        self.playLootSoundEffect()
                        self.walletArray[0].totalLootAmount += 100000
                         self.amountRewardedLbl.text = "+100K LOOT"
                    default:
                        print("default")
                    }
                    let context = self.appDelegate.persistentContainer.viewContext
                    do {
                        try context.save()
                        self.checkIfSpinNowImageIsDisplayed()
                        self.userFinishedWatchingAd = false
                        self.animateRewardLbl()
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLoot"), object: nil, userInfo: nil)
                        if #available(iOS 10.3, *) {
                            SKStoreReviewController.requestReview()
                        } else {
                            
                        }
                    } catch {
                        
                    }
                }
            }
        } else {
            //change back eventually
            if GADRewardBasedVideoAd.sharedInstance().isReady == true {
                GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
            }
        }
       
 
    }
    
    
    
    @IBAction func wheelSpinPressed(_ sender: Any) {
       doWheelSpin()
      
      
        // Here is the helper function
        
       
    
    }
    

    @IBAction func exitBtnPressed(_ sender: Any) {
        playExitSoundEffect()
        self.dismiss(animated: true, completion: nil)
    }
    
   
}
