//
//  MarketVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2019-01-09.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import UIKit
import CoreData

class MarketVC: UIViewController {

    @IBOutlet weak var hundredThousandLoot: UIView!
    
    @IBOutlet weak var twoFiftyLoot: UIView!
    
    @IBOutlet weak var twoMillionLoot: UIView!
    
    @IBOutlet weak var commonChest: UIView!
    
    @IBOutlet weak var rareChest: UIView!
    
    @IBOutlet weak var epicChest: UIView!
    
    @IBOutlet weak var storePurchase1: UIView!
    
    @IBOutlet weak var storePurchase2: UIView!
    
    @IBOutlet weak var storePurchase3: UIView!
    
    @IBOutlet weak var revealView: UIView!
    
    @IBOutlet weak var revealHeight: NSLayoutConstraint!
    @IBOutlet weak var imageRevealHeight: NSLayoutConstraint!
    var wallet = [Wallet]()
    var treasureItems = [Treasure]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
    let requestTreasure = NSFetchRequest<NSFetchRequestResult>(entityName: "Treasure")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureHundred = UITapGestureRecognizer(target: self, action: #selector(MarketVC.hundredThousandTapped(_:)))
        self.hundredThousandLoot.addGestureRecognizer(tapGestureHundred)
        
        let tapGestureTwoFifty = UITapGestureRecognizer(target: self, action: #selector(MarketVC.twoFiftyTapped(_:)))
        self.twoFiftyLoot.addGestureRecognizer(tapGestureTwoFifty)
        
        let tapGestureTwoMillion = UITapGestureRecognizer(target: self, action: #selector(MarketVC.twoMillionTapped(_:)))
        self.twoMillionLoot.addGestureRecognizer(tapGestureTwoMillion)
        
        let tapGestureCommonChest = UITapGestureRecognizer(target: self, action: #selector(MarketVC.commonChestTapped(_:)))
        self.commonChest.addGestureRecognizer(tapGestureCommonChest)
        
        let tapGestureRareChest = UITapGestureRecognizer(target: self, action: #selector(MarketVC.rareChestTapped(_:)))
        self.rareChest.addGestureRecognizer(tapGestureRareChest)
        
        let tapGestureEpicChest = UITapGestureRecognizer(target: self, action: #selector(MarketVC.epicChestTapped(_:)))
        self.epicChest.addGestureRecognizer(tapGestureEpicChest)
        
        let tapGestureStore1 = UITapGestureRecognizer(target: self, action: #selector(MarketVC.storePurchase1Tapped(_:)))
        self.storePurchase1.addGestureRecognizer(tapGestureStore1)
        
        let tapGestureStore2 = UITapGestureRecognizer(target: self, action: #selector(MarketVC.storePurchase2Tapped(_:)))
        self.storePurchase2.addGestureRecognizer(tapGestureStore2)
        
        let tapGestureStore3 = UITapGestureRecognizer(target: self, action: #selector(MarketVC.storePurchase3Tapped(_:)))
        self.storePurchase3.addGestureRecognizer(tapGestureStore3)
        revealHeight.constant = UIScreen.main.bounds.width / 2
        imageRevealHeight.constant = UIScreen.main.bounds.width / 4
        
        grabWallet()
        grabTreasureItems()
    }
    
    func grabWallet() {
        let context = appDelegate.persistentContainer.viewContext
        wallet = []
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
    
    
    @IBAction func hundredThousandTapped(_ sender: Any) {
        if wallet[0].totalGemsAmount >= 5 {
            wallet[0].totalGemsAmount -= 5
            wallet[0].totalLootAmount += 100000
        } else {
            
        }
    }
    
    @IBAction func twoFiftyTapped(_ sender: Any) {
        if wallet[0].totalGemsAmount >= 20 {
            wallet[0].totalGemsAmount -= 20
            wallet[0].totalLootAmount += 250000
        } else {
            
        }
    }
    
    @IBAction func twoMillionTapped(_ sender: Any) {
        if wallet[0].totalGemsAmount >= 50 {
            wallet[0].totalGemsAmount -= 50
            wallet[0].totalLootAmount += 2000000
        } else {
            
        }
    }
    
    @IBAction func commonChestTapped(_ sender: Any) {
        print("tapped")
//        if wallet[0].totalGemsAmount >= 20 {
//            wallet[0].totalGemsAmount -= 20
           // pick the common chest
            //5 items
            // 2-4 common 0-1 rare
            let randomCommon = Int.random(in: 2...4)
            let randomRare = Int.random(in: 0...1)
        
        print("randomCommin\(randomCommon)")
         print("randomRare\(randomRare)")
        
            for _ in 2...randomCommon {
                let randomTreasure = Int.random(in: 1...27)
                for treasure in treasureItems {
                    if treasure.id == randomTreasure {
                        treasure.isUnlocked = true
                    }
                }
            }
            
            for _ in 0...randomRare {
                let randomTreasure = Int.random(in: 28...51)
                for treasure in treasureItems {
                    if treasure.id == randomTreasure {
                        treasure.isUnlocked = true
                    }
                }
            }
            
            
            
            let context = appDelegate.persistentContainer.viewContext
            do {
                try context.save()
            } catch {
                
            }
            
//        } else {
//
//        }
    }
    
    @IBAction func rareChestTapped(_ sender: Any) {
        if wallet[0].totalGemsAmount >= 50 {
            wallet[0].totalGemsAmount -= 50
            // pick the rare chest
            // 4-6 common 1 rare 1-2 epic
        } else {
            
        }
    }
    
    @IBAction func epicChestTapped(_ sender: Any) {
        
        if wallet[0].totalGemsAmount >= 350 {
            wallet[0].totalGemsAmount -= 350
            // pick the epic chest
            // 4-6 common 1-2 rare 1-4 epic
        } else {
            
        }
    }
    
    @IBAction func storePurchase1Tapped(_ sender: Any) {
    }
    
    @IBAction func storePurchase2Tapped(_ sender: Any) {
    }
    
    @IBAction func storePurchase3Tapped(_ sender: Any) {
    }

    @IBAction func exitBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
