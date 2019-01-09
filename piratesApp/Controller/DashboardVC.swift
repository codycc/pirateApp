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
    var userFinishedWatchingAd = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
    let requestUser = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    var lootPlayer: AVAudioPlayer!
    var exitPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let tapGestureWheel = UITapGestureRecognizer(target: self, action: #selector(DashboardVC.wheelSpinPressed(_:)))
        self.wheel.addGestureRecognizer(tapGestureWheel)
        
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
        
        self.wheelHeight.constant = self.view.frame.height / 2 - 50
        self.wheelSpinnerHeight.constant = self.view.frame.height / 2 - 50
       
        grabWalletData()
        grabUserData()
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
            self.amountRewardedLbl.isHidden = true
             self.amountRewardedLbl.center.y += UIScreen.main.bounds.height / 10
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
                                                    withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
    }
    
    func doWheelSpin() {
        let timeInterval = NSDate().timeIntervalSince1970
        if Int32(timeInterval - 86400) > userArray[0].lastFreeSpin || !userArray[0].hasHadFirstFreeSpin || userFinishedWatchingAd  {
            if wheel.isUserInteractionEnabled {
                
                userArray[0].lastFreeSpin = Int32(timeInterval)
                if userArray[0].hasHadFirstFreeSpin == false {
                    userArray[0].hasHadFirstFreeSpin = true
                }
                
                let rotateView = CABasicAnimation()
                let randonAngle = arc4random_uniform(361) + 1440
                rotateView.fromValue = 1
                rotateView.toValue = Float(randonAngle) * Float(Double.pi) / 100//180.0
                let randomSpeed = 7.0
                rotateView.duration = CFTimeInterval(randomSpeed)
                rotateView.repeatCount = 0
                rotateView.isRemovedOnCompletion = false
                rotateView.fillMode = CAMediaTimingFillMode.forwards
                rotateView.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
                pirateWheel.layer.add(rotateView, forKey: "transform.rotation.z")
                self.wheel.isUserInteractionEnabled = false
                
                var testAngle = CGFloat(0)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 7.2) {
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
                    case 0...36:
                        print("youve won 1 gem")
                        self.playLootSoundEffect()
                        self.walletArray[0].totalGemsAmount += 1
                        self.amountRewardedLbl.text = "+1 GEM"
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
                    } catch {
                        
                    }
                }
            }
        } else {
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
