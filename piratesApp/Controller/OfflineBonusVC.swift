//
//  OfflineBonusVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-11-05.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit

import Firebase
import GoogleMobileAds
import CoreData
import AVFoundation


class OfflineBonusVC: UIViewController, GADBannerViewDelegate, GADRewardBasedVideoAdDelegate {
   
    

    @IBOutlet var offlineNonAdLbl: UILabel!
    @IBOutlet var offlineAdLbl: UILabel!
    @IBOutlet var blueboardAd: UIImageView!
    
    
    var wallet = [Wallet]()
    var amountOfMoneyMade: Double!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var purchasePlayer: AVAudioPlayer!
    var lootPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let offlineNonAdAmount = NumberFormatter.localizedString(from: NSNumber(value: amountOfMoneyMade), number: NumberFormatter.Style.currency)
        let offlineAdAmount = NumberFormatter.localizedString(from: NSNumber(value: amountOfMoneyMade * 2), number: NumberFormatter.Style.currency)
        
        
        offlineNonAdLbl.text = offlineNonAdAmount
        offlineAdLbl.text = offlineAdAmount

        GADRewardBasedVideoAd.sharedInstance().delegate = self
        
        let context = appDelegate.persistentContainer.viewContext
        let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
        
        let tapGestureNonAd = UITapGestureRecognizer(target: self, action: #selector(OfflineBonusVC.offlineNonAdLabelPressed(_:)))
        self.offlineNonAdLbl.addGestureRecognizer(tapGestureNonAd)
        
        let tapGestureAd = UITapGestureRecognizer(target: self, action: #selector(OfflineBonusVC.offlineAdLabelPressed(_:)))
        self.offlineAdLbl.addGestureRecognizer(tapGestureAd)
        
        
        // fetching Wallet Entity from CoreData
        do {
            let results = try context.fetch(requestWallet)
            if results.count > 0 {
                for result in results {
                    wallet.append(result as! Wallet)
                }
            }
        } catch {
            // handle error
        }
        
        // Do any additional setup after loading the view.
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd)  {
        self.dismiss(animated: true, completion: nil)
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        let context = appDelegate.persistentContainer.viewContext
        wallet[0].totalLootAmount += amountOfMoneyMade
        do {
            playLootSoundEffect()
            try context.save()
            
        } catch {
            //handle error
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
    
    func playPurchaseSoundEffect() {
        let path = Bundle.main.path(forResource: "purchase", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try purchasePlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            purchasePlayer.prepareToPlay()
            purchasePlayer.volume = 0.5
            purchasePlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    @IBAction func offlineAdLabelPressed(_ sender: Any) {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
        
       
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        self.blueboardAd.alpha = 1
        self.offlineAdLbl.alpha = 1
        self.offlineAdLbl.isUserInteractionEnabled = true
    }
    
    
    @IBAction func offlineNonAdLabelPressed(_ sender: Any) {
        playPurchaseSoundEffect()
        self.dismiss(animated: true, completion: nil)
        
    }

}
