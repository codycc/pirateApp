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
    var shopPlayer: AVAudioPlayer!
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
    
    @IBOutlet var adView: GADBannerView!
    @IBOutlet var offlineLootView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.estimatedRowHeight = 0;
        tableView.bounces = false
        tableView.alwaysBounceVertical = false
        
        adView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        adView.rootViewController = self
        adView.load(GADRequest())
        adView.delegate = self
        
        let date = NSDate().timeIntervalSince1970
        let context = appDelegate.persistentContainer.viewContext
        let requestPirate = NSFetchRequest<NSFetchRequestResult>(entityName: "Pirate")
        let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
        let requestUser = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        
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
        checkForUserStoreItems()
        checkIfAllPiratesAreFilled()
        checkWhatItemsToDisplay()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showIfUserIsOnFirstUse()
        showOfflineView()
    }

    @objc func alertTimers() {
        print("alertTimersCalled")
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
    
    func updateWalletLoot() {
        var string = ""
        var walletAmount = wallet[0].totalLootAmount
        
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
        gemsImg.stopAnimating()
        gemsImg.animation = "pop"
        gemsImg.animate()
    }
    
    @objc func setLootChest() {
        lootImg.stopAnimating()
        lootImg.animation = "morph"
        lootImg.animate()
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
    
    func checkWhatItemsToDisplay() {
        if users[0].hasSeagull {
            var imgArray = [UIImage]()
            imgArray = []
            for x in 1...19 {
                let img = UIImage(named:"seagull\(x)")
                imgArray.append(img!)
            }
            
            seagullImage.stopAnimating()
            seagullImage.animationImages = imgArray
            seagullImage.animationDuration = 5.0
            seagullImage.animationRepeatCount = 0
            seagullImage.startAnimating()
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
            var imgArray = [UIImage]()
            imgArray = []
            for x in 0...11 {
                let img = UIImage(named:"pelican\(x)")
                imgArray.append(img!)
            }
            
            pelicanImage.stopAnimating()
            pelicanImage.animationImages = imgArray
            pelicanImage.animationDuration = 0.7
            pelicanImage.animationRepeatCount = 0
            pelicanImage.startAnimating()
            
            
            
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
            var imgArray = [UIImage]()
            imgArray = []
            for x in 0...19 {
                let img = UIImage(named:"koala\(x)")
                imgArray.append(img!)
            }
            
            koalaImage.stopAnimating()
            koalaImage.animationImages = imgArray
            koalaImage.animationDuration = 5.0
            koalaImage.animationRepeatCount = 0
            koalaImage.startAnimating()
            self.koalaImage.isHidden = false
        }
        
        if users[0].hasShip {
        
        }
        
        
    }
    
    func checkForUserStoreItems() {
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
    
    func checkIfAllPiratesAreFilled() {
        var count = 0
        for pirate in sortedPirates {
            if pirate.numberOfPirates >= 100 {
                count += 1
            }
            if count >= 12 {
               let vc = IntroOutroVC()
                present(vc, animated: true, completion: nil)
            }
        }
    }
    
    
    func showIfUserIsOnFirstUse() {
        let isFirstUse = UserDefaults.standard.bool(forKey: "isFirstUse")
        if isFirstUse {
            performSegue(withIdentifier: "goToIntroOutroVC", sender: nil)
        }
    }
    
    func showOfflineView() {
        let launchedOffline = UserDefaults.standard.bool(forKey: "launchedOffline")
        if !launchedOffline {
            performSegue(withIdentifier: "goToOfflineVC", sender: nil)
            
        }
        
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
        changeShipColor = !changeShipColor
        
        if changeShipColor {
            for x in 0...24 {
                let img = UIImage(named:"shipRightBlack\(x)")
                shipArray.append(img!)
            }
        } else {
            for x in 0...24 {
                let img = UIImage(named:"shipRight\(x)")
                shipArray.append(img!)
            }
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
    
    func sortPirates() {
        sortedPirates = pirates.sorted(by: { $0.id < $1.id})
    }
    
    func startTimers() {
        for pirate in sortedPirates {
            if pirate.isAnimating {
                grabPirateOfflineData(pirate: pirate)
                var timer = Timer()
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                
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
     
        let button = sender as! UIButton
        let index = button.tag
        let pirate = sortedPirates[index]
        
        self.pirateToSend = pirate
        
        performSegue(withIdentifier: "goToStatsVC", sender: nil)
        

    }

    
    @IBAction func parrotImgTapped(_ sender: Any) {
        playParrotSoundEffect()
        addExplosionImagesForAnimation()
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
        
        performSegue(withIdentifier: "goToStoreVC", sender: nil)
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
                    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
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
        
        checkIfAllPiratesAreFilled()
        
        let button = sender as! UIButton
        let index = button.tag
        
        
        
        let imageName = "singleLoot.png"
        let image = UIImage(named: imageName)
        
        guard let touch = event.allTouches?.first else { return }
        let point = touch.location(in: view)
        print ("point: \(point)")
        
        
        var imageView = UIImageView(image: image!)
        var imageView2 = UIImageView(image: image!)
        var imageView3 = UIImageView(image: image!)
        var imageView4 = UIImageView(image: image!)

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
        do {
            try context.save()
            updateWalletLoot()
            reloadTable()
            
        } catch {
            // handle error
        }
    }
    
    @IBAction func exitBtnBeggining(_ sender: Any) {
        playAhoySoundEffect()
        
    }
}


