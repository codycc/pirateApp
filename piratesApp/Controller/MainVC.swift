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
import Spring

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var pirateShipImg: UIImageView!
    @IBOutlet var parrotImg: UIImageView!
    @IBOutlet var walletLootLbl: UILabel!
    @IBOutlet var lootImg: SpringImageView!
    @IBOutlet var gemsImg: SpringImageView!
    
    var pirates = [Pirate]()
    var sortedPirates = [Pirate]()
    var wallet = [Wallet]()
    var cellHeights: [IndexPath : CGFloat] = [:]

    var musicPlayer: AVAudioPlayer!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.alwaysBounceVertical = false
        let date = NSDate().timeIntervalSince1970

        let context = appDelegate.persistentContainer.viewContext
        
        let requestPirate = NSFetchRequest<NSFetchRequestResult>(entityName: "Pirate")
        let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
        
        requestPirate.returnsObjectsAsFaults = false
        requestWallet.returnsObjectsAsFaults = false
        
        self.tableView.estimatedRowHeight = 0;
        
       
        
        NotificationCenter.default.addObserver(self, selector:#selector(MainVC.alertTimers), name:
            UIApplication.willEnterForegroundNotification, object: nil)
        
        //fetching Pirate Entity from CoreData
        do {
            let results = try context.fetch(requestPirate)
            if results.count > 0 {
                for result in results {
                    pirates.append(result as! Pirate)
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
        playMusic()
        sortPirates()
        startTimers()
        startAnimationTimers()
        
    }

    @objc func alertTimers() {
        print("alert tIMERS CALLED")
        startTimers()
    }
    
     func startAnimationTimers() {
        var chestTimer = Timer()
        chestTimer = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(MainVC.setLootChest), userInfo: nil, repeats: true)
        var gemsTimer = Timer()
        gemsTimer = Timer.scheduledTimer(timeInterval: 11, target: self, selector: #selector(MainVC.setGems), userInfo: nil, repeats: true)
    }
    
    func updateWalletLoot() {
        walletLootLbl.text = "\(wallet[0].totalLootAmount)"
        reloadTable()
    }
    
    @objc func setGems() {
        gemsImg.animation = "pop"
        gemsImg.animate()
    }
    
    @objc func setLootChest() {
        lootImg.animation = "morph"
        lootImg.animate()
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func addParrotImagesForAnimation() {
        var imgArray = [UIImage]()
        for x in 0...8 {
            let img = UIImage(named:"parrotLeft\(x)")
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
            let img = UIImage(named:"shipRight\(x)")
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
    
    // replace pirateship with pirates when clicked
    func addImagesForAnimation(pirate: Pirate) {
        pirateShipImg.stopAnimating()
        var imgArray = [UIImage]()
        for x in 0...pirate.numberOfImages {
            let img = UIImage(named:"pirate\(pirate.id)idle\(x)")
            imgArray.append(img!)
        }
        setShipImages(imgArray: imgArray)
    }
    
    func setImages(imgArray: Array<UIImage>) {
        pirateShipImg.animationImages = imgArray
        pirateShipImg.animationDuration = 3.0
        pirateShipImg.animationRepeatCount = 0
        pirateShipImg.startAnimating()
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
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
  
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
            let amountOfMoneyMade = pirate.lootAmount * Int32(wholeNumber)
            
            let context = appDelegate.persistentContainer.viewContext
            wallet[0].totalLootAmount += amountOfMoneyMade
            updateWalletLoot()
            
            do {
                try context.save()
            } catch {
                // handle error
            }
        } else {
            
        }
      
    }
    
    @objc func updateCoreDataFromTimer(timer: Timer) {
        let pirate = timer.userInfo as! Pirate
        
        
        let context = appDelegate.persistentContainer.viewContext
        pirate.currentTime = pirate.currentTime - 1000
        
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wallet = self.wallet[0]
        let pirate = sortedPirates[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PirateCell") as? PirateCell {
            cell.configureCell(pirate: pirate, wallet: wallet)
            
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
        
        //addImagesForAnimation(pirate: pirate)
        
        if pirate.isUnlocked && !pirate.isAnimating  {
            do {
                pirate.setValue(true, forKey: "isAnimating")
                try context.save()
                var timer = Timer()
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
            } catch {
                //handle error
            }
        }
    }
    
}


