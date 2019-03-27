//
//  AppDelegate.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-10-17.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds
import Firebase
import SwiftyStoreKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
      

        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        
        FirebaseApp.configure()
        GADMobileAds.configure(withApplicationID: "ca-app-pub-1067425139660844~7276960926")
        
        
        UserDefaults.standard.set(false, forKey: "appClosed")
        //LOADING VIDEO AD
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-1067425139660844/7589813936")
        
        
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing
                }
            }
        }

        
        if launchedBefore {
            
           UserDefaults.standard.set(false, forKey: "launchedOffline")
        } else {
            
            
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            UserDefaults.standard.set(true, forKey: "isFirstUse")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let context = appDelegate.persistentContainer.viewContext
            
            let skollywag = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let plunderPete = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let cutler = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let bandit = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let landlubber = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let roger = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let crook = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let bucaneer = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let thief = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let gunna = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let privateer = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let bayouBenny = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let redbeard = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let bluebeard = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let blackbeard = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            
            
            //set up wallet
            let wallet = NSEntityDescription.insertNewObject(forEntityName: "Wallet", into: context)
            
            wallet.setValue(1100000, forKey: "totalLootAmount")
            wallet.setValue(100, forKey: "totalGemsAmount")
            wallet.setValue(0, forKey: "totalPrestigeAmount")
            
            // set up locations
            let lonelyIsle  = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) //0
            let piratesPeninsula  = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) // 45
            let internationalWaters  = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) // 65
            let lazyLagoon  = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) // 75
            let murkyShallows  = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) // 100
            let redbeardsBayou  = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) // 150
            let theGreatReef  = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) // 200
            
            

            lonelyIsle.setValue(0, forKey: "id")
            lonelyIsle.setValue(true, forKey: "isUnlocked")
            lonelyIsle.setValue(true, forKey: "isCurrent")
            lonelyIsle.setValue(0, forKey: "amountToUnlock")
            lonelyIsle.setValue(0, forKey: "treasureLevel")
            lonelyIsle.setValue("gamebg9", forKey: "image")
            lonelyIsle.setValue("Lonely Isle", forKey: "name")
            
            piratesPeninsula.setValue(1, forKey: "id")
            piratesPeninsula.setValue(false, forKey: "isUnlocked")
            piratesPeninsula.setValue(false, forKey: "isCurrent")
            piratesPeninsula.setValue(150000, forKey: "amountToUnlock")
            piratesPeninsula.setValue(0, forKey: "treasureLevel")
            piratesPeninsula.setValue("tropical2", forKey: "image")
            piratesPeninsula.setValue("Pirate's Peninsula", forKey: "name")
            
            internationalWaters.setValue(2, forKey: "id")
            internationalWaters.setValue(false, forKey: "isUnlocked")
            internationalWaters.setValue(false, forKey: "isCurrent")
            internationalWaters.setValue(1000000, forKey: "amountToUnlock")
            internationalWaters.setValue(1, forKey: "treasureLevel")
            internationalWaters.setValue("gamebg12", forKey: "image")
            internationalWaters.setValue("International Waters", forKey: "name")
            
            lazyLagoon.setValue(3, forKey: "id")
            lazyLagoon.setValue(false, forKey: "isUnlocked")
            lazyLagoon.setValue(false, forKey: "isCurrent")
            lazyLagoon.setValue(2500000, forKey: "amountToUnlock")
            lazyLagoon.setValue(1, forKey: "treasureLevel")
            lazyLagoon.setValue("gamebg5", forKey: "image")
            lazyLagoon.setValue("Lazy Lagoon", forKey: "name")
            
            murkyShallows.setValue(4, forKey: "id")
            murkyShallows.setValue(false, forKey: "isUnlocked")
            murkyShallows.setValue(false, forKey: "isCurrent")
            murkyShallows.setValue(8000000, forKey: "amountToUnlock")
            murkyShallows.setValue(1, forKey: "treasureLevel")
            murkyShallows.setValue("coralbg", forKey: "image")
            murkyShallows.setValue("Murky Shallows", forKey: "name")
            
            redbeardsBayou.setValue(5, forKey: "id")
            redbeardsBayou.setValue(false, forKey: "isUnlocked")
            redbeardsBayou.setValue(false, forKey: "isCurrent")
            redbeardsBayou.setValue(15000000, forKey: "amountToUnlock")
            redbeardsBayou.setValue(2, forKey: "treasureLevel")
            redbeardsBayou.setValue("gamebg3", forKey: "image")
            redbeardsBayou.setValue("Redbeard's Bayou", forKey: "name")
            
            theGreatReef.setValue(6, forKey: "id")
            theGreatReef.setValue(false, forKey: "isUnlocked")
            theGreatReef.setValue(false, forKey: "isCurrent")
            theGreatReef.setValue(30000000, forKey: "amountToUnlock")
            theGreatReef.setValue(2, forKey: "treasureLevel")
            theGreatReef.setValue("gamebg7", forKey: "image")
            theGreatReef.setValue("The Great Reef", forKey: "name")
            
            
            
            
            
            // user
            let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
           
            
            user.setValue(true, forKey: "hasFreeSpin")
            user.setValue(false, forKey: "hasHadFirstFreeSpin")
            user.setValue(0, forKey: "currentLocation")
            user.setValue(1, forKey: "piratePoints")
            user.setValue(1, forKey: "levelPoints")
            user.setValue(0.01, forKey: "bonusAmount")
            user.setValue(0, forKey: "currentHighestLocation")
            
            skollywag.setValue(0, forKey: "id")
            skollywag.setValue("Scolly", forKey: "name")
            skollywag.setValue(10, forKey: "lootTime")
            skollywag.setValue(25, forKey: "lootAmount")
            skollywag.setValue(1, forKey: "numberOfPirates")
            skollywag.setValue(true , forKey: "isAnimating")
            skollywag.setValue(false, forKey: "isUnlocked")
            skollywag.setValue(11, forKey: "numberOfImages")
            skollywag.setValue(1, forKey: "groundNumber")
            skollywag.setValue(1, forKey: "backgroundNumber")
            skollywag.setValue(1, forKey: "plankNumber")
            skollywag.setValue(10, forKey: "currentTime")
            skollywag.setValue(15, forKey: "numberOfImagesAttack")
            skollywag.setValue(10, forKey: "piratePrice")
            skollywag.setValue(0, forKey: "levelToUnlock")
            skollywag.setValue(15, forKey: "levelToUnlockTreasure")
            
            plunderPete.setValue(1, forKey: "id")
            plunderPete.setValue("Plunder Pete", forKey: "name")
            plunderPete.setValue(13, forKey: "lootTime")
            plunderPete.setValue(100, forKey: "lootAmount")
            plunderPete.setValue(1, forKey: "numberOfPirates")
            plunderPete.setValue(false, forKey: "isAnimating")
            plunderPete.setValue(false, forKey: "isUnlocked")
            plunderPete.setValue(11, forKey: "numberOfImages")
            plunderPete.setValue(1, forKey: "groundNumber")
            plunderPete.setValue(2, forKey: "backgroundNumber")
            plunderPete.setValue(2, forKey: "plankNumber")
            plunderPete.setValue(13, forKey: "currentTime")
            plunderPete.setValue(11, forKey: "numberOfImagesAttack")
            plunderPete.setValue(75, forKey: "piratePrice")
            plunderPete.setValue(0, forKey: "levelToUnlock")
            plunderPete.setValue(20, forKey: "levelToUnlockTreasure")

            cutler.setValue(2, forKey: "id")
            cutler.setValue("Cutler", forKey: "name")
            cutler.setValue(15, forKey: "lootTime")
            cutler.setValue(120, forKey: "lootAmount")
            cutler.setValue(0, forKey: "numberOfPirates")
            cutler.setValue(false , forKey: "isAnimating")
            cutler.setValue(false, forKey: "isUnlocked")
            cutler.setValue(15, forKey: "numberOfImages")
            cutler.setValue(1, forKey: "groundNumber")
            cutler.setValue(1, forKey: "backgroundNumber")
            cutler.setValue(3, forKey: "plankNumber")
            cutler.setValue(15, forKey: "currentTime")
            cutler.setValue(15, forKey: "numberOfImagesAttack")
            cutler.setValue(200, forKey: "piratePrice")
            cutler.setValue(1, forKey: "levelToUnlock")
            cutler.setValue(23, forKey: "levelToUnlockTreasure")
            
            bandit.setValue(3, forKey: "id")
            bandit.setValue("Bandit", forKey: "name")
            bandit.setValue(18, forKey: "lootTime")
            bandit.setValue(200, forKey: "lootAmount")
            bandit.setValue(0, forKey: "numberOfPirates")
            bandit.setValue(false, forKey: "isAnimating")
            bandit.setValue(false, forKey: "isUnlocked")
            bandit.setValue(15, forKey: "numberOfImages")
            bandit.setValue(1, forKey: "groundNumber")
            bandit.setValue(2, forKey: "backgroundNumber")
            bandit.setValue(4, forKey: "plankNumber")
            bandit.setValue(18, forKey: "currentTime")
            bandit.setValue(15, forKey: "numberOfImagesAttack")
            bandit.setValue(1500, forKey: "piratePrice")
            bandit.setValue(1, forKey: "levelToUnlock")
            bandit.setValue(25, forKey: "levelToUnlockTreasure")
            
            landlubber.setValue(4, forKey: "id")
            landlubber.setValue("Landlubber", forKey: "name")
            landlubber.setValue(27, forKey: "lootTime")
            landlubber.setValue(400, forKey: "lootAmount")
            landlubber.setValue(0, forKey: "numberOfPirates")
            landlubber.setValue(false, forKey: "isAnimating")
            landlubber.setValue(false, forKey: "isUnlocked")
            landlubber.setValue(15, forKey: "numberOfImages")
            landlubber.setValue(1, forKey: "groundNumber")
            landlubber.setValue(1, forKey: "backgroundNumber")
            landlubber.setValue(5, forKey: "plankNumber")
            landlubber.setValue(27, forKey: "currentTime")
            landlubber.setValue(15, forKey: "numberOfImagesAttack")
            landlubber.setValue(2000, forKey: "piratePrice")
            landlubber.setValue(2, forKey: "levelToUnlock")
            landlubber.setValue(27, forKey: "levelToUnlockTreasure")
            
            roger.setValue(5, forKey: "id")
            roger.setValue("Roger", forKey: "name")
            roger.setValue(36, forKey: "lootTime")
            roger.setValue(500, forKey: "lootAmount")
            roger.setValue(0, forKey: "numberOfPirates")
            roger.setValue(false, forKey: "isAnimating")
            roger.setValue(false, forKey: "isUnlocked")
            roger.setValue(15, forKey: "numberOfImages")
            roger.setValue(2, forKey: "groundNumber")
            roger.setValue(2, forKey: "backgroundNumber")
            roger.setValue(1, forKey: "plankNumber")
            roger.setValue(36, forKey: "currentTime")
            roger.setValue(11, forKey: "numberOfImagesAttack")
            roger.setValue(2500, forKey: "piratePrice")
            roger.setValue(2, forKey: "levelToUnlock")
            roger.setValue(29, forKey: "levelToUnlockTreasure")
            
            crook.setValue(6, forKey: "id")
            crook.setValue("Crook", forKey: "name")
            crook.setValue(45, forKey: "lootTime")
            crook.setValue(600, forKey: "lootAmount")
            crook.setValue(0, forKey: "numberOfPirates")
            crook.setValue(false, forKey: "isAnimating")
            crook.setValue(false, forKey: "isUnlocked")
            crook.setValue(15, forKey: "numberOfImages")
            crook.setValue(2, forKey: "groundNumber")
            crook.setValue(1, forKey: "backgroundNumber")
            crook.setValue(2, forKey: "plankNumber")
            crook.setValue(45, forKey: "currentTime")
            crook.setValue(11, forKey: "numberOfImagesAttack")
            crook.setValue(3000, forKey: "piratePrice")
            crook.setValue(3, forKey: "levelToUnlock")
            crook.setValue(30, forKey: "levelToUnlockTreasure")

            bucaneer.setValue(7, forKey: "id")
            bucaneer.setValue("Buccaneer", forKey: "name")
            bucaneer.setValue(54, forKey: "lootTime")
            bucaneer.setValue(700, forKey: "lootAmount")
            bucaneer.setValue(0, forKey: "numberOfPirates")
            bucaneer.setValue(false, forKey: "isAnimating")
            bucaneer.setValue(false, forKey: "isUnlocked")
            bucaneer.setValue(11, forKey: "numberOfImages")
            bucaneer.setValue(2, forKey: "groundNumber")
            bucaneer.setValue(1, forKey: "backgroundNumber")
            bucaneer.setValue(3, forKey: "plankNumber")
            bucaneer.setValue(54, forKey: "currentTime")
            bucaneer.setValue(15, forKey: "numberOfImagesAttack")
            bucaneer.setValue(3500, forKey: "piratePrice")
            bucaneer.setValue(3, forKey: "levelToUnlock")
            bucaneer.setValue(20, forKey: "levelToUnlockTreasure")
            
            thief.setValue(8, forKey: "id")
            thief.setValue("Thief", forKey: "name")
            thief.setValue(63, forKey: "lootTime")
            thief.setValue(800, forKey: "lootAmount")
            thief.setValue(0, forKey: "numberOfPirates")
            thief.setValue(false, forKey: "isAnimating")
            thief.setValue(false, forKey: "isUnlocked")
            thief.setValue(11, forKey: "numberOfImages")
            thief.setValue(2, forKey: "groundNumber")
            thief.setValue(2, forKey: "backgroundNumber")
            thief.setValue(4, forKey: "plankNumber")
            thief.setValue(63, forKey: "currentTime")
            thief.setValue(15, forKey: "numberOfImagesAttack")
            thief.setValue(4000, forKey: "piratePrice")
            thief.setValue(4, forKey: "levelToUnlock")
            thief.setValue(21, forKey: "levelToUnlockTreasure")
            
            gunna.setValue(9, forKey: "id")
            gunna.setValue("Gunna", forKey: "name")
            gunna.setValue(72, forKey: "lootTime")
            gunna.setValue(900, forKey: "lootAmount")
            gunna.setValue(0, forKey: "numberOfPirates")
            gunna.setValue(false, forKey: "isAnimating")
            gunna.setValue(false, forKey: "isUnlocked")
            gunna.setValue(11, forKey: "numberOfImages")
            gunna.setValue(3, forKey: "groundNumber")
            gunna.setValue(1, forKey: "backgroundNumber")
            gunna.setValue(5, forKey: "plankNumber")
            gunna.setValue(72, forKey: "currentTime")
            gunna.setValue(15, forKey: "numberOfImagesAttack")
            gunna.setValue(4500, forKey: "piratePrice")
            gunna.setValue(4, forKey: "levelToUnlock")
            gunna.setValue(64, forKey: "levelToUnlockTreasure")
            

            bayouBenny.setValue(10, forKey: "id")
            bayouBenny.setValue("Bayou Benny", forKey: "name")
            bayouBenny.setValue(84, forKey: "lootTime")
            bayouBenny.setValue(1000, forKey: "lootAmount")
            bayouBenny.setValue(0, forKey: "numberOfPirates")
            bayouBenny.setValue(false, forKey: "isAnimating")
            bayouBenny.setValue(false, forKey: "isUnlocked")
            bayouBenny.setValue(11, forKey: "numberOfImages")
            bayouBenny.setValue(2, forKey: "groundNumber")
            bayouBenny.setValue(2, forKey: "backgroundNumber")
            bayouBenny.setValue(1, forKey: "plankNumber")
            bayouBenny.setValue(84, forKey: "currentTime")
            bayouBenny.setValue(15, forKey: "numberOfImagesAttack")
            bayouBenny.setValue(5000, forKey: "piratePrice")
            bayouBenny.setValue(5, forKey: "levelToUnlock")
            bayouBenny.setValue(30, forKey: "levelToUnlockTreasure")
            
            privateer.setValue(11, forKey: "id")
            privateer.setValue("Privateer", forKey: "name")
            privateer.setValue(86, forKey: "lootTime")
            privateer.setValue(1100, forKey: "lootAmount")
            privateer.setValue(0, forKey: "numberOfPirates")
            privateer.setValue(false, forKey: "isAnimating")
            privateer.setValue(false, forKey: "isUnlocked")
            privateer.setValue(11, forKey: "numberOfImages")
            privateer.setValue(2, forKey: "groundNumber")
            privateer.setValue(1, forKey: "backgroundNumber")
            privateer.setValue(2, forKey: "plankNumber")
            privateer.setValue(86, forKey: "currentTime")
            privateer.setValue(15, forKey: "numberOfImagesAttack")
            privateer.setValue(5500, forKey: "piratePrice")
            privateer.setValue(5, forKey: "levelToUnlock")
            privateer.setValue(29, forKey: "levelToUnlockTreasure")
            
            redbeard.setValue(12, forKey: "id")
            redbeard.setValue("Redbeard", forKey: "name")
            redbeard.setValue(94, forKey: "lootTime")
            redbeard.setValue(1150, forKey: "lootAmount")
            redbeard.setValue(0, forKey: "numberOfPirates")
            redbeard.setValue(false, forKey: "isAnimating")
            redbeard.setValue(false, forKey: "isUnlocked")
            redbeard.setValue(24, forKey: "numberOfImages")
            redbeard.setValue(3, forKey: "groundNumber")
            redbeard.setValue(2, forKey: "backgroundNumber")
            redbeard.setValue(3, forKey: "plankNumber")
            redbeard.setValue(94, forKey: "currentTime")
            redbeard.setValue(14, forKey: "numberOfImagesAttack")
            redbeard.setValue(6000, forKey: "piratePrice")
            redbeard.setValue(5, forKey: "levelToUnlock")
            redbeard.setValue(34, forKey: "levelToUnlockTreasure")
    
            bluebeard.setValue(13, forKey: "id")
            bluebeard.setValue("Bluebeard", forKey: "name")
            bluebeard.setValue(97, forKey: "lootTime")
            bluebeard.setValue(1200, forKey: "lootAmount")
            bluebeard.setValue(0, forKey: "numberOfPirates")
            bluebeard.setValue(false, forKey: "isAnimating")
            bluebeard.setValue(false, forKey: "isUnlocked")
            bluebeard.setValue(24, forKey: "numberOfImages")
            bluebeard.setValue(3, forKey: "groundNumber")
            bluebeard.setValue(1, forKey: "backgroundNumber")
            bluebeard.setValue(4, forKey: "plankNumber")
            bluebeard.setValue(97, forKey: "currentTime")
            bluebeard.setValue(14, forKey: "numberOfImagesAttack")
            bluebeard.setValue(6500, forKey: "piratePrice")
            bluebeard.setValue(6, forKey: "levelToUnlock")
            bluebeard.setValue(45, forKey: "levelToUnlockTreasure")

            
            blackbeard.setValue(14, forKey: "id")
            blackbeard.setValue("Blackbeard", forKey: "name")
            blackbeard.setValue(99, forKey: "lootTime")
            blackbeard.setValue(1250, forKey: "lootAmount")
            blackbeard.setValue(0, forKey: "numberOfPirates")
            blackbeard.setValue(false, forKey: "isAnimating")
            blackbeard.setValue(false, forKey: "isUnlocked")
            blackbeard.setValue(24, forKey: "numberOfImages")
            blackbeard.setValue(3, forKey: "groundNumber")
            blackbeard.setValue(2, forKey: "backgroundNumber")
            blackbeard.setValue(5, forKey: "plankNumber")
            blackbeard.setValue(99, forKey: "currentTime")
            blackbeard.setValue(14, forKey: "numberOfImagesAttack")
            blackbeard.setValue(6750, forKey: "piratePrice")
            blackbeard.setValue(6, forKey: "levelToUnlock")
            blackbeard.setValue(40, forKey: "levelToUnlockTreasure")

            let storeItem1 = NSEntityDescription.insertNewObject(forEntityName: "StoreItem", into: context)
            let storeItem2 = NSEntityDescription.insertNewObject(forEntityName: "StoreItem", into: context)
            let storeItem3 = NSEntityDescription.insertNewObject(forEntityName: "StoreItem", into: context)
            let storeItem4 = NSEntityDescription.insertNewObject(forEntityName: "StoreItem", into: context)
            let storeItem5 = NSEntityDescription.insertNewObject(forEntityName: "StoreItem", into: context)
            let storeItem6 = NSEntityDescription.insertNewObject(forEntityName: "StoreItem", into: context)
            
            storeItem1.setValue(50000, forKey: "amountOfLoot")
            storeItem1.setValue(99, forKey: "priceInCents")
            storeItem1.setValue("coins_pack_1", forKey: "image")
            storeItem1.setValue(1,forKey: "id")
            storeItem1.setValue("blueboard99", forKey: "imageBlue")
            
            storeItem2.setValue(200000, forKey: "amountOfLoot")
            storeItem2.setValue(299, forKey: "priceInCents")
            storeItem2.setValue("coins_pack_2", forKey: "image")
            storeItem2.setValue(2,forKey: "id")
            storeItem2.setValue("blueboard299", forKey: "imageBlue")
            
            storeItem3.setValue(500000, forKey: "amountOfLoot")
            storeItem3.setValue(699, forKey: "priceInCents")
            storeItem3.setValue("coins_pack_3", forKey: "image")
            storeItem3.setValue(3,forKey: "id")
            storeItem3.setValue("blueboard699", forKey: "imageBlue")
            
            storeItem4.setValue(2500000, forKey: "amountOfLoot")
            storeItem4.setValue(1399, forKey: "priceInCents")
            storeItem4.setValue("coins_pack_4", forKey: "image")
            storeItem4.setValue(4,forKey: "id")
            storeItem4.setValue("blueboard1399", forKey: "imageBlue")
            
            storeItem5.setValue(10000000, forKey: "amountOfLoot")
            storeItem5.setValue(2799, forKey: "priceInCents")
            storeItem5.setValue("front_chest_coins", forKey: "image")
            storeItem5.setValue(5,forKey: "id")
            storeItem5.setValue("blueboard2799", forKey: "imageBlue")
            
            storeItem6.setValue(3, forKey: "amountOfPrestige")
            storeItem6.setValue(6399, forKey: "priceInCents")
            storeItem6.setValue("front_chest_gems", forKey: "image")
            storeItem6.setValue(6,forKey: "id")
            storeItem6.setValue("blueboard6399", forKey: "imageBlue")
            
            
            //Treasures
            let piratesRope = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let crate = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let whiteFlag = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let buccaneersBarrel = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let yellowCoral = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let blackJacksBronzeCoins = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let atlantisGold = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let yellowSeahorse = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let cannonBalls = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let copperGoblet = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let stoneGoblet = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let rustedAnchor = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let sharkBaitSword = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let orangeCoral = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let greenCoral = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let pinkCoral = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let commonHook = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let cutlass = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let sharkTeethCutlass = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let shiverMeSword = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let noMansKnife = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let deepSeaSword = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let jollysKnife = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let blueSeaweed = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let fishingLure = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let silverThread = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let rubyThread = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let seaDogsSilver = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let octopus = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let blackEyepatch = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let commonGrog = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let silverAncientPot = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let treasureMapCommon = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let silverCompass = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let captainsWheel = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let captainsGoldenWheel = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let ancientClamShell = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let seadogsSpyGlass = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let seadogsGoldSpyGlass = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let treasureMapRare = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let fishingLure2 = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let oldMansCutlass = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let noMansFlag = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let messageInABottle = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let purpleSkullFlag = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let redLantern = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let seaUrchantPurple = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let silverAnchor = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let deepSeaBall = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let deepSeaEmeraldBall = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let deepSeaRubyBall = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let atlantisStarfish = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let goldCompass = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let skullEyepatch = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let blueBeardsPotion = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let redBeardsPotion = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let silverGoblet = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let clam = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let seaUrchant = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let anchor = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let rareHook = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let marianasRubyTreasure = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let marianasEmeraldTreasure = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let marianasAncientTreasure = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let rareGrog = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let goldenSeaUrchant = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let waxSealedMessage = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let purpleCoral = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let aquaCoral = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let pearls = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let blackPearls = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let epicGrog = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let herculesLostItem = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let goldenGoblet = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let goldAncientPot = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let epicHook = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let rubyJewel = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            let goldenAnchor = NSEntityDescription.insertNewObject(forEntityName: "Treasure", into: context)
            
            
            piratesRope.setValue("Pirate's Rope", forKey: "name")
            piratesRope.setValue(1,forKey: "id")
            piratesRope.setValue(1,forKey:"categoryId")
            piratesRope.setValue(false, forKey: "isUnlocked")
            
            
            crate.setValue("Crate", forKey: "name")
            crate.setValue(2,forKey: "id")
            crate.setValue(1,forKey:"categoryId")
            crate.setValue(false, forKey: "isUnlocked")
            
            whiteFlag.setValue("Pirate's Rope", forKey: "name")
            whiteFlag.setValue(3,forKey: "id")
            whiteFlag.setValue(1,forKey:"categoryId")
            whiteFlag.setValue(false, forKey: "isUnlocked")
            
            
            buccaneersBarrel.setValue("Buccaneer's Barrel", forKey: "name")
            buccaneersBarrel.setValue(4,forKey: "id")
            buccaneersBarrel.setValue(1,forKey:"categoryId")
            buccaneersBarrel.setValue(false, forKey: "isUnlocked")
            
            
            yellowCoral.setValue("Yellow Coral", forKey: "name")
            yellowCoral.setValue(5,forKey: "id")
            yellowCoral.setValue(1,forKey:"categoryId")
            yellowCoral.setValue(false, forKey: "isUnlocked")
            
            
            blackJacksBronzeCoins.setValue("BlackJack's Bronze Coins", forKey: "name")
            blackJacksBronzeCoins.setValue(6,forKey: "id")
            blackJacksBronzeCoins.setValue(1,forKey:"categoryId")
            blackJacksBronzeCoins.setValue(false, forKey: "isUnlocked")
            
            
            atlantisGold.setValue("Atlantis Gold", forKey: "name")
            atlantisGold.setValue(7,forKey: "id")
            atlantisGold.setValue(1,forKey:"categoryId")
            atlantisGold.setValue(false, forKey: "isUnlocked")
            
            
            yellowSeahorse.setValue("Yellow Seahorse", forKey: "name")
            yellowSeahorse.setValue(8,forKey: "id")
            yellowSeahorse.setValue(1,forKey:"categoryId")
            yellowSeahorse.setValue(false, forKey: "isUnlocked")
            
            
            cannonBalls.setValue("Cannon Balls", forKey: "name")
            cannonBalls.setValue(9,forKey: "id")
            cannonBalls.setValue(1,forKey:"categoryId")
            cannonBalls.setValue(false, forKey: "isUnlocked")
            
            stoneGoblet.setValue("Stone Goblet", forKey: "name")
            stoneGoblet.setValue(10,forKey: "id")
            stoneGoblet.setValue(1,forKey:"categoryId")
            stoneGoblet.setValue(false, forKey: "isUnlocked")
            
            
            copperGoblet.setValue("Copper Goblet", forKey: "name")
            copperGoblet.setValue(11,forKey: "id")
            copperGoblet.setValue(1,forKey:"categoryId")
            copperGoblet.setValue(false, forKey: "isUnlocked")
            
            
            rustedAnchor.setValue("Rusted Anchor", forKey: "name")
            rustedAnchor.setValue(12,forKey: "id")
            rustedAnchor.setValue(1,forKey:"categoryId")
            rustedAnchor.setValue(false, forKey: "isUnlocked")
            
            
            
            sharkBaitSword.setValue("SharkBait Sword", forKey: "name")
            sharkBaitSword.setValue(13,forKey: "id")
            sharkBaitSword.setValue(1,forKey:"categoryId")
            sharkBaitSword.setValue(false, forKey: "isUnlocked")
            
            
            orangeCoral.setValue("Orange Coral", forKey: "name")
            orangeCoral.setValue(14,forKey: "id")
            orangeCoral.setValue(1,forKey:"categoryId")
            orangeCoral.setValue(false, forKey: "isUnlocked")
            
            
            greenCoral.setValue("Green Coral", forKey: "name")
            greenCoral.setValue(15,forKey: "id")
            greenCoral.setValue(1,forKey:"categoryId")
            greenCoral.setValue(false, forKey: "isUnlocked")
            
            
            pinkCoral.setValue("Pink Coral", forKey: "name")
            pinkCoral.setValue(16,forKey: "id")
            pinkCoral.setValue(1,forKey:"categoryId")
            pinkCoral.setValue(false, forKey: "isUnlocked")
            
            
            commonHook.setValue("Common Hook", forKey: "name")
            commonHook.setValue(17,forKey: "id")
            commonHook.setValue(1,forKey:"categoryId")
            commonHook.setValue(false, forKey: "isUnlocked")
            
            cutlass.setValue("Cutlass", forKey: "name")
            cutlass.setValue(18,forKey: "id")
            cutlass.setValue(1,forKey:"categoryId")
            cutlass.setValue(false, forKey: "isUnlocked")
            
            
            sharkTeethCutlass.setValue("Sharkteeth Cutlass", forKey: "name")
            sharkTeethCutlass.setValue(19,forKey: "id")
            sharkTeethCutlass.setValue(1,forKey:"categoryId")
            sharkTeethCutlass.setValue(false, forKey: "isUnlocked")
            
            shiverMeSword.setValue("Shiver Me' Sword", forKey: "name")
            shiverMeSword.setValue(20,forKey: "id")
            shiverMeSword.setValue(1,forKey:"categoryId")
            shiverMeSword.setValue(false, forKey: "isUnlocked")
            
            
            noMansKnife.setValue("Noman's Knife", forKey: "name")
            noMansKnife.setValue(21,forKey: "id")
            noMansKnife.setValue(1,forKey:"categoryId")
            noMansKnife.setValue(false, forKey: "isUnlocked")
            
            
            deepSeaSword.setValue("DeepSea Sword", forKey: "name")
            deepSeaSword.setValue(22,forKey: "id")
            deepSeaSword.setValue(1,forKey:"categoryId")
            deepSeaSword.setValue(false, forKey: "isUnlocked")
            
            
            jollysKnife.setValue("Jolly's Knife", forKey: "name")
            jollysKnife.setValue(23,forKey: "id")
            jollysKnife.setValue(1,forKey:"categoryId")
            jollysKnife.setValue(false, forKey: "isUnlocked")
            
            
            blueSeaweed.setValue("Blue Seaweed", forKey: "name")
            blueSeaweed.setValue(24,forKey: "id")
            blueSeaweed.setValue(1,forKey:"categoryId")
            blueSeaweed.setValue(false, forKey: "isUnlocked")
            
            
            fishingLure.setValue("Fishing Lure", forKey: "name")
            fishingLure.setValue(25,forKey: "id")
            fishingLure.setValue(1,forKey:"categoryId")
            fishingLure.setValue(false, forKey: "isUnlocked")
            
            
            silverThread.setValue("Silver Thread", forKey: "name")
            silverThread.setValue(26,forKey: "id")
            silverThread.setValue(1,forKey:"categoryId")
            silverThread.setValue(false, forKey: "isUnlocked")
            
            rubyThread.setValue("Ruby Thread", forKey: "name")
            rubyThread.setValue(27,forKey: "id")
            rubyThread.setValue(1,forKey:"categoryId")
            rubyThread.setValue(false, forKey: "isUnlocked")
            
            
            seaDogsSilver.setValue("SeaDog's Silver", forKey: "name")
            seaDogsSilver.setValue(28,forKey: "id")
            seaDogsSilver.setValue(2,forKey:"categoryId")
            seaDogsSilver.setValue(false, forKey: "isUnlocked")
            
            octopus.setValue("Octopus", forKey: "name")
            octopus.setValue(29,forKey: "id")
            octopus.setValue(2,forKey:"categoryId")
            octopus.setValue(false, forKey: "isUnlocked")
            
            
            blackEyepatch.setValue("Black Eyepatch", forKey: "name")
            blackEyepatch.setValue(30,forKey: "id")
            blackEyepatch.setValue(2,forKey:"categoryId")
            blackEyepatch.setValue(false, forKey: "isUnlocked")
            
            
            commonGrog.setValue("Common Grog", forKey: "name")
            commonGrog.setValue(31,forKey: "id")
            commonGrog.setValue(2,forKey:"categoryId")
            commonGrog.setValue(false, forKey: "isUnlocked")
            
            
            silverAncientPot.setValue("Silver Ancient Pot", forKey: "name")
            silverAncientPot.setValue(32,forKey: "id")
            silverAncientPot.setValue(2,forKey:"categoryId")
            silverAncientPot.setValue(false, forKey: "isUnlocked")
            
            
            treasureMapCommon.setValue("Treasure Map Common", forKey: "name")
            treasureMapCommon.setValue(33,forKey: "id")
            treasureMapCommon.setValue(2,forKey:"categoryId")
            treasureMapCommon.setValue(false, forKey: "isUnlocked")
            
            
            silverCompass.setValue("Silver Compass", forKey: "name")
            silverCompass.setValue(34,forKey: "id")
            silverCompass.setValue(2,forKey:"categoryId")
            silverCompass.setValue(false, forKey: "isUnlocked")
            
            captainsWheel.setValue("Captain's Wheel", forKey: "name")
            captainsWheel.setValue(35,forKey: "id")
            captainsWheel.setValue(2,forKey:"categoryId")
            captainsWheel.setValue(false, forKey: "isUnlocked")
            
            captainsGoldenWheel.setValue("Captain's Golden Wheel", forKey: "name")
            captainsGoldenWheel.setValue(36,forKey: "id")
            captainsGoldenWheel.setValue(2,forKey:"categoryId")
            captainsGoldenWheel.setValue(false, forKey: "isUnlocked")
            
            ancientClamShell.setValue("Ancient Clam Shell", forKey: "name")
            ancientClamShell.setValue(37,forKey: "id")
            ancientClamShell.setValue(2,forKey:"categoryId")
            ancientClamShell.setValue(false, forKey: "isUnlocked")
            
            messageInABottle.setValue("Message In A Bottle", forKey: "name")
            messageInABottle.setValue(38,forKey: "id")
            messageInABottle.setValue(2,forKey:"categoryId")
            messageInABottle.setValue(false, forKey: "isUnlocked")
            
            seadogsSpyGlass.setValue("SeaDog's Spyglass", forKey: "name")
            seadogsSpyGlass.setValue(39,forKey: "id")
            seadogsSpyGlass.setValue(2,forKey:"categoryId")
            seadogsSpyGlass.setValue(false, forKey: "isUnlocked")
            
            seadogsGoldSpyGlass.setValue("SeaDog's Gold Spyglass", forKey: "name")
            seadogsGoldSpyGlass.setValue(40,forKey: "id")
            seadogsGoldSpyGlass.setValue(2,forKey:"categoryId")
            seadogsGoldSpyGlass.setValue(false, forKey: "isUnlocked")
            
            treasureMapRare.setValue("Treasure Map Rare", forKey: "name")
            treasureMapRare.setValue(41,forKey: "id")
            treasureMapRare.setValue(2,forKey:"categoryId")
            treasureMapRare.setValue(false, forKey: "isUnlocked")
            
            fishingLure2.setValue("Fishing Lure Blue", forKey: "name")
            fishingLure2.setValue(42,forKey: "id")
            fishingLure2.setValue(2,forKey:"categoryId")
            fishingLure2.setValue(false, forKey: "isUnlocked")
            
            oldMansCutlass.setValue("Old Man's Cutlass", forKey: "name")
            oldMansCutlass.setValue(43,forKey: "id")
            oldMansCutlass.setValue(2,forKey:"categoryId")
            oldMansCutlass.setValue(false, forKey: "isUnlocked")
            
            noMansFlag.setValue("No Man's Flag", forKey: "name")
            noMansFlag.setValue(44,forKey: "id")
            noMansFlag.setValue(2,forKey:"categoryId")
            noMansFlag.setValue(false, forKey: "isUnlocked")
            
           
            
            purpleSkullFlag.setValue("Purple Skull Flag", forKey: "name")
            purpleSkullFlag.setValue(45,forKey: "id")
            purpleSkullFlag.setValue(2,forKey:"categoryId")
            purpleSkullFlag.setValue(false, forKey: "isUnlocked")
            
            redLantern.setValue("Red Lantern", forKey: "name")
            redLantern.setValue(46,forKey: "id")
            redLantern.setValue(2,forKey:"categoryId")
            redLantern.setValue(false, forKey: "isUnlocked")
            
            seaUrchantPurple.setValue("Red Lantern", forKey: "name")
            seaUrchantPurple.setValue(47,forKey: "id")
            seaUrchantPurple.setValue(2,forKey:"categoryId")
            seaUrchantPurple.setValue(false, forKey: "isUnlocked")
            
            silverAnchor.setValue("Silver Anchor", forKey: "name")
            silverAnchor.setValue(48,forKey: "id")
            silverAnchor.setValue(2,forKey:"categoryId")
            silverAnchor.setValue(false, forKey: "isUnlocked")
            
            deepSeaBall.setValue("Deep Sea Ball", forKey: "name")
            deepSeaBall.setValue(49,forKey: "id")
            deepSeaBall.setValue(2,forKey:"categoryId")
            deepSeaBall.setValue(false, forKey: "isUnlocked")
            
            deepSeaEmeraldBall.setValue("Deep Sea Emerald Ball", forKey: "name")
            deepSeaEmeraldBall.setValue(50,forKey: "id")
            deepSeaEmeraldBall.setValue(2,forKey:"categoryId")
            deepSeaEmeraldBall.setValue(false, forKey: "isUnlocked")
            
            deepSeaRubyBall.setValue("Deep Sea Ruby Ball", forKey: "name")
            deepSeaRubyBall.setValue(51,forKey: "id")
            deepSeaRubyBall.setValue(2,forKey:"categoryId")
            deepSeaRubyBall.setValue(false, forKey: "isUnlocked")
            
            atlantisStarfish.setValue("Atlantis Starfish", forKey: "name")
            atlantisStarfish.setValue(52,forKey: "id")
            atlantisStarfish.setValue(3,forKey:"categoryId")
            atlantisStarfish.setValue(false, forKey: "isUnlocked")
            
            goldCompass.setValue("Gold Compass", forKey: "name")
            goldCompass.setValue(53,forKey: "id")
            goldCompass.setValue(3,forKey:"categoryId")
            goldCompass.setValue(false, forKey: "isUnlocked")
            
            
            skullEyepatch.setValue("Skull Eyepatch", forKey: "name")
            skullEyepatch.setValue(54,forKey: "id")
            skullEyepatch.setValue(3,forKey:"categoryId")
            skullEyepatch.setValue(false, forKey: "isUnlocked")
            
            
            blueBeardsPotion.setValue("BlueBeard's Potion", forKey: "name")
            blueBeardsPotion.setValue(55,forKey: "id")
            blueBeardsPotion.setValue(3,forKey:"categoryId")
            blueBeardsPotion.setValue(false, forKey: "isUnlocked")
            
            redBeardsPotion.setValue("RedBeard's Potion", forKey: "name")
            redBeardsPotion.setValue(56,forKey: "id")
            redBeardsPotion.setValue(3,forKey:"categoryId")
            redBeardsPotion.setValue(false, forKey: "isUnlocked")
            
            silverGoblet.setValue("Silver Goblet", forKey: "name")
            silverGoblet.setValue(57,forKey: "id")
            silverGoblet.setValue(3,forKey:"categoryId")
            silverGoblet.setValue(false, forKey: "isUnlocked")
            
            clam.setValue("Clam", forKey: "name")
            clam.setValue(58,forKey: "id")
            clam.setValue(3,forKey:"categoryId")
            clam.setValue(false, forKey: "isUnlocked")
            
            seaUrchant.setValue("Sea Urchant", forKey: "name")
            seaUrchant.setValue(59,forKey: "id")
            seaUrchant.setValue(3,forKey:"categoryId")
            seaUrchant.setValue(false, forKey: "isUnlocked")
            
            anchor.setValue("Anchor", forKey: "name")
            anchor.setValue(60,forKey: "id")
            anchor.setValue(3,forKey:"categoryId")
            anchor.setValue(false, forKey: "isUnlocked")
            
            rareHook.setValue("Rare Hook", forKey: "name")
            rareHook.setValue(61,forKey: "id")
            rareHook.setValue(3,forKey:"categoryId")
            rareHook.setValue(false, forKey: "isUnlocked")
            
            marianasRubyTreasure.setValue("Mariana's Ruby Treasure", forKey: "name")
            marianasRubyTreasure.setValue(62,forKey: "id")
            marianasRubyTreasure.setValue(3,forKey:"categoryId")
            marianasRubyTreasure.setValue(false, forKey: "isUnlocked")
            
            marianasEmeraldTreasure.setValue("Mariana's Emerald Treasure", forKey: "name")
            marianasEmeraldTreasure.setValue(63,forKey: "id")
            marianasEmeraldTreasure.setValue(3,forKey:"categoryId")
            marianasEmeraldTreasure.setValue(false, forKey: "isUnlocked")
            
            marianasAncientTreasure.setValue("Mariana's Ancient Treasure", forKey: "name")
            marianasAncientTreasure.setValue(64,forKey: "id")
            marianasAncientTreasure.setValue(3,forKey:"categoryId")
            marianasAncientTreasure.setValue(false, forKey: "isUnlocked")
            
            rareGrog.setValue("Rare Grog", forKey: "name")
            rareGrog.setValue(65,forKey: "id")
            rareGrog.setValue(3,forKey:"categoryId")
            rareGrog.setValue(false, forKey: "isUnlocked")
            
            goldenSeaUrchant.setValue("Golden Sea Urchant", forKey: "name")
            goldenSeaUrchant.setValue(66,forKey: "id")
            goldenSeaUrchant.setValue(3,forKey:"categoryId")
            goldenSeaUrchant.setValue(false, forKey: "isUnlocked")
            
            waxSealedMessage.setValue("Wax Sealed Message", forKey: "name")
            waxSealedMessage.setValue(67,forKey: "id")
            waxSealedMessage.setValue(3,forKey:"categoryId")
            waxSealedMessage.setValue(false, forKey: "isUnlocked")
            
            purpleCoral.setValue("Purple Coral", forKey: "name")
            purpleCoral.setValue(68,forKey: "id")
            purpleCoral.setValue(3,forKey:"categoryId")
            purpleCoral.setValue(false, forKey: "isUnlocked")
            
            aquaCoral.setValue("Aqu Coral", forKey: "name")
            aquaCoral.setValue(69,forKey: "id")
            aquaCoral.setValue(3,forKey:"categoryId")
            aquaCoral.setValue(false, forKey: "isUnlocked")
            
            pearls.setValue("Pearls", forKey: "name")
            pearls.setValue(70,forKey: "id")
            pearls.setValue(3,forKey:"categoryId")
            pearls.setValue(false, forKey: "isUnlocked")
            
            blackPearls.setValue("Pearls", forKey: "name")
            blackPearls.setValue(71,forKey: "id")
            blackPearls.setValue(3,forKey:"categoryId")
            blackPearls.setValue(false, forKey: "isUnlocked")
            
            
            epicGrog.setValue("Epic Grog", forKey: "name")
            epicGrog.setValue(72,forKey: "id")
            epicGrog.setValue(3,forKey:"categoryId")
            epicGrog.setValue(false, forKey: "isUnlocked")
            
            herculesLostItem.setValue("Hercules Lost Item", forKey: "name")
            herculesLostItem.setValue(73,forKey: "id")
            herculesLostItem.setValue(3,forKey:"categoryId")
            herculesLostItem.setValue(false, forKey: "isUnlocked")
            
            
            goldenGoblet.setValue("Golden Goblet", forKey: "name")
            goldenGoblet.setValue(74,forKey: "id")
            goldenGoblet.setValue(3,forKey:"categoryId")
            goldenGoblet.setValue(false, forKey: "isUnlocked")
            
            goldAncientPot.setValue("Gold Ancient Pot", forKey: "name")
            goldAncientPot.setValue(75,forKey: "id")
            goldAncientPot.setValue(3,forKey:"categoryId")
            goldAncientPot.setValue(false, forKey: "isUnlocked")
            
            epicHook.setValue("Epic Hook", forKey: "name")
            epicHook.setValue(76,forKey: "id")
            epicHook.setValue(3,forKey:"categoryId")
            epicHook.setValue(false, forKey: "isUnlocked")
            
            rubyJewel.setValue("Ruby Jewel", forKey: "name")
            rubyJewel.setValue(77,forKey: "id")
            rubyJewel.setValue(3,forKey:"categoryId")
            rubyJewel.setValue(false, forKey: "isUnlocked")
            
            goldenAnchor.setValue("Epic Hook", forKey: "name")
            goldenAnchor.setValue(78,forKey: "id")
            goldenAnchor.setValue(3,forKey:"categoryId")
            goldenAnchor.setValue(false, forKey: "isUnlocked")
            
           

            do {
                try context.save()
                print("saved")
            } catch {
                // process error
            }
  
        }
        return true
    }

       func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.

        let date = NSDate().timeIntervalSince1970
        _ = UserDefaults.standard.double(forKey: "timeClosed")
        
        UserDefaults.standard.set(date, forKey: "timeClosed")
        
        _ = UserDefaults.standard.bool(forKey: "appClosed")
        UserDefaults.standard.set(true, forKey: "appClosed")
        let appClosed = UserDefaults.standard.bool(forKey: "appClosed")
        
}

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
      
        let date = NSDate().timeIntervalSince1970
        _ = UserDefaults.standard.double(forKey: "timeClosed")
        
        UserDefaults.standard.set(date, forKey: "timeClosed")
        
        _ = UserDefaults.standard.bool(forKey: "appClosed")
        UserDefaults.standard.set(true, forKey: "appClosed")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

        let foreground = UserDefaults.standard.bool(forKey: "appClosed")
//        _ = UserDefaults.standard.bool(forKey: "appClosed")
        
        UserDefaults.standard.set(false, forKey: "appClosed")
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        

//        _ = UserDefaults.standard.bool(forKey: "appClosed")
      
        UserDefaults.standard.set(false, forKey: "appClosed")
        
       
        
  
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "piratesApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

