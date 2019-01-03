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
import GoogleMobileAds

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate {
   
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pirateShipImg: UIImageView!
    @IBOutlet weak var parrotImg: UIImageView!
    @IBOutlet weak var walletLootLbl: UILabel!
    @IBOutlet weak var lootImg: SpringImageView!
    @IBOutlet weak var gemsImg: SpringImageView!
    @IBOutlet weak var explosionImg: UIImageView!
    @IBOutlet weak var shipExplosionImg: UIImageView!
    @IBOutlet weak var panDownView: UIView!
    @IBOutlet weak var editedRope2: UIImageView!
    @IBOutlet weak var editedRope1: UIImageView!
    @IBOutlet weak var slateGlassView: UIView!
    @IBOutlet weak var blackGlass: UIView!
    @IBOutlet weak var exitIcon: UIButton!
    @IBOutlet weak var pirateNameInfo: UILabel!

    @IBOutlet var shopLbl: UILabel!
    @IBOutlet var seagullImage: UIImageView!
    @IBOutlet var koalaImage: UIImageView!
    @IBOutlet var vultureImage: UIImageView!
    @IBOutlet var campFireImage: UIImageView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var prestigeLbl: UILabel!
    @IBOutlet weak var pelicanImage: UIImageView!
    
    var pirates = [Pirate]()
    var sortedPirates = [Pirate]()
    var wallet = [Wallet]()
    var users = [User]()
    var cellHeights: [IndexPath : CGFloat] = [:]
    
    

    var musicPlayer: AVAudioPlayer!
    var parrotPlayer: AVAudioPlayer!
    var shipPlayer: AVAudioPlayer!
    var purchasePlayer: AVAudioPlayer!
    var prestigePlayer: AVAudioPlayer!
    var shopPlayer: AVAudioPlayer!
    var timerPirate0 = Timer()
    var timerPirate1 = Timer()
    var timerPirate2 = Timer()
    var timerPirate3 = Timer()
    var timerPirate4 = Timer()
    var timerPirate5 = Timer()
    var timerPirate6 = Timer()
    var timerPirate7 = Timer()
    var timerPirate8 = Timer()
    var timerPirate9 = Timer()
    var timerPirate10 = Timer()
    var timerPirate11 = Timer()
    
    
    var timer2Pirate0 = Timer()
    var timer2Pirate1 = Timer()
    var timer2Pirate2 = Timer()
    var timer2Pirate3 = Timer()
    var timer2Pirate4 = Timer()
    var timer2Pirate5 = Timer()
    var timer2Pirate6 = Timer()
    var timer2Pirate7 = Timer()
    var timer2Pirate8 = Timer()
    var timer2Pirate9 = Timer()
    var timer2Pirate10 = Timer()
    var timer2Pirate11 = Timer()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var changeParrotColor = true
    var changeShipColor = true
    var amountOfMoneyMade = 0.0
    var explosionArray = [UIImage]()
    var shipExplosionArray = [UIImage]()
    var shipArray = [UIImage]()
    var pirateToSend: Pirate!
    let ahoyPath = Bundle.main.path(forResource: "ahoy", ofType: "wav")
    let parrotPath = Bundle.main.path(forResource: "pr3", ofType: "wav")
    let shopPath = Bundle.main.path(forResource: "shopNoise", ofType: "wav")
    let requestPirate = NSFetchRequest<NSFetchRequestResult>(entityName: "Pirate")
    let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
    let requestUser = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    
    
    @IBOutlet var adView: GADBannerView!
    @IBOutlet var offlineLootView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.estimatedRowHeight = 0;
        tableView.bounces = false
        tableView.alwaysBounceVertical = false
        
        
      
//        adView.adUnitID = "ca-app-pub-1067425139660844/7823755834"
        adView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        adView.rootViewController = self
        adView.load(GADRequest())
        adView.delegate = self
        
        
        self.parrotImg.isUserInteractionEnabled = true
        self.pirateShipImg.isUserInteractionEnabled = true
        self.shopLbl.isUserInteractionEnabled = true
        
        UserDefaults.standard.set(false, forKey: "appClosed")
        
        // tap gestures

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainVC.parrotImgTapped(_:)))
        self.parrotImg.addGestureRecognizer(tapGesture)

        let tapGestureShip = UITapGestureRecognizer(target: self, action: #selector(MainVC.shipImgTapped(_:)))
        self.pirateShipImg.addGestureRecognizer(tapGestureShip)
        
        
        let tapGestureShop = UITapGestureRecognizer(target: self, action: #selector(MainVC.shopLblTapped(_:)))
        self.shopLbl.addGestureRecognizer(tapGestureShop)
       
 
        requestPirate.returnsObjectsAsFaults = false
        requestWallet.returnsObjectsAsFaults = false
        requestUser.returnsObjectsAsFaults = false
        
        
        NotificationCenter.default.addObserver(self, selector:#selector(MainVC.alertTimers), name:
        UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkWhatItemsToDisplay), name: NSNotification.Name(rawValue: "checkNewItems"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateWalletLootNotification), name: NSNotification.Name(rawValue: "updateLoot"), object: nil)

        
        //fetching Pirate Entity from CoreData
     
        grabPirateData()
        grabWalletData()
        grabUserData()
        updateWalletLoot()
        updateGemAmount()
        addParrotImagesForAnimation()
        addShipImagesForAnimation()
        playMusic()
        sortPirates()
        startTimers()
        startAnimationTimers()
        checkForUserStoreItems()
        checkIfAllPiratesAreFilled()
        checkWhatItemsToDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableViewHeight.constant = self.view.frame.height * 0.35
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showIfUserIsOnFirstUse()
        showOfflineView()
        
        
    }

    @objc func alertTimers() {
        startTimers()
    }
    
    @objc func invalidateTimers() {
        UserDefaults.standard.set(true, forKey: "appClosed")
    }
    
     func startAnimationTimers() {
        var chestTimer = Timer()
        chestTimer = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(MainVC.setLootChest), userInfo: nil, repeats: true)
        var gemsTimer = Timer()
        gemsTimer = Timer.scheduledTimer(timeInterval: 11, target: self, selector: #selector(MainVC.setGems), userInfo: nil, repeats: true)
    }
    
    
    func grabUserData() {
         let context = appDelegate.persistentContainer.viewContext
        users = []
        do {
            let results = try context.fetch(requestUser)
            if results.count > 0 {
                for result in results {
                    users.append(result as! User)
                }
            }
        } catch {
            // handle error
        }
    }
    
    func grabWalletData() {
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
    
    func grabPirateData() {
         let context = appDelegate.persistentContainer.viewContext
        pirates = []
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
    }
    
    func updateGemAmount() {
        let gemAmount = wallet[0].totalGemsAmount
        prestigeLbl.text = "\(gemAmount)"
    }
    
    
    @objc func updateWalletLootNotification() {
        updateWalletLoot()
    }
    
    func updateWalletLoot() {
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
        
        walletLootLbl.text = string
        reloadTable()
    }
    
    @objc func setGems() {
        //gemsImg.stopAnimating()
     //   gemsImg.animation = "pop"
      //  gemsImg.animate()
    }
    
    @objc func setLootChest() {
        //lootImg.stopAnimating()
       // lootImg.animation = "morph"
       // lootImg.animate()
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    
    func addParrotImagesForAnimation() {
        var imgArray = [UIImage]()
        imgArray = []
        changeParrotColor = !changeParrotColor
        if changeParrotColor {
            for x in 0...11 {
                let img = UIImage(named:"redParrot\(x)")
                imgArray.append(img!)
            }
        } else {
            for x in 0...8 {
                let img = UIImage(named:"yellowParrot\(x)")
                imgArray.append(img!)
            }
        }
        
        
        setParrotImages(imgArray: imgArray)
    }
    
    @objc func checkWhatItemsToDisplay() {
        grabUserData()
        updateWalletLoot()
        if users[0].hasSeagull {
           self.seagullImage.isHidden = false
        }
        
        if users[0].hasCampFire {
            var imgArray = [UIImage]()
            imgArray = []
            for x in 1...6 {
                let img = UIImage(named:"campfire0\(x)")
                imgArray.append(img!)
            }
            
            campFireImage.stopAnimating()
            campFireImage.animationImages = imgArray
            campFireImage.animationDuration = 0.7
            campFireImage.animationRepeatCount = 0
            campFireImage.startAnimating()

            self.lootImg.isHidden = true
            self.gemsImg.isHidden = true 
            self.campFireImage.isHidden = false
        }
        
        if users[0].hasPelican {
            self.pelicanImage.isHidden = false
        }
        
        if users[0].hasVulture {
            var imgArray = [UIImage]()
            imgArray = []
            for x in 0...15 {
                let img = UIImage(named:"vulture\(x)")
                imgArray.append(img!)
            }
            
            vultureImage.stopAnimating()
            vultureImage.animationImages = imgArray
            vultureImage.animationDuration = 1.0
            vultureImage.animationRepeatCount = 0
            vultureImage.startAnimating()
            
            self.vultureImage.isHidden = false
        }
        
        if users[0].hasKoala {
            self.koalaImage.isHidden = false
        }
        
        if users[0].hasShip {
            shipArray = []
            for x in 0...24 {
                let img = UIImage(named:"shipRightBlack\(x)")
                shipArray.append(img!)
            }

            setShipImages()
        
        }
        
        
    }
    
    @objc func checkForUserStoreItems() {
        let user = users[0]
        if user.hasKoala {
            koalaImage.isHidden = false
        } else if user.hasSeagull {
            seagullImage.isHidden = false
        } else if user.hasVulture {
            vultureImage.isHidden = false
        } else if user.hasCampFire {
            campFireImage.isHidden = false
        }
        
    }
    
    func resetPirates() {

        let context = appDelegate.persistentContainer.viewContext
        
        for pirate in pirates {
            switch pirate.id {
            case 0:
                pirate.lootTime = 10
                pirate.lootAmount = 25
                pirate.numberOfPirates = 1
                pirate.isAnimating = true
                pirate.isUnlocked = true
                pirate.currentTime = 6
                pirate.piratePrice = 50
            case 1:
                pirate.lootTime = 12
                pirate.lootAmount = 100
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 12
                pirate.piratePrice = 200
            case 2:
                pirate.lootTime = 18
                pirate.lootAmount = 200
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 12
                pirate.piratePrice = 1500
            case 3:
                pirate.lootTime = 27
                pirate.lootAmount = 400
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 12
                pirate.piratePrice = 2000
            case 4:
                pirate.lootTime = 36
                pirate.lootAmount = 500
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 12
                pirate.piratePrice = 2500
            case 5:
                pirate.lootTime = 45
                pirate.lootAmount = 600
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 12
                pirate.piratePrice = 3000
            case 6:
                pirate.lootTime = 54
                pirate.lootAmount = 700
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 18
                pirate.piratePrice = 3500
            case 7:
                pirate.lootTime = 63
                pirate.lootAmount = 800
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 27
                pirate.piratePrice = 4000
            case 8:
                pirate.lootTime = 72
                pirate.lootAmount = 900
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 36
                pirate.piratePrice = 4500
            case 9:
                pirate.lootTime = 81
                pirate.lootAmount = 950
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 45
                pirate.piratePrice = 5000

            case 10:
                pirate.lootTime = 90
                pirate.lootAmount = 1000
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 54
                pirate.piratePrice = 5500

            case 11:
                pirate.lootTime = 99
                pirate.lootAmount = 1250
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 63
                pirate.piratePrice = 6000
            default:
                print("default")
            }
            
        }
        
        wallet[0].totalLootAmount = 0
    

        do {
            try context.save()
            print("saved")
        } catch {
            // process error
        }
        playPrestigeSoundEffect()
        tableView.reloadData()
        
    }
    func resetOtherTimers() {
        print("other timers tester")
        let date = NSDate().timeIntervalSince1970
        UserDefaults.standard.set(date, forKey: "timeClosed")
        UserDefaults.standard.set(true, forKey: "appClosed")
        
        ////
         UserDefaults.standard.set(false, forKey: "appClosed")
       
        
//        grabUserData()
//        updateWalletLoot()
//        updateGemAmount()
        

    }
    
//    func resetOfflineData() {
//        for pirate in pirates {
//            grabPirateOfflineData(pirate: pirate)
//        }
//    }
    func stopTimers() {
         timerPirate0.invalidate()
        
         timerPirate1.invalidate()
        
         timerPirate2.invalidate()
         timerPirate3.invalidate()
         timerPirate4.invalidate()
         timerPirate5.invalidate()
         timerPirate6.invalidate()
         timerPirate7.invalidate()
         timerPirate8.invalidate()
         timerPirate9.invalidate()
         timerPirate10.invalidate()
         timerPirate11.invalidate()
        timer2Pirate0.invalidate()
        timer2Pirate1.invalidate()
        timer2Pirate2.invalidate()
        timer2Pirate3.invalidate()
        timer2Pirate4.invalidate()
        timer2Pirate5.invalidate()
        timer2Pirate6.invalidate()
        timer2Pirate7.invalidate()
        timer2Pirate8.invalidate()
        timer2Pirate9.invalidate()
        timer2Pirate10.invalidate()
        timer2Pirate11.invalidate()
    }
    func checkIfAllPiratesAreFilled() {
        var count = 0
        for pirate in sortedPirates {
            if pirate.numberOfPirates >= 100 {
                count += 1
            }
           
        }
        if count >= 12 {
                wallet[0].totalGemsAmount += 1
                stopTimers()
                resetPirates()
                grabPirateData()
                sortPirates()
                resetOtherTimers()
                startTimers()
                updateGemAmount()
                grabWalletData()
        }
        
    }
    
    
    func showIfUserIsOnFirstUse() {
        
        let isFirstUse = UserDefaults.standard.bool(forKey: "isFirstUse")
        if isFirstUse {
            performSegue(withIdentifier: "goToIntroOutroVC", sender: nil)
        }
    }
    
    func showOfflineView() {
      performSegue(withIdentifier: "goToOfflineVC", sender: nil)
//        let launchedOffline = UserDefaults.standard.bool(forKey: "launchedOffline")
//        if !launchedOffline {
//
//
//        }
        
    }
    
    func setParrotImages(imgArray: Array<UIImage>) {
        parrotImg.stopAnimating()
        parrotImg.animationImages = imgArray
        parrotImg.animationDuration = 1.0
        parrotImg.animationRepeatCount = 0
        parrotImg.startAnimating()
    }
    
    func addShipImagesForAnimation() {
        shipArray = []
            for x in 0...24 {
                let img = UIImage(named:"shipRight\(x)")
                shipArray.append(img!)
            }
        
        
        setShipImages()
    }
    
    func setShipImages() {
        pirateShipImg.stopAnimating()
        pirateShipImg.animationImages = shipArray
        pirateShipImg.animationDuration = 3.0
        pirateShipImg.animationRepeatCount = 0
        pirateShipImg.startAnimating()
    }
    
    func addExplosionImagesForAnimation() {
        explosionArray = []
        for x in 1...14 {
            let img = UIImage(named:"smokeEffect\(x)")
            explosionArray.append(img!)
        }
        setExplosionImages()
    }
    
    func addShipExplosionImagesForAnimation() {
        shipExplosionArray = []
        for x in 1...14 {
            let img = UIImage(named:"smokeEffect\(x)")
            shipExplosionArray.append(img!)
        }
        setShipExplosionImages()
    }
    
   
    
    func setShipExplosionImages() {
        shipExplosionImg.stopAnimating()
        shipExplosionImg.isHidden = false
        shipExplosionImg.animationImages = shipExplosionArray
        shipExplosionImg.animationDuration = 0.5
        shipExplosionImg.animationRepeatCount = 1
        shipExplosionImg.startAnimating()
    }
    
    func setExplosionImages() {
        explosionImg.isHidden = false
        explosionImg.animationImages = explosionArray
        explosionImg.animationDuration = 0.5
        explosionImg.animationRepeatCount = 1
        explosionImg.startAnimating()
    }
    
    // replace pirateship with pirates when clicked
    func addImagesForAnimation(pirate: Pirate) {

    }
    
    func setImages(imgArray: Array<UIImage>) {
        pirateShipImg.stopAnimating()
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
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func playParrotSoundEffect() {
        let parrotSoundUrl = NSURL(fileURLWithPath: parrotPath!)
        do {
            try parrotPlayer = AVAudioPlayer(contentsOf: parrotSoundUrl as URL)
            parrotPlayer.prepareToPlay()
            parrotPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func playAhoySoundEffect() {
        let ahoySoundUrl = NSURL(fileURLWithPath: ahoyPath!)
        do {
            try shipPlayer = AVAudioPlayer(contentsOf: ahoySoundUrl as URL)
            shipPlayer.prepareToPlay()
            shipPlayer.volume = 0.4
            shipPlayer.play()
            
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
    
    
    func playPrestigeSoundEffect() {
        let path = Bundle.main.path(forResource: "prestige", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try prestigePlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            prestigePlayer.prepareToPlay()
            prestigePlayer.volume = 0.7
            prestigePlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func sortPirates() {
        sortedPirates = pirates.sorted(by: { $0.id < $1.id})
    }
    
    func startTimers() {
        for pirate in sortedPirates {
            if pirate.isAnimating {
                grabPirateOfflineData(pirate: pirate)
               
                switch pirate.id {
                case 0:
                    timerPirate0 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                case 1:
                    timerPirate1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                case 2:
                    timerPirate2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                case 3:
                    timerPirate3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                case 4:
                    timerPirate4 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                case 5:
                    timerPirate5 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                case 6:
                    timerPirate6 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                case 7:
                    timerPirate7 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                case 8:
                    timerPirate8 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                case 9:
                    timerPirate9 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                case 10:
                    timerPirate10 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                case 11:
                    timerPirate11 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                default:
                    print("default")
                }
//                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer, userInfo: pirate, repeats: true)
                
            }
            if pirate.id == 0 {
                updateFirstPirate(pirate: pirate)
            }
        }
        reloadTable()
    }
    
    func updateFirstPirate(pirate: Pirate) {
        let context = appDelegate.persistentContainer.viewContext
        pirate.isUnlocked = true
        do {
            try context.save()
        } catch {
            
        }
    }
    
    
    func grabPirateOfflineData(pirate: Pirate) {
        amountOfMoneyMade = 0.0
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore && pirate.isUnlocked && pirate.isAnimating {
            let date = NSDate().timeIntervalSince1970
            let time = UserDefaults.standard.double(forKey: "timeClosed")
            
            
            let timeSince = date - time
            let timeSinceInMilliseconds = timeSince 
            
            let currentTime = (timeSinceInMilliseconds / Double(pirate.lootTime  ))

            let wholeNumber = currentTime
             amountOfMoneyMade = pirate.lootAmount * wholeNumber

            let context = appDelegate.persistentContainer.viewContext
            wallet[0].totalLootAmount += amountOfMoneyMade
            
            if Double(pirate.currentTime) > timeSince {
                pirate.currentTime = pirate.currentTime - Int32(timeSince)
            } else {
                pirate.currentTime = Int32(timeSince) % pirate.currentTime
            }
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
        pirate.currentTime = pirate.currentTime - 1
        if pirate.currentTime <= 0 {
            wallet[0].totalLootAmount += pirate.lootAmount
            pirate.currentTime = pirate.lootTime
            updateWalletLoot()
        }
        
        do {
           try context.save()
        } catch {
            //handle error 
        }
        
        let indexPath = IndexPath(row: Int(pirate.id), section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
        
        if UserDefaults.standard.bool(forKey: "appClosed") == true {

            timer.invalidate()
        } 
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            cell.buyPlankBtn.tag = indexPath.row
            cell.pirateImgBtn.tag = indexPath.row
            cell.plankBtn.tag = indexPath.row
            
       
            
            return cell
        } else {
            return PirateCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight:CGFloat = 0.0
        
        if(indexPath.row < 0){
            rowHeight = 0.0
        }else{
            rowHeight = 124.0   
        }
        
        return rowHeight
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToStatsVC" {
            let destinationVC = segue.destination as! StatsVC
            destinationVC.pirate = self.pirateToSend
        } else if segue.identifier == "goToOfflineVC" {
            let destinationVC = segue.destination as! OfflineBonusVC
            destinationVC.amountOfMoneyMade = self.amountOfMoneyMade
        }
    }
    
    
    
    @IBAction func pirateBtnPressed(_ sender: Any) {
        playAhoySoundEffect()
        let button = sender as! UIButton
        let index = button.tag
        let pirate = sortedPirates[index]
        
        self.pirateToSend = pirate
        
        performSegue(withIdentifier: "goToStatsVC", sender: nil)
        

    }

    
    @IBAction func parrotImgTapped(_ sender: Any) {
        wallet[0].totalLootAmount += 2
        let context = appDelegate.persistentContainer.viewContext
        let location = parrotImg.center
        
        do {
            try context.save()
            updateWalletLoot()
            let imageName = "singleLoot.png"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: location.x , y: location.y , width: 30  , height: 30 )
            imageView.contentMode = .scaleAspectFit
            self.view.addSubview(imageView)
            UIView.animate(withDuration: 1.0, animations: {
                imageView.center.y -= 150
            }) { (finished) in
                let label = UILabel(frame: CGRect(x: location.x, y: location.y - 150, width: 100, height: 21))
                label.center = CGPoint(x: location.x, y: location.y - 150)
                label.textAlignment = .center
                label.font = UIFont(name: "Pirates Writers", size: 25)
                label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                label.text = "+ $2"
                 let randomInt = Int.random(in: 0..<3)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    switch randomInt {
                    case 0:
                        UIView.animate(withDuration: 0.3, animations: {
                            label.center.x += 10
                            label.center.y += 10
                        }, completion: { (finished) in
                            label.removeFromSuperview()
                        })
                    case 1:
                        UIView.animate(withDuration: 0.3, animations: {
                            label.center.x -= 10
                            label.center.y -= 10
                        }, completion: { (finished) in
                            label.removeFromSuperview()
                        })
                    case 2:
                        UIView.animate(withDuration: 0.3, animations: {
                            label.center.x += 10
                            label.center.y -= 10
                        }, completion: { (finished) in
                            label.removeFromSuperview()
                        })
                    default:
                        print("default")
                    }
                    
                }
                self.view.addSubview(label)
                imageView.removeFromSuperview()
            }
        } catch {
            
        }
        
        //playParrotSoundEffect()
        //addExplosionImagesForAnimation()
        addParrotImagesForAnimation()
        
    }
    
    @IBAction func shipImgTapped(_ sender: Any) {
//        playAhoySoundEffect()
//        addShipExplosionImagesForAnimation()
//        addShipImagesForAnimation()
    }
    
    
    @IBAction func shopLblTapped(_ sender: Any) {
        
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
        
        performSegue(withIdentifier: "goToSettingsVC", sender: nil)
    }

    @IBAction func unlockPiratePressed(_ sender: Any) {
        let context = appDelegate.persistentContainer.viewContext
        
        let button = sender as! UIButton
        let index = button.tag
        
        let pirate = sortedPirates[index]
        
        if pirate.piratePrice <= wallet[0].totalLootAmount && !pirate.isUnlocked {
            pirate.isUnlocked = true
            pirate.isAnimating = true
            pirate.numberOfPirates += 1
            wallet[0].totalLootAmount -= pirate.piratePrice
            
            
          
            do {
                try context.save()
                do {
                    pirate.setValue(true, forKey: "isAnimating")
                    try context.save()
                    var timer = Timer()
                    switch pirate.id {
                    case 0:
                        timer2Pirate0 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                    case 1:
                        timer2Pirate1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                        case 2:
                        timer2Pirate2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                        case 3:
                        timer2Pirate3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                        case 4:
                        timer2Pirate4 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                        case 5:
                        timer2Pirate5 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                        case 6:
                        timer2Pirate6 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                        case 7:
                        timer2Pirate7 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                        case 8:
                        timer2Pirate8 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                        case 9:
                        timer2Pirate9 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                        case 10:
                        timer2Pirate10 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                        case 11:
                        timer2Pirate11 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                    default:
                        print("default")
                    }
                    
                    
                    playPurchaseSoundEffect()
                    updateWalletLoot()
                    reloadTable()
                } catch {
                    //handle error
                }
            } catch {
                // handle error
            }

        } else {
            
        }
    }
    
    
    
    
    
    @IBAction func buyBtnPressed(_ sender: Any, forEvent event: UIEvent) {
       
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        
        let button = sender as! UIButton
        let index = button.tag
        
        
        
        let imageName = "singleLoot.png"
        let image = UIImage(named: imageName)
        
        guard let touch = event.allTouches?.first else { return }
        let point = touch.location(in: view)
        print ("point: \(point)")
        
        
        let imageView = UIImageView(image: image!)
        let imageView2 = UIImageView(image: image!)
        let imageView3 = UIImageView(image: image!)
        let imageView4 = UIImageView(image: image!)

        imageView.frame = CGRect(x: point.x, y: point.y, width: 30, height: 30)
        view.addSubview(imageView)
        
        imageView2.frame = CGRect(x: point.x, y: point.y, width: 30, height: 30)
        view.addSubview(imageView2)
        
        imageView3.frame = CGRect(x: point.x, y: point.y, width: 30, height: 30)
        view.addSubview(imageView3)
        
        imageView4.frame = CGRect(x: point.x, y: point.y, width: 30, height: 30)
        view.addSubview(imageView4)
        
        let lowerValue = -60
        let upperValue = -20
        
        
        let randomNum1 = arc4random_uniform(50) + 1;
        let randomNum2 = arc4random_uniform(50) + 1;
        let randomNum3 = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        let randomNum4 = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        let randomNum5 = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        let randomNum6 = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        let randomNum7 = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        let randomNum8 = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
        
        

        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn , animations: {
            imageView.transform = CGAffineTransform(translationX: CGFloat(randomNum1) , y: CGFloat(randomNum7) )
            imageView2.transform = CGAffineTransform(translationX: CGFloat(randomNum2), y: CGFloat(randomNum8) )
            imageView3.transform = CGAffineTransform(translationX: CGFloat(randomNum3), y: CGFloat(randomNum5))
            imageView4.transform = CGAffineTransform(translationX: CGFloat(randomNum4), y: CGFloat(randomNum6))
            
        }, completion: { finished in
            UIView.animate(withDuration: 0.3, animations: {
                imageView.alpha = 0
                imageView2.alpha = 0
                imageView3.alpha = 0
                imageView4.alpha = 0
                
            }, completion: { (finished) in
                imageView.removeFromSuperview()
                imageView2.removeFromSuperview()
                imageView3.removeFromSuperview()
                imageView4.removeFromSuperview()
            })
          
        })
        
        let pirate = sortedPirates[index]
        playPurchaseSoundEffect()
        checkIfAllPiratesAreFilled()
        
        pirate.numberOfPirates += 1
        wallet[0].totalLootAmount -= pirate.piratePrice
        pirate.piratePrice = (pirate.piratePrice + pirate.piratePrice / 20)
        pirate.lootTime += (pirate.lootTime / 10)
        pirate.lootAmount += (pirate.lootAmount / 15)
        checkIfAllPiratesAreFilled()
        do {
            try context.save()
            updateWalletLoot()
            //checkIfAllPiratesAreFilled()
            reloadTable()
            
        } catch {
            // handle error
        }
    }
    
    @IBAction func exitBtnBeggining(_ sender: Any) {
        playAhoySoundEffect()
        
    }
}


