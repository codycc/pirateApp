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
                                                    withAdUnitID: "ca-app-pub-3940256099942544/5224354917")

        
        if launchedBefore {
           UserDefaults.standard.set(false, forKey: "launchedOffline")
        } else {
            
            
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            UserDefaults.standard.set(true, forKey: "isFirstUse")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let context = appDelegate.persistentContainer.viewContext
            
            let skollywag = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let cutler = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let bandit = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let landlubber = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let roger = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let crook = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let bucaneer = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let thief = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let gunna = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let bluebeard = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let redbeard = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            let blackbeard = NSEntityDescription.insertNewObject(forEntityName: "Pirate", into: context)
            
            
            //set up wallet
            let wallet = NSEntityDescription.insertNewObject(forEntityName: "Wallet", into: context)
            
            wallet.setValue(0, forKey: "totalLootAmount")
            wallet.setValue(0, forKey: "totalGemsAmount")
            
            let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
            
            
            user.setValue(false, forKey: "hasKoala")
            user.setValue(false, forKey: "hasSeagull")
            user.setValue(false, forKey: "hasVulture")
            user.setValue(false, forKey: "hasCampFire")
            user.setValue(false, forKey: "hasShip")
            user.setValue(false, forKey: "hasPelican")
            
            skollywag.setValue(0, forKey: "id")
            skollywag.setValue("Scollywag", forKey: "name")
            skollywag.setValue(10, forKey: "lootTime")
            skollywag.setValue(25, forKey: "lootAmount")
            skollywag.setValue(1, forKey: "numberOfPirates")
            skollywag.setValue(true, forKey: "isAnimating")
            skollywag.setValue(false, forKey: "isUnlocked")
            skollywag.setValue(11, forKey: "numberOfImages")
            skollywag.setValue(1, forKey: "groundNumber")
            skollywag.setValue(1, forKey: "backgroundNumber")
            skollywag.setValue(1, forKey: "plankNumber")
            skollywag.setValue(6, forKey: "currentTime")
            skollywag.setValue(15, forKey: "numberOfImagesAttack")
            skollywag.setValue(50, forKey: "piratePrice")

            cutler.setValue(1, forKey: "id")
            cutler.setValue("Cutler", forKey: "name")
            cutler.setValue(12, forKey: "lootTime")
            cutler.setValue(100, forKey: "lootAmount")
            cutler.setValue(0, forKey: "numberOfPirates")
            cutler.setValue(true, forKey: "isAnimating")
            cutler.setValue(true, forKey: "isUnlocked")
            cutler.setValue(15, forKey: "numberOfImages")
            cutler.setValue(1, forKey: "groundNumber")
            cutler.setValue(2, forKey: "backgroundNumber")
            cutler.setValue(2, forKey: "plankNumber")
            cutler.setValue(12, forKey: "currentTime")
            cutler.setValue(15, forKey: "numberOfImagesAttack")
            cutler.setValue(200, forKey: "piratePrice")
            
            
            bandit.setValue(2, forKey: "id")
            bandit.setValue("Bandit", forKey: "name")
            bandit.setValue(18, forKey: "lootTime")
            bandit.setValue(200, forKey: "lootAmount")
            bandit.setValue(0, forKey: "numberOfPirates")
            bandit.setValue(true, forKey: "isAnimating")
            bandit.setValue(true, forKey: "isUnlocked")
            bandit.setValue(15, forKey: "numberOfImages")
            bandit.setValue(1, forKey: "groundNumber")
            bandit.setValue(1, forKey: "backgroundNumber")
            bandit.setValue(3, forKey: "plankNumber")
            bandit.setValue(12, forKey: "currentTime")
            bandit.setValue(15, forKey: "numberOfImagesAttack")
            bandit.setValue(1500, forKey: "piratePrice")
            
            landlubber.setValue(3, forKey: "id")
            landlubber.setValue("Landlubber", forKey: "name")
            landlubber.setValue(27, forKey: "lootTime")
            landlubber.setValue(400, forKey: "lootAmount")
            landlubber.setValue(0, forKey: "numberOfPirates")
            landlubber.setValue(true, forKey: "isAnimating")
            landlubber.setValue(true, forKey: "isUnlocked")
            landlubber.setValue(15, forKey: "numberOfImages")
            landlubber.setValue(1, forKey: "groundNumber")
            landlubber.setValue(2, forKey: "backgroundNumber")
            landlubber.setValue(4, forKey: "plankNumber")
            landlubber.setValue(12, forKey: "currentTime")
            landlubber.setValue(15, forKey: "numberOfImagesAttack")
            landlubber.setValue(2000, forKey: "piratePrice")
            
            roger.setValue(4, forKey: "id")
            roger.setValue("Roger", forKey: "name")
            roger.setValue(36, forKey: "lootTime")
            roger.setValue(500, forKey: "lootAmount")
            roger.setValue(0, forKey: "numberOfPirates")
            roger.setValue(true, forKey: "isAnimating")
            roger.setValue(true, forKey: "isUnlocked")
            roger.setValue(15, forKey: "numberOfImages")
            roger.setValue(2, forKey: "groundNumber")
            roger.setValue(1, forKey: "backgroundNumber")
            roger.setValue(5, forKey: "plankNumber")
            roger.setValue(12, forKey: "currentTime")
            roger.setValue(11, forKey: "numberOfImagesAttack")
            roger.setValue(2500, forKey: "piratePrice")
            
            crook.setValue(5, forKey: "id")
            crook.setValue("Crook", forKey: "name")
            crook.setValue(45, forKey: "lootTime")
            crook.setValue(600, forKey: "lootAmount")
            crook.setValue(0, forKey: "numberOfPirates")
            crook.setValue(true, forKey: "isAnimating")
            crook.setValue(true, forKey: "isUnlocked")
            crook.setValue(15, forKey: "numberOfImages")
            crook.setValue(2, forKey: "groundNumber")
            crook.setValue(2, forKey: "backgroundNumber")
            crook.setValue(1, forKey: "plankNumber")
            crook.setValue(12, forKey: "currentTime")
            crook.setValue(11, forKey: "numberOfImagesAttack")
            crook.setValue(3000, forKey: "piratePrice")

            bucaneer.setValue(6, forKey: "id")
            bucaneer.setValue("Buccaneer", forKey: "name")
            bucaneer.setValue(54, forKey: "lootTime")
            bucaneer.setValue(700, forKey: "lootAmount")
            bucaneer.setValue(0, forKey: "numberOfPirates")
            bucaneer.setValue(true, forKey: "isAnimating")
            bucaneer.setValue(true, forKey: "isUnlocked")
            bucaneer.setValue(11, forKey: "numberOfImages")
            bucaneer.setValue(2, forKey: "groundNumber")
            bucaneer.setValue(1, forKey: "backgroundNumber")
            bucaneer.setValue(2, forKey: "plankNumber")
            bucaneer.setValue(18, forKey: "currentTime")
            bucaneer.setValue(15, forKey: "numberOfImagesAttack")
            bucaneer.setValue(3500, forKey: "piratePrice")

            
            thief.setValue(7, forKey: "id")
            thief.setValue("Thief", forKey: "name")
            thief.setValue(63, forKey: "lootTime")
            thief.setValue(800, forKey: "lootAmount")
            thief.setValue(0, forKey: "numberOfPirates")
            thief.setValue(true, forKey: "isAnimating")
            thief.setValue(true, forKey: "isUnlocked")
            thief.setValue(11, forKey: "numberOfImages")
            thief.setValue(2, forKey: "groundNumber")
            thief.setValue(2, forKey: "backgroundNumber")
            thief.setValue(3, forKey: "plankNumber")
            thief.setValue(27, forKey: "currentTime")
            thief.setValue(15, forKey: "numberOfImagesAttack")
            thief.setValue(4000, forKey: "piratePrice")

            
            gunna.setValue(8, forKey: "id")
            gunna.setValue("Gunna", forKey: "name")
            gunna.setValue(72, forKey: "lootTime")
            gunna.setValue(900, forKey: "lootAmount")
            gunna.setValue(0, forKey: "numberOfPirates")
            gunna.setValue(true, forKey: "isAnimating")
            gunna.setValue(true, forKey: "isUnlocked")
            gunna.setValue(11, forKey: "numberOfImages")
            gunna.setValue(3, forKey: "groundNumber")
            gunna.setValue(1, forKey: "backgroundNumber")
            gunna.setValue(4, forKey: "plankNumber")
            gunna.setValue(36, forKey: "currentTime")
            gunna.setValue(15, forKey: "numberOfImagesAttack")
            gunna.setValue(4500, forKey: "piratePrice")

            
            bluebeard.setValue(9, forKey: "id")
            bluebeard.setValue("Bluebeard", forKey: "name")
            bluebeard.setValue(81, forKey: "lootTime")
            bluebeard.setValue(950, forKey: "lootAmount")
            bluebeard.setValue(0, forKey: "numberOfPirates")
            bluebeard.setValue(true, forKey: "isAnimating")
            bluebeard.setValue(true, forKey: "isUnlocked")
            bluebeard.setValue(24, forKey: "numberOfImages")
            bluebeard.setValue(3, forKey: "groundNumber")
            bluebeard.setValue(2, forKey: "backgroundNumber")
            bluebeard.setValue(5, forKey: "plankNumber")
            bluebeard.setValue(45, forKey: "currentTime")
            bluebeard.setValue(14, forKey: "numberOfImagesAttack")
            bluebeard.setValue(5000, forKey: "piratePrice")

            
            redbeard.setValue(10, forKey: "id")
            redbeard.setValue("Redbeard", forKey: "name")
            redbeard.setValue(90, forKey: "lootTime")
            redbeard.setValue(1000, forKey: "lootAmount")
            redbeard.setValue(0, forKey: "numberOfPirates")
            redbeard.setValue(true, forKey: "isAnimating")
            redbeard.setValue(true, forKey: "isUnlocked")
            redbeard.setValue(24, forKey: "numberOfImages")
            redbeard.setValue(3, forKey: "groundNumber")
            redbeard.setValue(1, forKey: "backgroundNumber")
            redbeard.setValue(1, forKey: "plankNumber")
            redbeard.setValue(54, forKey: "currentTime")
            redbeard.setValue(14, forKey: "numberOfImagesAttack")
            redbeard.setValue(5500, forKey: "piratePrice")

            
            blackbeard.setValue(11, forKey: "id")
            blackbeard.setValue("Blackbeard", forKey: "name")
            blackbeard.setValue(99, forKey: "lootTime")
            blackbeard.setValue(1250, forKey: "lootAmount")
            blackbeard.setValue(0, forKey: "numberOfPirates")
            blackbeard.setValue(true, forKey: "isAnimating")
            blackbeard.setValue(true, forKey: "isUnlocked")
            blackbeard.setValue(24, forKey: "numberOfImages")
            blackbeard.setValue(3, forKey: "groundNumber")
            blackbeard.setValue(2, forKey: "backgroundNumber")
            blackbeard.setValue(1, forKey: "plankNumber")
            blackbeard.setValue(63, forKey: "currentTime")
            blackbeard.setValue(14, forKey: "numberOfImagesAttack")
            blackbeard.setValue(6000, forKey: "piratePrice")

            
            
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
        print("WILL RESIGN ACTIVE\(appClosed) is app closes?")
    
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
        print("enter foreground\(foreground)is app closed")
//        _ = UserDefaults.standard.bool(forKey: "appClosed")
        UserDefaults.standard.set(false, forKey: "appClosed")
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        let date = NSDate().timeIntervalSince1970
        let time = UserDefaults.standard.double(forKey: "timeClosed")

        print("enter foreground")
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

