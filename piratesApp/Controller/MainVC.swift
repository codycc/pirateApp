//
//  ViewController.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-10-17.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var plank1: UIImageView!
    @IBOutlet var plank2: UIImageView!
    @IBOutlet var leadingPlankConstraint: NSLayoutConstraint!
    @IBOutlet var pirateShipImg: UIImageView!
    @IBOutlet var parrotImg: UIImageView!
    @IBOutlet var walletLootLbl: UILabel!
    

    
    var pirates = [Pirate]()
    var sortedPirates = [Pirate]()
    var wallet = [Wallet]()
    
    var musicPlayer: AVAudioPlayer!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.alwaysBounceVertical = false
        let date = NSDate().timeIntervalSince1970
        print("DATE\(date)")
        
       
        let context = appDelegate.persistentContainer.viewContext
        
        let requestPirate = NSFetchRequest<NSFetchRequestResult>(entityName: "Pirate")
        let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
        
        requestPirate.returnsObjectsAsFaults = false
        requestWallet.returnsObjectsAsFaults = false
        
        NotificationCenter.default.addObserver(self, selector:#selector(MainVC.alertTimers), name:
            UIApplication.willEnterForegroundNotification, object: nil)
        
        //fetching Pirate Entity from CoreData
        do {
            let results = try context.fetch(requestPirate)
            if results.count > 0 {
                for result in results {
                    pirates.append(result as! Pirate)
                    print("\(result)animating")
                }
            }
        } catch {
            // handle error
        }
        
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
        
        updateWalletLoot()
        addParrotImagesForAnimation()
        addShipImagesForAnimation()
        animatePlanks()
        playMusic()
        sortPirates()
        startTimers()
      
        
    }
    
   
    
    @objc func alertTimers() {
        print("alert tIMERS CALLED")
        startTimers()
    }
    
    func updateWalletLoot() {
        walletLootLbl.text = "\(wallet[0].totalLootAmount)"
    }
    
    func addParrotImagesForAnimation() {
        var imgArray = [UIImage]()
        for x in 0...8 {
            let img = UIImage(named:"yellowParrot\(x)")
            imgArray.append(img!)
        }
        setParrotImages(imgArray: imgArray)
    }
    
    func setParrotImages(imgArray: Array<UIImage>) {
        parrotImg.animationImages = imgArray
        parrotImg.animationDuration = 1.0
        parrotImg.animationRepeatCount = 0
        parrotImg.startAnimating()
    }
    
    func addShipImagesForAnimation() {
        var imgArray = [UIImage]()
        for x in 0...24 {
            let img = UIImage(named:"whiteShip\(x)")
            imgArray.append(img!)
        }
        setShipImages(imgArray: imgArray)
    }
    
    func setShipImages(imgArray: Array<UIImage>) {
        pirateShipImg.animationImages = imgArray
        pirateShipImg.animationDuration = 3.0
        pirateShipImg.animationRepeatCount = 0
        pirateShipImg.startAnimating()
    }
    
    func animatePlanks() {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 4, animations: {
            self.plank1.center.x += 100
            
        }, completion: nil)
        
        UIView.animate(withDuration: 2, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 4, animations: {
             self.plank2.center.x += 100
        }, completion: nil)
    }
    
    func playMusic() {
        let path = Bundle.main.path(forResource: "piratesmusic", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func sortPirates() {
        sortedPirates = pirates.sorted(by: { $0.id < $1.id})
    }
    
    func startTimers() {
        for pirate in sortedPirates {
            if pirate.isAnimating == true {
                grabPirateOfflineData(pirate: pirate)
                var timer = Timer()
                timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
  
            }
        }
    }
    
    func grabPirateOfflineData(pirate: Pirate) {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore {
            let date = NSDate().timeIntervalSince1970
            let time = UserDefaults.standard.double(forKey: "timeClosed")
            
            let timeSince = date - time
            let timeSinceInMilliseconds = timeSince * 1000
            
            let currentTime = (timeSinceInMilliseconds / Double(pirate.lootTime))
            
            let wholeNumber = floor(currentTime)
            // let decimalNumber = wholeNumber.truncatingRemainder(dividingBy: 1)
            print("\(pirate.lootAmount)")
            print("\(wholeNumber)")
            let amountOfMoneyMade = pirate.lootAmount * Int32(wholeNumber)
            
            let context = appDelegate.persistentContainer.viewContext
            wallet[0].totalLootAmount += amountOfMoneyMade
            updateWalletLoot()
            
            do {
                try context.save()
            } catch {
                // handle error
            }
            
            print("\(amountOfMoneyMade) amount of money made")
        } else {
            
        }
      
    }
    
    @objc func updateCoreDataFromTimer(timer: Timer) {
        let pirate = timer.userInfo as! Pirate
        
        
        let context = appDelegate.persistentContainer.viewContext
        pirate.currentTime = pirate.currentTime - 10
        print("\(pirate.currentTime)")
        
//        if pirate.currentTime >= 3000 {
//            pirate.isPirateRight = true
//        }
        
        if pirate.currentTime == 0.0 {
            wallet[0].totalLootAmount += pirate.lootAmount
            pirate.currentTime = pirate.lootTime
            updateWalletLoot()
        }
        
        do {
           try context.save()
            //print("\(pirate.currentTime)current")
        } catch {
            //handle error 
        }
        
        let indexPath = IndexPath(row: Int(pirate.id), section: 0)
        print("\(indexPath)INDEXPATH")
        tableView.reloadRows(at: [indexPath], with: .none)
        
        if UserDefaults.standard.bool(forKey: "appClosed") == true {
            timer.invalidate()
        } 
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("pirate count\(sortedPirates.count)")
        return sortedPirates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pirate = sortedPirates[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PirateCell") as? PirateCell {
            cell.configureCell(pirate: pirate)
            
            return cell
        } else {
            return PirateCell()
        }
    }
    
    
    
    @IBAction func pirateBtnPressed(_ sender: Any) {
        
        let context = appDelegate.persistentContainer.viewContext
        guard let cell = (sender as AnyObject).superview?.superview as? PirateCell else {
            return // or fatalError() or whatever
        }
        
        
        
        let indexPath = tableView.indexPath(for: cell)
        let pirate = sortedPirates[(indexPath?.row)!]
        if pirate.isUnlocked && !pirate.isAnimating  {
            do {
                pirate.setValue(true, forKey: "isAnimating")
                pirate.setValue(true, forKey: "isPirateRight")
                try context.save()
                var timer = Timer()
                timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)

  
            } catch {
                //handle error
            }
            
            print("here is pirate\(pirate)")
        }
     

    }
    
}


