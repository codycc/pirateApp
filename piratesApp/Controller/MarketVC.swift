//
//  MarketVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2019-01-09.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import SwiftyStoreKit

let inAppPurchaseIds = ["com.codycondon.piratesApp.fortyGems","com.codycondon.piratesApp.threeHundredGems","com.codycondon.piratesApp.EightHundredGems"]

class MarketVC: UIViewController {

    
    @IBOutlet weak var eightHundredGemsLbl: UILabel!
    @IBOutlet weak var threeHundredGemsLbl: UILabel!
    @IBOutlet weak var fortyGemsLbl: UILabel!
    @IBOutlet weak var walletGems: UILabel!
    
    @IBOutlet weak var walletLoot: UILabel!
    @IBOutlet weak var hundredThousandLoot: UIView!
    
    @IBOutlet weak var twoFiftyLoot: UIView!
    
    @IBOutlet weak var twoMillionLoot: UIView!
    
    @IBOutlet weak var commonChest: UIView!
    
    @IBOutlet weak var rareChest: UIView!
    
    @IBOutlet weak var epicChest: UIView!
    
    @IBOutlet weak var storePurchase1: UIView!
    
    @IBOutlet weak var storePurchase2: UIView!
    
    @IBOutlet weak var treasureImage: UIImageView!
    @IBOutlet weak var storePurchase3: UIView!
    
    @IBOutlet weak var revealView: UIView!
    @IBOutlet weak var revealTypes: UILabel!
    
    @IBOutlet weak var revealViewHeight: NSLayoutConstraint!
    @IBOutlet weak var revealCategory: UILabel!
    @IBOutlet weak var revealHeight: NSLayoutConstraint!
    @IBOutlet weak var imageRevealHeight: NSLayoutConstraint!
    var wallet = [Wallet]()
    var treasureItems = [Treasure]()
    var popPlayer: AVAudioPlayer!
    var lootPlayer: AVAudioPlayer!
    var chestPlayer: AVAudioPlayer!
    var purchasePlayer: AVAudioPlayer!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
    let requestTreasure = NSFetchRequest<NSFetchRequestResult>(entityName: "Treasure")
    
    let sharedSecret = "a23a0466b8b24729bb1e6a1fa58dc97f"
    
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
        
        
        let tapGestureRevealView = UITapGestureRecognizer(target: self, action: #selector(MarketVC.revealViewTapped(_:)))
        self.revealView.addGestureRecognizer(tapGestureRevealView)
        
        
        
        revealViewHeight.constant = UIScreen.main.bounds.height / 2
        imageRevealHeight.constant = UIScreen.main.bounds.height / 6
        
        grabWallet()
        grabTreasureItems()
        updateWalletAmounts()
        
        for i in 0...inAppPurchaseIds.count - 1 {
            SwiftyStoreKit.retrieveProductsInfo([inAppPurchaseIds[i]]) { result in
                if let product = result.retrievedProducts.first {
                    let priceString = product.localizedPrice!
                    print("Product: \(product.localizedDescription), price: \(priceString)")
                    
                    switch i {
                    case 0:
                        self.fortyGemsLbl.text = "\(priceString)"
//                        self.verifyPurchase(with: inAppPurchaseIds[0] , sharedSecret: self.sharedSecret)
                    case 1:
                        self.threeHundredGemsLbl.text = "\(priceString)"
//                        self.verifyPurchase(with: inAppPurchaseIds[1] , sharedSecret: self.sharedSecret)
                    case 2:
                        self.eightHundredGemsLbl.text = "\(priceString)"
//                        self.verifyPurchase(with: inAppPurchaseIds[2] , sharedSecret: self.sharedSecret)
                    default:
                        print("default")
                        
                    }
                }
                else if let invalidProductId = result.invalidProductIDs.first {
                    print("Invalid product identifier: \(invalidProductId)")
                }
                else {
                    print("Error: \(String(describing: result.error))")
                }
            }
        }
        
    
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
    
    func playPurchaseSoundEffect() {
        let path = Bundle.main.path(forResource: "purchase", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try purchasePlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            purchasePlayer.prepareToPlay()
            purchasePlayer.volume = 0.7
            purchasePlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
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
    
    func playChestSound() {
        let chestPath = Bundle.main.path(forResource: "prestige", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: chestPath!)
        
        do {
            try chestPlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            chestPlayer.prepareToPlay()
            chestPlayer.numberOfLoops = 0
            chestPlayer.volume = 0.7
            chestPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func updateWalletAmounts() {
        var string = ""
        let walletAmount = wallet[0].totalLootAmount
        
        
        if walletAmount >= 1000000000000 {
            let str = "\(walletAmount)"
            let digits = str.compactMap{Int(String($0))}
            string = "\(digits[0]).\(digits[1])) Trillion"
            
        } else if walletAmount >= 100000000000 {
            let str = "\(walletAmount)"
            let digits = str.compactMap{Int(String($0))}
            string = "\(digits[0])\(digits[1])\(digits[2]) Billion"
            
            
        } else if walletAmount >= 10000000000 {
            let str = "\(walletAmount)"
            let digits = str.compactMap{Int(String($0))}
            string = "\(digits[0])\(digits[1])) Billion"
            
            
        } else if walletAmount >= 1000000000 {
            let str = "\(walletAmount)"
            let digits = str.compactMap{Int(String($0))}
            string = "\(digits[0]).\(digits[1]) Billion"
            
        } else if walletAmount >= 100000000 {
            let str = "\(walletAmount)"
            let digits = str.compactMap{Int(String($0))}
            string = "\(digits[0])\(digits[1])\(digits[2]) Million"
            
        } else if walletAmount >= 10000000 {
            let str = "\(walletAmount)"
            let digits = str.compactMap{Int(String($0))}
            string = "\(digits[0])\(digits[1]) Million"
            
        } else if walletAmount >= 1000000 {
            let str = "\(walletAmount)"
            let digits = str.compactMap{Int(String($0))}
            string = "\(digits[0]).\(digits[1]) Million"
            
        } else {
            string = NumberFormatter.localizedString(from: NSNumber(value: walletAmount), number: NumberFormatter.Style.currency)
            
        }
        
        walletLoot.text = string
        walletGems.text = "\(wallet[0].totalGemsAmount)"
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
    
    func purchaseProduct(with id: String) {
        SwiftyStoreKit.retrieveProductsInfo([id]) { result in
            if let product = result.retrievedProducts.first {
                SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: true) { result in
                    switch result {
                    case .success(let product):
                        // fetch content from your server, then:
                        if product.needsFinishTransaction {
                            SwiftyStoreKit.finishTransaction(product.transaction)
                        }
                        
                        switch id {
                        case inAppPurchaseIds[0]:
                            self.wallet[0].totalGemsAmount += 40
                            
                        case inAppPurchaseIds[1]:
                            self.wallet[0].totalGemsAmount += 300
                        case inAppPurchaseIds[2]:
                            self.wallet[0].totalGemsAmount += 800
                        default:
                            print("default")
                        }
                        let context = self.appDelegate.persistentContainer.viewContext
                        do {
                            try context.save()
                            self.updateWalletAmounts()
                            self.playPurchaseSoundEffect()
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLoot"), object: nil, userInfo: nil)
                        } catch {
                            
                        }
                        print("Purchase Success: \(product.productId)")
                    case .error(let error):
                        switch error.code {
                        case .unknown: print("Unknown error. Please contact support")
                        case .clientInvalid: print("Not allowed to make the payment")
                        case .paymentCancelled: break
                        case .paymentInvalid: print("The purchase identifier was invalid")
                        case .paymentNotAllowed: print("The device is not allowed to make the payment")
                        case .storeProductNotAvailable: print("The product is not available in the current storefront")
                        case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                        case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                        case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                        default: print((error as NSError).localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    func verifyPurchase(with id: String, sharedSecret: String, validDuration: TimeInterval? = nil) {
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productId = id
                // Verify the purchase of Consumable or NonConsumable
                let purchaseResult = SwiftyStoreKit.verifyPurchase(
                    productId: productId,
                    inReceipt: receipt)
                
                switch purchaseResult {
                case .purchased(let receiptItem):
                    print("\(productId) is purchased: \(receiptItem)")
                case .notPurchased:
                    print("The user has never purchased \(productId)")
                }
            case .error(let error):
                print("Receipt verification failed: \(error)")
            }
        }
    }
    
    @IBAction func hundredThousandTapped(_ sender: Any) {
        if wallet[0].totalGemsAmount >= 5 {
            wallet[0].totalGemsAmount -= 5
            wallet[0].totalLootAmount += 100000
            updateWalletAmounts()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLoot"), object: nil, userInfo: nil)
            playLootSoundEffect()
        } else {
            
        }
    }
    
    @IBAction func twoFiftyTapped(_ sender: Any) {
        if wallet[0].totalGemsAmount >= 20 {
            wallet[0].totalGemsAmount -= 20
            wallet[0].totalLootAmount += 250000
            updateWalletAmounts()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLoot"), object: nil, userInfo: nil)
            playLootSoundEffect()
        } else {
            
        }
    }
    
    @IBAction func twoMillionTapped(_ sender: Any) {
        if wallet[0].totalGemsAmount >= 50 {
            wallet[0].totalGemsAmount -= 50
            wallet[0].totalLootAmount += 2000000
            updateWalletAmounts()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLoot"), object: nil, userInfo: nil)
            playLootSoundEffect()
        } else {

        }
    }
    
    @IBAction func commonChestTapped(_ sender: Any) {
        print("tapped")
        if wallet[0].totalGemsAmount >= 20 {
            wallet[0].totalGemsAmount -= 20
           // pick the common chest
            //5 items
            // 2-4 common 0-1 rare
            let randomCommon = Int.random(in: 2...4)
            let randomRare = Int.random(in: 0...1)
        
         print("randomCommin\(randomCommon)")
         print("randomRare\(randomRare)")
            
            for _ in 1...randomCommon {
                let randomTreasure = Int.random(in: 1...27)
                for treasure in treasureItems {
                    if treasure.id == randomTreasure {
                        treasure.isUnlocked = true
                        treasure.numberOfTreasures += 1
                        treasure.timeUnlocked = Int32(NSDate().timeIntervalSince1970)
                        print("\(treasure.name!)common")
                    }
                }
            }
        
        switch randomRare {
        case 0:
            print("zero")
        case 1:
            let randomTreasure = Int.random(in: 28...51)
            for treasure in treasureItems {
                if treasure.id == randomTreasure {
                    treasure.isUnlocked = true
                    treasure.numberOfTreasures += 1
                    treasure.timeUnlocked = Int32(NSDate().timeIntervalSince1970)
                    print("\(treasure.name!)rare")
                }
            }
        default:
            print("default")
        }
            
            revealView.isHidden = false
            revealCategory.text = "Common Chest"
            revealTypes.text = "\(randomCommon) Common, \(randomRare) Rare."
            let treasureUIImage = UIImage(named: "category1")!
            treasureImage.image = treasureUIImage
            
            let context = appDelegate.persistentContainer.viewContext
            do {
                try context.save()
                updateWalletAmounts()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLoot"), object: nil, userInfo: nil)
                playChestSound()
            } catch {
                
            }
            
        } else {

        }
    }
    
    @IBAction func rareChestTapped(_ sender: Any) {
        
        if wallet[0].totalGemsAmount >= 50 {
            wallet[0].totalGemsAmount -= 50
            // pick the rare chest
            // 4-6 common 1 rare 1-2 epic
            let randomCommon = Int.random(in: 4...6)
            let randomEpic = Int.random(in: 1...2)
            
            
            for _ in 1...randomCommon {
                let randomTreasure = Int.random(in: 1...27)
                for treasure in treasureItems {
                    if treasure.id == randomTreasure {
                        treasure.isUnlocked = true
                        treasure.numberOfTreasures += 1
                        treasure.timeUnlocked = Int32(NSDate().timeIntervalSince1970)
                        print("\(treasure.name!)common")
                    }
                }
            }

            let randomTreasure = Int.random(in: 28...51)
            for treasure in treasureItems {
                if treasure.id == randomTreasure {
                    treasure.isUnlocked = true
                    treasure.numberOfTreasures += 1
                    treasure.timeUnlocked = Int32(NSDate().timeIntervalSince1970)
                    
                }
            }
            
            for _ in 1...randomEpic {
                let randomTreasure = Int.random(in: 52...78)
                for treasure in treasureItems {
                    if treasure.id == randomTreasure {
                        treasure.isUnlocked = true
                        treasure.numberOfTreasures += 1
                        treasure.timeUnlocked = Int32(NSDate().timeIntervalSince1970)
                    }
                }
            }
            
            revealView.isHidden = false
            revealCategory.text = "Rare Chest"
            revealTypes.text = "\(randomCommon) Common, 1 Rare, \(randomEpic) Epic"
            let treasureUIImage = UIImage(named: "category2")!
            treasureImage.image = treasureUIImage
            
            let context = appDelegate.persistentContainer.viewContext
            do {
                try context.save()
                updateWalletAmounts()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLoot"), object: nil, userInfo: nil)
                playChestSound()
            } catch {
                
            }
            
        } else {
            
        }
    }
    
    @IBAction func epicChestTapped(_ sender: Any) {
        
        if wallet[0].totalGemsAmount >= 350 {
            wallet[0].totalGemsAmount -= 350
            // pick the epic chest
            // 4-6 common 1-2 rare 1-4 epic
            
            let randomCommon = Int.random(in: 4...6)
            let randomRare = Int.random(in:1...2)
            let randomEpic = Int.random(in: 1...4)
            
            for _ in 1...randomCommon {
                let randomTreasure = Int.random(in: 1...27)
                for treasure in treasureItems {
                    if treasure.id == randomTreasure {
                        treasure.isUnlocked = true
                         treasure.numberOfTreasures += 1
                        treasure.timeUnlocked = Int32(NSDate().timeIntervalSince1970)
                        print("\(treasure.name!)common")
                    }
                }
            }
            
            for _ in 1...randomRare {
                let randomTreasure = Int.random(in: 28...51)
                for treasure in treasureItems {
                    if treasure.id == randomTreasure {
                        treasure.isUnlocked = true
                         treasure.numberOfTreasures += 1
                        treasure.timeUnlocked = Int32(NSDate().timeIntervalSince1970)
                    }
                }
            }
            
            for _ in 1...randomEpic {
                let randomTreasure = Int.random(in: 52...78)
                for treasure in treasureItems {
                    if treasure.id == randomTreasure {
                        treasure.isUnlocked = true
                         treasure.numberOfTreasures += 1
                        treasure.timeUnlocked = Int32(NSDate().timeIntervalSince1970)
                    }
                }
            }
            
            revealView.isHidden = false
            revealCategory.text = "Epic Chest"
            revealTypes.text = "\(randomCommon) Common, \(randomRare) Rare, \(randomEpic) Epic"
            let treasureUIImage = UIImage(named: "category3")!
            treasureImage.image = treasureUIImage
            
            
            let context = appDelegate.persistentContainer.viewContext
            do {
                try context.save()
                updateWalletAmounts()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLoot"), object: nil, userInfo: nil) 
                playChestSound()
            } catch {
                
            }
            
        } else {

        }
    }
    
    @IBAction func revealViewTapped(_ sender: Any) {
        playPopSoundEffect()
        revealView.isHidden = true
    }
    
    @IBAction func storePurchase1Tapped(_ sender: Any) {
        purchaseProduct(with: inAppPurchaseIds[0])
       
    }
    
    @IBAction func storePurchase2Tapped(_ sender: Any) {
        purchaseProduct(with: inAppPurchaseIds[1])
    }
    
    @IBAction func storePurchase3Tapped(_ sender: Any) {
        purchaseProduct(with: inAppPurchaseIds[2])
    }

    @IBAction func exitBtnPressed(_ sender: Any) {
        playPopSoundEffect()
        self.dismiss(animated: true, completion: nil)
    }
    


}
