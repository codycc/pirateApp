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

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate, GADRewardBasedVideoAdDelegate {
   
   
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
    @IBOutlet weak var informationStackView: UIStackView!
    
    @IBOutlet weak var exitBtnBeggining: UIButton!
    @IBOutlet weak var piratePanDownViewImage: NSLayoutConstraint!
    @IBOutlet weak var offlineNonAdLabel: UILabel!
    
    @IBOutlet weak var blueboardAd: UIImageView!
    @IBOutlet weak var offlineAdLabel: UILabel!
    //stackview elements for overlay
    @IBOutlet weak var pirateTotalLbl: UILabel!
    @IBOutlet weak var lootPerSessionLbl: UILabel!
    @IBOutlet weak var piratePriceLbl: UILabel!
    @IBOutlet weak var lootingTimeLbl: UILabel!
    @IBOutlet weak var pirateImageOverlay: UIImageView!
    
    @IBOutlet weak var gameBeatLabel: UILabel!
    @IBOutlet weak var gameBeatView: UIView!
    var pirates = [Pirate]()
    var sortedPirates = [Pirate]()
    var wallet = [Wallet]()
    var cellHeights: [IndexPath : CGFloat] = [:]

    var musicPlayer: AVAudioPlayer!
    var parrotPlayer: AVAudioPlayer!
    var shipPlayer: AVAudioPlayer!
    var purchasePlayer: AVAudioPlayer!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var changeParrotColor = true
    var changeShipColor = true
    var amountOfMoneyMade = 0.0
    var explosionArray = [UIImage]()
    var shipExplosionArray = [UIImage]()
    var shipArray = [UIImage]()
    
    let ahoyPath = Bundle.main.path(forResource: "ahoy", ofType: "wav")
    
    
    let parrotPath = Bundle.main.path(forResource: "pr3", ofType: "wav")
    var pirateImgArray = [UIImage]()
    
    @IBOutlet var adView: GADBannerView!
    @IBOutlet var offlineLootView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.estimatedRowHeight = 0;
        tableView.bounces = false
        tableView.alwaysBounceVertical = false
        
        adView.adUnitID = "ca-app-pub-1067425139660844/7823755834"
        adView.rootViewController = self
        adView.load(GADRequest())
        adView.delegate = self
        
        let date = NSDate().timeIntervalSince1970
        let context = appDelegate.persistentContainer.viewContext
        let requestPirate = NSFetchRequest<NSFetchRequestResult>(entityName: "Pirate")
        let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")

        self.parrotImg.isUserInteractionEnabled = true
        self.pirateShipImg.isUserInteractionEnabled = true
        
        UserDefaults.standard.set(false, forKey: "appClosed")
        
        // tap gestures

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainVC.parrotImgTapped(_:)))
        self.parrotImg.addGestureRecognizer(tapGesture)
        
        let tapGestureNonAd = UITapGestureRecognizer(target: self, action: #selector(MainVC.offlineNonAdLabelPressed(_:)))
        self.offlineNonAdLabel.addGestureRecognizer(tapGestureNonAd)
        
        let tapGestureAd = UITapGestureRecognizer(target: self, action: #selector(MainVC.offlineAdLabelPressed(_:)))
        self.offlineAdLabel.addGestureRecognizer(tapGestureAd)
        
        let tapGestureShip = UITapGestureRecognizer(target: self, action: #selector(MainVC.shipImgTapped(_:)))
        self.pirateShipImg.addGestureRecognizer(tapGestureShip)
        
        GADRewardBasedVideoAd.sharedInstance().delegate = self
      
        
        
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
        showOfflineView()
        checkIfAllPiratesAreFilled()
        showIfUserIsOnFirstUse()
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
        walletLootLbl.text = String(format: "$%.2f", wallet[0].totalLootAmount)
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
    
    func showIfUserIsOnFirstUse() {
            
            let isFirstUse = UserDefaults.standard.bool(forKey: "isFirstUse")
        
            if isFirstUse {
                self.gameBeatLabel.isHidden = false
                self.blackGlass.isHidden = false
                self.exitBtnBeggining.isHidden = false
                self.gameBeatLabel.text = "Ahoy Mate!, Welcome to Pirate Looter! The idle game where you can hire pirates! The goal is to get 100 of each pirate, Cheers!"
                
                UserDefaults.standard.set(false, forKey: "isFirstUse")
            }
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        self.blueboardAd.alpha = 1
        self.offlineAdLabel.alpha = 1
        self.offlineAdLabel.isUserInteractionEnabled = true
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
    
    func checkIfAllPiratesAreFilled() {
        var count = 0
        for pirate in sortedPirates {
            if pirate.numberOfPirates >= 100 {
                count += 1
            }
            if count >= 8 {
                self.gameBeatView.isHidden = false
                self.gameBeatLabel.isHidden = false
            }
        }
    }
    
    func showOfflineView() {
         let launchedOffline = UserDefaults.standard.bool(forKey: "launchedOffline")
         UserDefaults.standard.set(false, forKey: "launchedOffline")
        if launchedOffline {
            offlineLootView.isHidden = false
            offlineNonAdLabel.text = String(format: "$%.2f", amountOfMoneyMade)
            offlineAdLabel.text = String(format: "$%.2f", amountOfMoneyMade * 2)
        }
        UserDefaults.standard.set(true, forKey: "launchedOffline")
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
    
    func lowerPanDownView(pirate: Pirate) {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 4, animations: {
            self.blackGlass.isHidden = false
            

            self.panDownView.center.y += 380

        }, completion: { finished in
            self.informationStackView.isHidden = false
            self.informationStackView.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.informationStackView.alpha = 1
            }, completion: { finished in
                self.exitIcon.isHidden = false
            })
            let height = self.view.frame.size.height * 0.45
            self.informationStackView.translatesAutoresizingMaskIntoConstraints = false
            self.informationStackView.heightAnchor.constraint(equalToConstant: height).isActive = true
            
        })
        switch pirate.id {
        case 0:
            self.piratePanDownViewImage.constant = 0
        case 1:
            self.piratePanDownViewImage.constant = -60
        case 2:
            self.piratePanDownViewImage.constant = -110
        case 3:
            self.piratePanDownViewImage.constant = -80
        case 4:
            self.piratePanDownViewImage.constant = -10
        case 5:
            self.piratePanDownViewImage.constant = -10
        case 6:
            self.piratePanDownViewImage.constant = -10
        case 7:
            self.piratePanDownViewImage.constant = -10
        
            
        default:
            print("hello")
        }
        
        
        slateGlassView.isHidden = false
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        let context = appDelegate.persistentContainer.viewContext
        wallet[0].totalLootAmount += amountOfMoneyMade
        do {
            updateWalletLoot()
            try context.save()
            
        } catch {
            //handle error
        }
        
    }
    
    func updateStackViewInformation(pirate:Pirate) {
        let pirateLootTimeInSeconds = pirate.lootTime
        let hours = Int(pirateLootTimeInSeconds) / 3600
        let minutes = Int(pirateLootTimeInSeconds) / 60 % 60
        let seconds = Int(pirateLootTimeInSeconds) % 60
        
        self.pirateNameInfo.text = pirate.name
        self.pirateTotalLbl.text = "\(pirate.numberOfPirates)"
        self.lootPerSessionLbl.text = String(format: "$%.2f", pirate.lootAmount)
        self.piratePriceLbl.text = String(format: "$%.2f", pirate.piratePrice)
        
        self.lootingTimeLbl.text = String(format:"%02i:%02i:%02i", hours, minutes, seconds)

    }
    
    func updatePirateFightingImage(pirate: Pirate) {
        pirateImgArray = []
        pirateImageOverlay.stopAnimating()
        
        for x in 0...14 {
            let img = UIImage(named:"pirate\(pirate.id)attack\(x)")
            pirateImgArray.append(img!)
        }
        setPirateOverlayImage()
    }
    
    func setPirateOverlayImage() {
        pirateImageOverlay.stopAnimating()
        pirateImageOverlay.animationImages = pirateImgArray
        pirateImageOverlay.animationDuration = 1.3
        pirateImageOverlay.animationRepeatCount = 0
        pirateImageOverlay.startAnimating()
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
            let timeSinceInMilliseconds = timeSince * 1000
            
            let currentTime = (timeSinceInMilliseconds / Double(pirate.lootTime * 1000 ))

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
            //print("\(pirate.currentTime)current")
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
            rowHeight = 124.0    //or whatever you like
        }
        
        return rowHeight
    }
    
    func prepareForReuse() {
        self.pirateImageOverlay.stopAnimating()
       
    }
    
    
    
    @IBAction func pirateBtnPressed(_ sender: Any) {
     
        let button = sender as! UIButton
        let index = button.tag
        let pirate = sortedPirates[index]
        
        lowerPanDownView(pirate: pirate)
        updateStackViewInformation(pirate: pirate)
        updatePirateFightingImage(pirate: pirate)
        

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
    
    @IBAction func exitIconTapped(_ sender: Any) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 4, animations: {
            self.blackGlass.isHidden = true
            self.exitIcon.isHidden = true
            self.panDownView.center.y -= 380

            self.informationStackView.isHidden = true
        }, completion: { finished in
            let height = self.view.frame.size.height * 0.4
            self.informationStackView.translatesAutoresizingMaskIntoConstraints = false
            self.informationStackView.heightAnchor.constraint(equalToConstant: height).isActive = true
            
        })
        
        slateGlassView.isHidden = true
        
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
    
    @IBAction func buyBtnPressed(_ sender: Any) {
        let context = appDelegate.persistentContainer.viewContext
        
        checkIfAllPiratesAreFilled()
        
        let button = sender as! UIButton
        let index = button.tag

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
    
    @IBAction func offlineNonAdLabelPressed(_ sender: Any) {
        offlineLootView.isHidden = true
        playAhoySoundEffect()
    }
    
    @IBAction func offlineAdLabelPressed(_ sender: Any) {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
        offlineLootView.isHidden = true
        
        
    }
    
    @IBAction func exitBtnBeggining(_ sender: Any) {
        self.exitBtnBeggining.isHidden = true
        self.blackGlass.isHidden = true
        self.gameBeatLabel.isHidden = true
        playAhoySoundEffect()
        self.gameBeatLabel.text = "CONGRATS MATE! YOU HAVE JUST BEAT THE GAME! TO REPLAY, PLEASE REDOWNLOAD THE APP! CHEERS!"
    }
    
    
}


