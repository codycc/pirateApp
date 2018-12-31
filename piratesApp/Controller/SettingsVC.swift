//
//  SettingsVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-12-19.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds
import CoreData

class SettingsVC: UIViewController, GADRewardBasedVideoAdDelegate  {
    @IBOutlet weak var freeLootBtn: UIView!
    @IBOutlet weak var upgradesBtn: UIView!
    @IBOutlet weak var exitBtn: UIView!
    
    var shopPlayer: AVAudioPlayer!
    var popPlayer: AVAudioPlayer!
    var lootPlayer: AVAudioPlayer!
    var wallet = [Wallet]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGestureFreeLoot = UITapGestureRecognizer(target: self, action: #selector(SettingsVC.freeLootTapped(_:)))
        self.freeLootBtn.addGestureRecognizer(tapGestureFreeLoot)
        
        let tapGestureUpgrades = UITapGestureRecognizer(target: self, action: #selector(SettingsVC.upgradesTapped(_:)))
        self.upgradesBtn.addGestureRecognizer(tapGestureUpgrades)
        
        let tapGestureExit = UITapGestureRecognizer(target: self, action: #selector(SettingsVC.exitTapped(_:)))
        self.exitBtn.addGestureRecognizer(tapGestureExit)
        
         GADRewardBasedVideoAd.sharedInstance().delegate = self
        // fetching Wallet Entity from CoreData
        do {
            let context = appDelegate.persistentContainer.viewContext
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
    
    
    
    func playPopSoundEffect() {
        let path = Bundle.main.path(forResource: "pop", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try popPlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            popPlayer.prepareToPlay()
            popPlayer.volume = 0.3
            popPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func playStoreSound() {
        let shopPath = Bundle.main.path(forResource: "shopNoise", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: shopPath!)
        
        do {
            try shopPlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            shopPlayer.prepareToPlay()
            shopPlayer.numberOfLoops = 0
            shopPlayer.volume = 0.7
            shopPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        performSegue(withIdentifier: "goToStoreVC", sender: nil)
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
        
        performSegue(withIdentifier: "goToStoreVC", sender: nil)
    }
    
    func checkIfAdIsReady() {
        freeLootBtn.alpha = 0.6
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
       freeLootBtn.alpha = 1.0
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        // reload a video
        checkIfAdIsReady()
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-1067425139660844/7589813936")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        let context = appDelegate.persistentContainer.viewContext
        wallet[0].totalLootAmount += 10000
        
        // post notification to update wallet loot on main vc
        do {
            try context.save()
            playLootSoundEffect()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLoot"), object: nil)
        } catch {
            //handle error
        }
        
    }
        

    @IBAction func freeLootTapped(_ sender: Any) {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        } else {
            print("not ready")
        }
    }
    
    @IBAction func upgradesTapped(_ sender: Any) {
        playStoreSound()
        
    }
    
    @IBAction func exitTapped(_ sender: Any) {
        playPopSoundEffect()
        self.dismiss(animated: true, completion: nil)
    }

}
