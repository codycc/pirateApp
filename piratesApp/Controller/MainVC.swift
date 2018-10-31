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
    @IBOutlet var pirateShipImg: UIImageView!
    @IBOutlet var parrotImg: UIImageView!
    @IBOutlet var walletLootLbl: UILabel!
    @IBOutlet var lootImg: SpringImageView!
    @IBOutlet var gemsImg: SpringImageView!
    @IBOutlet var explosionImg: UIImageView!
    @IBOutlet var shipExplosionImg: UIImageView!
    @IBOutlet var panDownView: UIView!
    @IBOutlet var editedRope2: UIImageView!
    @IBOutlet var editedRope1: UIImageView!
    @IBOutlet var slateGlassView: UIView!
    @IBOutlet var blackGlass: UIView!
    @IBOutlet var exitIcon: UIButton!
    @IBOutlet var pirateNameInfo: UILabel!
    @IBOutlet var informationStackView: UIStackView!
    
    @IBOutlet var piratePanDownViewImage: NSLayoutConstraint!
    @IBOutlet var offlineNonAdLabel: UILabel!
    
    @IBOutlet var blueboardAd: UIImageView!
    @IBOutlet var offlineAdLabel: UILabel!
    //stackview elements for overlay
    @IBOutlet var pirateTotalLbl: UILabel!
    @IBOutlet var lootPerSessionLbl: UILabel!
    @IBOutlet var piratePriceLbl: UILabel!
    @IBOutlet var lootingTimeLbl: UILabel!
    @IBOutlet var pirateImageOverlay: UIImageView!
    
    @IBOutlet var gameBeatLabel: UILabel!
    @IBOutlet var gameBeatView: UIView!
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
    
    @IBOutlet var adView: GADBannerView!
    @IBOutlet var offlineLootView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.estimatedRowHeight = 0;
        tableView.bounces = false
        tableView.alwaysBounceVertical = false
        
        adView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adView.rootViewController = self
        adView.load(GADRequest())
        adView.delegate = self
        
        let date = NSDate().timeIntervalSince1970
        let context = appDelegate.persistentContainer.viewContext
        let requestPirate = NSFetchRequest<NSFetchRequestResult>(entityName: "Pirate")
        let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")

        self.parrotImg.isUserInteractionEnabled = true
        self.pirateShipImg.isUserInteractionEnabled = true
        
        
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
    }

    @objc func alertTimers() {
        startTimers()
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
    
    
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        self.blueboardAd.alpha = 1
        self.offlineAdLabel.alpha = 1
        self.offlineAdLabel.isUserInteractionEnabled = true
    }
    
    
    func addParrotImagesForAnimation() {
        var imgArray = [UIImage]()
        changeParrotColor = !changeParrotColor
        print("\(changeParrotColor)")
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
            if count == 8 {
                self.gameBeatView.isHidden = false
                self.gameBeatLabel.isHidden = false
            }
        }
    }
    
    func showOfflineView() {
         let launchedOffline = UserDefaults.standard.bool(forKey: "launchedOffline")
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
        var imgArray = [UIImage]()
        
        changeShipColor = !changeShipColor
        
        if changeShipColor {
            for x in 0...24 {
                let img = UIImage(named:"shipRightBlack\(x)")
                imgArray.append(img!)
            }
        } else {
            for x in 0...24 {
                let img = UIImage(named:"shipRight\(x)")
                imgArray.append(img!)
            }
        }
        
        setShipImages(imgArray: imgArray)
    }
    
    func setShipImages(imgArray: Array<UIImage>) {
        pirateShipImg.stopAnimating()
        pirateShipImg.animationImages = imgArray
        pirateShipImg.animationDuration = 3.0
        pirateShipImg.animationRepeatCount = 0
        pirateShipImg.startAnimating()
    }
    
    func addExplosionImagesForAnimation() {
        var imgArray = [UIImage]()
        for x in 1...14 {
            let img = UIImage(named:"smokeEffect\(x)")
            imgArray.append(img!)
        }
        setExplosionImages(imgArray: imgArray)
    }
    
    func addShipExplosionImagesForAnimation() {
        var imgArray = [UIImage]()
        for x in 1...14 {
            let img = UIImage(named:"smokeEffect\(x)")
            imgArray.append(img!)
        }
        setShipExplosionImages(imgArray: imgArray)
    }
    
   
    
    func setShipExplosionImages(imgArray: Array<UIImage>) {
        shipExplosionImg.isHidden = false
        shipExplosionImg.animationImages = imgArray
        shipExplosionImg.animationDuration = 0.5
        shipExplosionImg.animationRepeatCount = 1
        shipExplosionImg.startAnimating()
    }
    
    func setExplosionImages(imgArray: Array<UIImage>) {
        explosionImg.isHidden = false
        explosionImg.animationImages = imgArray
        explosionImg.animationDuration = 0.5
        explosionImg.animationRepeatCount = 1
        explosionImg.startAnimating()
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
        let path = Bundle.main.path(forResource: "pr3", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try parrotPlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            parrotPlayer.prepareToPlay()
            parrotPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func playAhoySoundEffect() {
        let path = Bundle.main.path(forResource: "ahoy", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try shipPlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
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
            

            self.panDownView.center.y += 440
            self.editedRope1.center.y += 400
            self.editedRope2.center.y += 400
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
        self.pirateNameInfo.text = pirate.name
        self.pirateTotalLbl.text = "\(pirate.numberOfPirates)"
        self.lootPerSessionLbl.text = String(format: "$%.2f", pirate.lootAmount)
        self.piratePriceLbl.text = String(format: "$%.2f", pirate.piratePrice)
        
        self.lootingTimeLbl.text = "\(pirate.lootTime)"

    }
    
    func updatePirateFightingImage(pirate: Pirate) {
        pirateImageOverlay.stopAnimating()
        var imgArray = [UIImage]()
        for x in 0...14 {
            let img = UIImage(named:"pirate\(pirate.id)attack\(x)")
            imgArray.append(img!)
        }
        setPirateOverlayImage(imgArray: imgArray)
    }
    
    func setPirateOverlayImage(imgArray: Array<UIImage>) {
        pirateImageOverlay.stopAnimating()
        pirateImageOverlay.animationImages = imgArray
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
                UserDefaults.standard.set(false, forKey: "launchedStartUp")
                var timer = Timer()
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                
            }
            if pirate.id == 0 {
                updateFirstPirate(pirate: pirate)
            }
        }
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
            
            let currentTime = (timeSinceInMilliseconds / Double(pirate.lootTime * 1000))

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
        print("\(pirate.currentTime)")
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
    
    
    
    @IBAction func pirateBtnPressed(_ sender: Any) {
        
        let context = appDelegate.persistentContainer.viewContext
        
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
        playAhoySoundEffect()
        addShipExplosionImagesForAnimation()
        addShipImagesForAnimation()
    }
    
    @IBAction func exitIconTapped(_ sender: Any) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 4, animations: {
            self.blackGlass.isHidden = true
            self.exitIcon.isHidden = true
            self.panDownView.center.y -= 440
            self.editedRope1.center.y -= 400
            self.editedRope2.center.y -= 400
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
 
        let button = sender as! UIButton
        let index = button.tag

        let pirate = sortedPirates[index]
        playPurchaseSoundEffect()
        checkIfAllPiratesAreFilled()
        
        pirate.numberOfPirates += 1
        wallet[0].totalLootAmount -= pirate.piratePrice
        pirate.piratePrice = (pirate.piratePrice + pirate.piratePrice / 7)
        pirate.lootTime += pirate.lootTime / 5
        pirate.lootAmount += (pirate.lootAmount / 20)
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
    }
    
    @IBAction func offlineAdLabelPressed(_ sender: Any) {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
        offlineLootView.isHidden = true
        
        
    }
    
    
    
}


