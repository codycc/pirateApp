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
import UserNotifications


class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate, GADInterstitialDelegate {
   
   
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
    @IBOutlet weak var lootHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lootWidth: NSLayoutConstraint!
    @IBOutlet weak var locationImg: UIImageView!
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var birdHeight: NSLayoutConstraint!
    @IBOutlet weak var birdsWidth: NSLayoutConstraint!
    @IBOutlet weak var groundImgHeight: NSLayoutConstraint!
    @IBOutlet weak var groundImg: UIImageView!
    @IBOutlet weak var planksImg: UIImageView!
    
    @IBOutlet weak var paperImg: UIImageView!
    @IBOutlet weak var locationForegroundImg: UIImageView!
    
    @IBOutlet weak var palmTreeImage: UIImageView!
    @IBOutlet weak var boardPlankLocationImg: SpringImageView!
    
    @IBOutlet weak var treasureBoard: UIView!
    @IBOutlet weak var labelForTreasure: UILabel!
    @IBOutlet weak var gpsImg: SpringButton!
    
    @IBOutlet weak var heightOfTreasureboard: NSLayoutConstraint!
    @IBOutlet weak var trailingTreasureBoard: NSLayoutConstraint!
    
    @IBOutlet weak var treasureImg: UIImageView!
    @IBOutlet weak var widthOfTreasureImg: NSLayoutConstraint!
    
    @IBOutlet weak var heightOfTreasureImg: NSLayoutConstraint!
    
    @IBOutlet weak var treasureTypeLbl: UILabel!
    @IBOutlet weak var treasurePlankImg: UIImageView!
    @IBOutlet weak var widthOfTreasureBoard: NSLayoutConstraint!
    
    @IBOutlet weak var gemView: UIView!
    @IBOutlet weak var leadingTreasureConstraint: NSLayoutConstraint!
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
    var popPlayer: AVAudioPlayer!
    var lootPlayer: AVAudioPlayer!
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
    var timerPirate12 = Timer()
    var timerPirate13 = Timer()
    var timerPirate14 = Timer()
    
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
    var timer2Pirate12 = Timer()
    var timer2Pirate13 = Timer()
    var timer2Pirate14 = Timer()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var changeParrotColor = true
    var changeShipColor = true
    var amountOfMoneyMade = 0.0
    var explosionArray = [UIImage]()
    var shipExplosionArray = [UIImage]()
    var shipArray = [UIImage]()
    var position: CGPoint!
    var currentBirdNumber: Int32!
    var birdHasReleased = false
    var pirateToSend: Pirate!
    var birdImages = [UIImage]()
    var treasureItems = [Treasure]()
    var sortedTreasureItems = [Treasure]()
    var numberOfImages: Int32!
    var numberOfImagesDie: Int32!
    var birdTimer = Timer()
    var randomArrayForBirds = [0,1,2,0,0,1,0,2,0,2,2,1,1,2,0,0,1,0,0,2,1,1,2,0]
    var randomIntPickForBirds: Int!
    var randomIntForBirds: Int!
    var birdX: CGFloat!
    var birdY: CGFloat!
    var imageBirdDie: UIImage!
    var birdName: String!
    var imageNameBirdDie: String!
    let imageNameForBird = "seagullfly0"
    var imageForBird: UIImage!
    var imageNameLoot: String!
    var smokeImageArray = [UIImage]()
    var direction: Int32!
    var isPresent: Bool!
    var boolean: Bool!
    var boolean2: Bool!
    var birdWidth: CGFloat!
    var newBirdName:String!
    var birdImageView = UIImageView()
    var treasureOrLootArray = [0,0,0,0,0,0,0,1,1,0,1,1]
    var randomLootOrGemPick: Int!
    var imageForLoot: UIImage!
    var imageNameSmoke = "smokeEffect0"
    var imageSmoke: UIImage!
    var randomIntForLootOrGem = Int.random(in: 50..<500)
    var randomIntForBird: Int!
    var randomIntForBird2: Int!
    var forgroundImgName: UIImage!
    var pickForLootOrGem: Int!
    var palmTreeImageName: UIImage!
    var labelForBird: UILabel!
    var locationImageName = UIImage()
    var interstitial: GADInterstitial!
    var groundImageName = UIImage()
    var locationLootImageName: UIImage!
    var parallaxOffsetSpeed: CGFloat = 30
    var cellHeight: CGFloat = 160
    var parallaxImageHeight: CGFloat {
        let maxOffset = (sqrt(pow(cellHeight, 2) + 4 * parallaxOffsetSpeed * self.tableView.frame.height) - cellHeight) / 2
        
        return maxOffset + self.cellHeight
    }
    
    let ahoyPath = Bundle.main.path(forResource: "ahoy", ofType: "wav")
    let parrotPath = Bundle.main.path(forResource: "pr3", ofType: "wav")
    let shopPath = Bundle.main.path(forResource: "shopNoise", ofType: "wav")
    let requestPirate = NSFetchRequest<NSFetchRequestResult>(entityName: "Pirate")
    let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
    let requestTreasure = NSFetchRequest<NSFetchRequestResult>(entityName: "Treasure")
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
        
        
        
        let content = UNMutableNotificationContent()
        
        content.title = "Ahoy!"
        content.body = "There's looting to be done matey!"
        content.sound = UNNotificationSound.default
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: false)
        
        let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        //adView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adView.adUnitID = "ca-app-pub-1067425139660844/7823755834"
        
        
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
        
        //
        widthOfTreasureBoard.constant = UIScreen.main.bounds.width / 2
        heightOfTreasureboard.constant = UIScreen.main.bounds.height / 12
        
 
        requestPirate.returnsObjectsAsFaults = false
        requestWallet.returnsObjectsAsFaults = false
        requestUser.returnsObjectsAsFaults = false
        
        
        NotificationCenter.default.addObserver(self, selector:#selector(MainVC.alertTimers), name:
        UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateWalletLootNotification), name: NSNotification.Name(rawValue: "updateLoot"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshPirateDataAndUserLocation), name: NSNotification.Name(rawValue: "refreshPiratesAndLocation"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(turnViewOn), name: NSNotification.Name(rawValue: "turnOnView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetPiratesFromLocation), name: NSNotification.Name(rawValue: "resetPirateFromLocation"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(changeLocationImage), name: NSNotification.Name(rawValue: "changeLocationImage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name: NSNotification.Name(rawValue: "updateTable"), object: nil)
        
        interstitial = createAndLoadInterstitial()
        interstitial.delegate = self
        
        //fetching Pirate Entity from CoreData
        grabUserData()
        grabPirateData()
        grabWalletData()
        updateWalletLoot()
        updateGemAmount()
        updatePrestigeAmount()
        
        addShipImagesForAnimation()
        //fix
        playMusic()
        sortPirates()
        //look into timers? they are still running when you exit the view but you are calling them again when you load the view 
        startTimers()
        startAnimationTimers()
        //checkIfAllPiratesAreFilled()
        
        refreshPirateDataAndUserLocation()
        animateBackgroundImage()
        moveBackgroundImage()
        initializeBoardAnimation()
        grabTreasureItems()
        sortTreasureItems()
        checkWhatLocation()
        //addParrotImagesForAnimation()
        addToSmokeImageArray()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.tableViewHeight.constant = self.view.frame.height * 0.35
        self.tableViewHeight.constant = 160
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showIfUserIsOnFirstUse()
        isPresent = true
        refreshPirateDataAndUserLocation()
        addParrotImagesForAnimation()
        initializeAnimateBird()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        birdTimer.invalidate()
    }
    

    @objc func alertTimers() {
        startTimers()
    }
    
    @objc func updateTable() {
        print("fired")
        DispatchQueue.main.async {
            self.startTimers()   
        }
    }
    
    @objc func invalidateTimers() {
        UserDefaults.standard.set(true, forKey: "appClosed")
    }
    
    func turnViewOff() {
        isPresent = false
    }
    
    @objc func turnViewOn() {
        isPresent = true
    }
    
    @objc func changeLocationImage() {
        grabUserData()
        checkWhatLocation()
        addParrotImagesForAnimation()
       
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitial = GADInterstitial(adUnitID: "ca-app-pub-1067425139660844/5758881262")
        
        
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    
     func startAnimationTimers() {
        var chestTimer = Timer()
        chestTimer = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(MainVC.setLootChest), userInfo: nil, repeats: true)
        var gemsTimer = Timer()
        gemsTimer = Timer.scheduledTimer(timeInterval: 11, target: self, selector: #selector(MainVC.setGems), userInfo: nil, repeats: true)
    }
    
    func animateBackgroundImage() {
        var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 9, target: self, selector: #selector(MainVC.moveBackgroundImage), userInfo: nil, repeats: true)
    }
    
    @objc func moveBackgroundImage() {
        UIView.animate(withDuration: 4.5, animations: {
            self.locationImg.transform = CGAffineTransform(translationX: 30, y: 0)
        }) { (finished) in
            UIView.animate(withDuration: 4.5, animations: {
                self.locationImg.transform = CGAffineTransform(translationX: -30, y: 0)
            })
        }
    }
    
    func initializeAnimateBird() {
        birdTimer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(MainVC.animateBird), userInfo: nil, repeats: true)
    }
    
    
    func initializeBoardAnimation() {
        var timer = Timer()
        
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(MainVC.animateBoard), userInfo: nil, repeats: true)
        
    }
    
    @objc func animateBoard() {
        gpsImg.animation = "pop"
        gpsImg.force = 2
        gpsImg.animate()
    }
    
    func addToSmokeImageArray() {
        for x in 1...14 {
            let img = UIImage(named:"smokeEffect\(x)")
            smokeImageArray.append(img!)
        }
    }
    
    func animateTreasureBoard() {
        treasureBoard.isHidden = false
        UIView.animate(withDuration: 5.0, delay: 1, usingSpringWithDamping: 5, initialSpringVelocity: 4, options: .curveEaseInOut, animations: {
             self.treasureBoard.transform = CGAffineTransform(translationX: -((UIScreen.main.bounds.width / 2) - 30), y: 0)
        }) { _ in
            //
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            UIView.animate(withDuration: 1.0, animations: {
                self.treasureBoard.transform = CGAffineTransform(translationX: (UIScreen.main.bounds.width / 2), y: 0)
            }) { (finished) in
                
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            position = touch.location(in: view)
            print(position)
            if birdHasReleased && isPresent  && (position.x > (birdImageView.layer.presentation()!.frame.minX - 150) && position.x < (birdImageView.layer.presentation()!.frame.minX + 150)) && (position.y > (birdImageView.layer.presentation()!.frame.minY - 150) && position.y < (birdImageView.layer.presentation()!.frame.minY + 150)) {
                birdX = birdImageView.layer.presentation()!.frame.minX
                birdY = birdImageView.layer.presentation()!.frame.minY
                birdImageView.removeFromSuperview()
                
                playParrotSoundEffect()
                
                
                switch users[0].currentLocation {
                case 4,6:
                    switch currentBirdNumber {
                    case 0:
                        newBirdName = "swordfish"
                    case 1:
                        newBirdName = "octopus"
                    case 2:
                        newBirdName = "hammerhead"
                    default:
                        print("default")
                    }
                case 0,1,2,3,5:
                    switch currentBirdNumber {
                    case 0:
                        newBirdName = "pelican"
                    case 1:
                        newBirdName = "parrot"
                    case 2:
                        newBirdName = "vulture"
                    default:
                        print("default")
                    }
                default:
                    print("default")
                }
                
                
                let imageView = UIImageView()
                imageNameBirdDie = "\(String(describing: newBirdName))die0"
                imageBirdDie = UIImage(named: imageNameBirdDie)
                imageView.frame = CGRect(x: birdX, y: birdY , width: birdWidth, height: birdWidth)
                imageView.image = imageBirdDie
                imageView.contentMode = .scaleAspectFit
                self.view.addSubview(imageView)

                birdImages = []
                switch users[0].currentLocation {
                case 0,1,2,3,5:
                    for x in 0...numberOfImagesDie {
                        let img = UIImage(named:"\(newBirdName!)die\(x)")
                        birdImages.append(img!)
                    }
                case 4,6:
                  print("test")
                default:
                    print("default")
                }
              

                switch users[0].currentLocation {
                case 0,1,2,3,5:
                    print("nothing")
                case 4,6:
                    imageView.stopAnimating()
                    imageView.animationImages = birdImages
                    imageView.animationDuration = 0.7
                    imageView.animationRepeatCount = 1
                    imageView.startAnimating()
                default:
                    print("default")
                }
               
                
                randomLootOrGemPick = Int.random(in: 0..<treasureOrLootArray.count - 1 )
                randomIntForLootOrGem = Int.random(in: 50..<500)
                pickForLootOrGem = treasureOrLootArray[randomLootOrGemPick]
                
                
                if pickForLootOrGem == 1 {
                    imageNameLoot = "icon_gem"
                } else {
                    imageNameLoot = "singleLoot"
                }
                
                for _ in 1...7 {
                    autoreleasepool {
                        boolean = Bool.random()
                        boolean2 = Bool.random()
                        
                        imageForLoot = UIImage(named: imageNameLoot)
                        let imageViewForSingleLoot = UIImageView(image: imageForLoot)
                        
                        imageViewForSingleLoot.frame = CGRect(x: birdX + (birdX / 2), y: birdY + (birdY / 2) , width: self.birdWidth / 6, height: self.birdWidth / 6)
                        self.view.addSubview(imageViewForSingleLoot)
                        
                        randomIntForBird = Int.random(in: 25..<80)
                        randomIntForBird2 = Int.random(in: 25..<80)
                        
                        UIView.animate(withDuration: 0.4, animations: {
                            
                            if self.boolean {
                                imageViewForSingleLoot.frame.origin.x += CGFloat(self.randomIntForBird)
                                
                            } else {
                                imageViewForSingleLoot.frame.origin.x -= CGFloat(self.randomIntForBird)
                            }
                            
                            if self.boolean2 {
                                imageViewForSingleLoot.frame.origin.y += CGFloat(self.randomIntForBird2)
                            } else {
                                imageViewForSingleLoot.frame.origin.y -= CGFloat(self.randomIntForBird2)
                            }
                            
                        }) { (finished) in
                            UIView.animate(withDuration: 0.5, animations: {
                                
                                imageViewForSingleLoot.alpha = 0 
                            }) { (finished) in
                                imageViewForSingleLoot.removeFromSuperview()
                            }
                        }
                    }
                }
                

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Change `2.0` to the desired number of seconds.
                    imageView.removeFromSuperview()
                    
                    let imageViewSmoke = UIImageView()
                    self.imageNameSmoke = "smokeEffect0"
                    self.imageSmoke = UIImage(named: self.imageNameSmoke)
                    
                    imageViewSmoke.frame = CGRect(x: self.birdX, y: self.birdY , width: self.birdWidth, height: self.birdWidth)
                    imageViewSmoke.image = self.imageSmoke
                    imageViewSmoke.contentMode = .scaleAspectFit
                    self.view.addSubview(imageViewSmoke)
                    
                    imageViewSmoke.stopAnimating()
                    imageViewSmoke.animationImages = self.smokeImageArray
                    imageViewSmoke.animationDuration = 0.3
                    imageViewSmoke.animationRepeatCount = 1
                    imageViewSmoke.startAnimating()
 
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { // Change `2.0` to the desired number of seconds.
                        imageViewSmoke.removeFromSuperview()

                        self.labelForBird = UILabel(frame: CGRect(x: self.birdX + (self.birdX / 2), y: self.birdY + (self.birdY / 2), width: 100, height: 31))
                        self.labelForBird.center = CGPoint(x: self.birdX + (self.birdX / 2) , y: self.birdY + (self.birdY / 2) )
                        self.labelForBird.textAlignment = .center
                        self.labelForBird.font = UIFont(name: "Pirates Writers", size: 30)
                       
                        self.labelForBird.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
                      
                        
                        switch self.pickForLootOrGem {
                        case 0:
                            self.wallet[0].totalLootAmount += Double(Double(self.randomIntForLootOrGem) + (Double(self.randomIntForLootOrGem) * self.users[0].bonusAmount))
                            self.labelForBird.text = "+ $\(self.randomIntForLootOrGem)"
                        case 1:
                            let randomBool = Bool.random()
                            
                            if randomBool {
                                self.wallet[0].totalGemsAmount += 1
                                self.labelForBird.text = "1 Gem"
                            } else {
                                self.wallet[0].totalGemsAmount += 2
                                self.labelForBird.text = "2 Gems"
                            }
                            
                        default:
                            print("default")
                        }
                        
                        let context = self.appDelegate.persistentContainer.viewContext
    
                        self.view.addSubview(self.labelForBird)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            self.labelForBird.removeFromSuperview()
                        }
                        do {
                            try context.save()
                            self.updateGemAmount()
                            self.updateWalletLoot()
                        } catch {
                            
                        }
                    }
                    
                }

            }
        }
    }
    
   
    
    @objc func animateBird() {
        
        randomIntPickForBirds = Int.random(in: 0..<randomArrayForBirds.count - 1 )
        randomIntForBirds = randomArrayForBirds[randomIntPickForBirds]
      
        currentBirdNumber = Int32(randomIntForBirds)
        
        birdImages = []
        switch users[0].currentLocation {
        case 4,6:
            switch randomIntForBirds {
            case 0:
                birdName = "swordfish"
                birdWidth = UIScreen.main.bounds.width / 2
                direction = 1
                numberOfImages = 15
                numberOfImagesDie = 11
            case 1:
                birdName = "octopus"
                birdWidth = UIScreen.main.bounds.width / 3
                direction = 0
                numberOfImages = 15
                numberOfImagesDie = 11
            case 2:
                birdName = "hammerhead"
                birdWidth = UIScreen.main.bounds.width / 2
                direction = 1
                numberOfImages = 15
                numberOfImagesDie = 11
            default:
                print("hello")
                
                
            }
        case 0,1,2,3,5:
            switch randomIntForBirds {
            case 0:
                birdName = "pelican"
                birdWidth = UIScreen.main.bounds.width / 2
                direction = 1
                numberOfImages = 11
                numberOfImagesDie = 11
            case 1:
                birdName = "parrot"
                birdWidth = UIScreen.main.bounds.width / 3
                direction = 0
                numberOfImages = 11
                numberOfImagesDie = 11
            case 2:
                birdName = "vulture"
                birdWidth = UIScreen.main.bounds.width / 2
                direction = 0
                numberOfImages = 15
                numberOfImagesDie = 11
            default:
                print("hello")
                
                
            }
        default:
            print("default")
            
        }
        
        
        
        
        imageForBird = UIImage(named: imageNameForBird)
        
        birdImageView.image = imageForBird
        let tapGestureBird = UITapGestureRecognizer(target: self, action: #selector(MainVC.birdTapped(_:)))
        self.birdImageView.addGestureRecognizer(tapGestureBird)
        birdImageView.isUserInteractionEnabled = true
        
        switch direction {
        case 0:
            
            birdImageView.frame = CGRect(x: 0 - birdWidth, y: UIScreen.main.bounds.height / 4 , width: birdWidth, height: birdWidth)
        case 1:
            birdImageView.frame = CGRect(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height / 5 , width: birdWidth, height: birdWidth)
        default:
            print("default")
        }
        
        birdImageView.contentMode = .scaleAspectFit
        self.view.addSubview(birdImageView)
        birdHasReleased = true
       
        for x in 0...numberOfImages {
            let img = UIImage(named:"\(birdName!)fly\(x)")
            birdImages.append(img!)
        }
        
        birdImageView.stopAnimating()
        birdImageView.animationImages = birdImages
        birdImageView.animationDuration = 1.3
        birdImageView.animationRepeatCount = 0
        birdImageView.startAnimating()
    
        
        switch direction {
        case 0:
            
            UIView.animate(withDuration: 5.0, delay: 0.0, options: [.allowUserInteraction], animations: {
                self.birdImageView.frame.origin.x += UIScreen.main.bounds.width + self.birdWidth
            }, completion: { (finished: Bool) in
                self.birdImageView.removeFromSuperview()
                
                
            })

        case 1:
            UIView.animate(withDuration: 5.0, delay: 0.0, options: [.allowUserInteraction], animations: {
                self.birdImageView.frame.origin.x -= UIScreen.main.bounds.width + self.birdWidth
            }, completion: { (finished: Bool) in
              
                self.birdImageView.removeFromSuperview()
                
            })

        default:
            print("default")
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
    
    func sortTreasureItems() {
        sortedTreasureItems = []
        
        sortedTreasureItems = treasureItems.sorted(by: { $0.id < $1.id})
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
    
    @objc func refreshPirateDataAndUserLocation() {
        grabPirateData()
        tableView.reloadData()
        //checkWhatItemsToDisplay()
        
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
                    let thePirate = result as! Pirate
                    print("\(thePirate.levelToUnlock)leveltoUnlockPirate....\(users[0].currentLocation)currentlocation")
                    if thePirate.isUnlocked || thePirate.levelToUnlock == users[0].currentLocation {
                        pirates.append(result as! Pirate)
                        sortPirates()
                        tableView.reloadData()
                    }
                    
                }
            }
        } catch {
            // handle error
        }
    }
    
    func parallaxOffset(newOffsetY: CGFloat, cell: UITableViewCell) -> CGFloat {
        return (newOffsetY - cell.frame.origin.y) / parallaxImageHeight * parallaxOffsetSpeed
    }
    
    func updateGemAmount() {
        let gemAmount = wallet[0].totalGemsAmount
        prestigeLbl.text = "\(gemAmount)"
    }
    
    func updatePrestigeAmount() {
        let prestigeAmount = wallet[0].totalPrestigeAmount
        
    }
    
    
    @objc func updateWalletLootNotification() {
        updateWalletLoot()
        updateGemAmount()
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

        
        switch users[0].currentLocation {
        case 0:
            for x in 0...1 {
                let img = UIImage(named:"__seagull_idle_00\(x)")
                imgArray.append(img!)
                birdsWidth.constant = UIScreen.main.bounds.width / 3
                birdHeight.constant = UIScreen.main.bounds.height / 4
            }
        case 1:
            for x in 0...8 {
                let img = UIImage(named:"yellowParrot\(x)")
                imgArray.append(img!)
                birdsWidth.constant = UIScreen.main.bounds.width / 3
                
                birdHeight.constant = UIScreen.main.bounds.height / 4
            }
        case 2:
            for x in 0...8 {
                let img = UIImage(named:"redParrot\(x)")
                imgArray.append(img!)
                birdsWidth.constant = UIScreen.main.bounds.width / 3
                birdHeight.constant = UIScreen.main.bounds.height / 4
            }
        case 3:
            for x in 0...19 {
                let img = UIImage(named:"flamingo\(x)")
                imgArray.append(img!)
            }
            print("flamingo called")
            birdsWidth.constant = UIScreen.main.bounds.width / 2
            birdHeight.constant = UIScreen.main.bounds.height / 3
        case 4:
            for x in 0...1 {
                let img = UIImage(named:"__seagull_idle_00\(x)")
                imgArray.append(img!)
            }
        case 5:
            for x in 0...1 {
                let img = UIImage(named:"__seagull_idle_00\(x)")
                imgArray.append(img!)
            }
        case 5:
            for x in 0...1 {
                let img = UIImage(named:"__seagull_idle_00\(x)")
                imgArray.append(img!)
            }
        default:
            print("default")
            
        }
        
        setParrotImages(imgArray: imgArray)
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
                pirate.currentTime = 10
                pirate.piratePrice = 10
             
            case 1:
                pirate.lootTime = 13
                pirate.lootAmount = 100
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 13
                pirate.piratePrice = 75
               
            case 2:
                pirate.lootTime = 15
                pirate.lootAmount = 120
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 15
                pirate.piratePrice = 200
              
            case 3:
                pirate.lootTime = 18
                pirate.lootAmount = 200
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 18
                pirate.piratePrice = 1500
              
            case 4:
                pirate.lootTime = 27
                pirate.lootAmount = 400
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 27
                pirate.piratePrice = 2000
              
            case 5:
                pirate.lootTime = 36
                pirate.lootAmount = 500
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 36
                pirate.piratePrice = 2500
               
            case 6:
                pirate.lootTime = 45
                pirate.lootAmount = 600
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 45
                pirate.piratePrice = 3000
         
            case 7:
                pirate.lootTime = 54
                pirate.lootAmount = 700
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 54
                pirate.piratePrice = 3500
               
            case 8:
                pirate.lootTime = 63
                pirate.lootAmount = 800
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 63
                pirate.piratePrice = 4000
              
            case 9:
                pirate.lootTime = 72
                pirate.lootAmount = 900
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 72
                pirate.piratePrice = 4500
              
            case 10:
                pirate.lootTime = 10
                pirate.lootAmount = 84
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 84
                pirate.piratePrice = 5000
              
            case 11:
                pirate.lootTime = 86
                pirate.lootAmount = 1100
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 86
                pirate.piratePrice = 5500
               
            case 12:
                pirate.lootTime = 94
                pirate.lootAmount = 1150
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 94
                pirate.piratePrice = 6000
             
            case 13:
                pirate.lootTime = 97
                pirate.lootAmount = 1200
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 97
                pirate.piratePrice = 6500
            
            case 14:
                pirate.lootTime = 99
                pirate.lootAmount = 1250
                pirate.numberOfPirates = 0
                pirate.isAnimating = false
                pirate.isUnlocked = false
                pirate.currentTime = 99
                pirate.piratePrice = 6750
                
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
         UserDefaults.standard.set(false, forKey: "appClosed")
       
    }

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
        timerPirate12.invalidate()
        timerPirate13.invalidate()
        timerPirate14.invalidate()
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
        timer2Pirate12.invalidate()
        timer2Pirate13.invalidate()
        timer2Pirate14.invalidate()
    }
    
    func checkIfAllPiratesAreFilled() {
        var count = 0
        for pirate in sortedPirates {
            if pirate.numberOfPirates >= 100 {
                count += 1
            }
           
        }
        if count >= 15 {
                wallet[0].totalPrestigeAmount += 1
            
                stopTimers()
                resetPirates()
                grabPirateData()
                sortPirates()
                resetOtherTimers()
                startTimers()
                updateGemAmount()
                grabWalletData()
        }
        
        let context = appDelegate.persistentContainer.viewContext
        do {
            try context.save()
            updatePrestigeAmount()
        } catch {
            
        }
        
    }
    
    @objc func resetPiratesFromLocation() {
        users[0].currentLocation = 0
        
        stopTimers()
        resetPirates()
        grabPirateData()
        sortPirates()
        resetOtherTimers()
        startTimers()
        wallet[0].totalLootAmount = 0
       
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            try context.save()
            grabWalletData()
            checkWhatLocation()
            tableView.reloadData()
        } catch {
            
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
    }
    
    func setParrotImages(imgArray: Array<UIImage>) {
        parrotImg.stopAnimating()
        parrotImg.animationImages = imgArray
        parrotImg.animationDuration = 1.7
        parrotImg.animationRepeatCount = 0
        parrotImg.startAnimating()
    }
    
    func addShipImagesForAnimation() {
        shipArray = []
        
        switch users[0].currentLocation {
        case 0...1:
            for x in 0...24 {
                let img = UIImage(named:"shipRight\(x)")
                shipArray.append(img!)
            }
        case 2...6:
            for x in 0...24 {
                let img = UIImage(named:"shipRightBlack\(x)")
                shipArray.append(img!)
            }
        default:
            print("default")
            
            
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
    
    func playMusic() {
        let path = Bundle.main.path(forResource: "piratesmusic", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.volume = 0.4
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
    
    func playPopSoundEffect() {
        let path = Bundle.main.path(forResource: "pop", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try popPlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            popPlayer.prepareToPlay()
            popPlayer.volume = 0.4
            popPlayer.play()
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
        sortedPirates = []
        
        sortedPirates = pirates.sorted(by: { $0.id < $1.id})
    }
    
    func animateCampFire() {
        var imgArray = [UIImage]()
        
        for x in 1...6 {
            let img = UIImage(named:"campfire0\(x)")
            imgArray.append(img!)
        }
        
        campFireImage.animationImages = imgArray
        campFireImage.animationDuration = 0.7
        campFireImage.animationRepeatCount = -1
        campFireImage.startAnimating()
    }
    
 
    func checkWhatLocation() {
        addShipImagesForAnimation()
        switch users[0].currentLocation {
        case 0:
            locationImageName = UIImage(named: "gamebg9")!
            locationLbl.text = "Lonely Isle"
            groundImageName = UIImage(named: "oceanfg")!
            groundImgHeight.constant = UIScreen.main.bounds.height / 3
            groundImg.isHidden = false
            lootImg.isHidden = false
            locationLootImageName = UIImage(named: "coins_pack_2")
            lootImg.image = locationLootImageName
            
            campFireImage.isHidden = true
            locationForegroundImg.isHidden = true
            palmTreeImage.isHidden = true
            parrotImg.isHidden = false

        case 1:
            locationImageName = UIImage(named: "tropical2")!
            locationLbl.text = "Pirate's Peninsula"
            groundImageName = UIImage(named: "ground3")!
            groundImg.isHidden = true
            locationForegroundImg.isHidden = true
            parrotImg.isHidden = false
            campFireImage.isHidden = true
            
            lootImg.isHidden = true
            groundImgHeight.constant = UIScreen.main.bounds.height / 8
            palmTreeImage.isHidden = false
            palmTreeImageName = UIImage(named: "palmtree")
            palmTreeImage.image = palmTreeImageName
        case 2:
            locationImageName = UIImage(named: "gamebg12")!
            locationLbl.text = "International Waters"
            groundImageName = UIImage(named: "oceanfg")!
            groundImgHeight.constant = UIScreen.main.bounds.height / 3
            groundImg.isHidden = false
            parrotImg.isHidden = false
     
            lootImg.isHidden = false
            locationLootImageName = UIImage(named: "2bagsgems")
            lootImg.image = locationLootImageName
            campFireImage.isHidden = true
            locationForegroundImg.isHidden = true
            palmTreeImage.isHidden = true
        case 3:
            locationImageName = UIImage(named: "gamebg5")!
            locationLbl.text = "Lazy Lagoon"
            groundImageName = UIImage(named: "beachfg")!
            groundImgHeight.constant = UIScreen.main.bounds.height / 4
            groundImg.isHidden = false
            parrotImg.isHidden = false
           
            lootImg.isHidden = false
            locationLootImageName = UIImage(named: "front_chest_gems")
            lootImg.image = locationLootImageName
            campFireImage.isHidden = true
            locationForegroundImg.isHidden = true
            palmTreeImage.isHidden = true
        case 4:
            locationImageName = UIImage(named: "coralbg")!
            locationLbl.text = "Murky Shallows"
            groundImageName = UIImage(named: "ground2")!
           
            locationForegroundImg.isHidden = true
            palmTreeImage.isHidden = true
            campFireImage.isHidden = true
            pirateShipImg.isHidden = false
            groundImg.isHidden = false
            groundImgHeight.constant = UIScreen.main.bounds.height / 8
            groundImageName = UIImage(named: "groundmurkey")!
            locationForegroundImg.isHidden = false
            forgroundImgName = UIImage(named: "forgroundmurkey")
            locationForegroundImg.image = forgroundImgName
            parrotImg.isHidden = true
        case 5:
            animateCampFire()
            locationImageName = UIImage(named: "gamebg3")!
            locationLbl.text = "Redbeard's Bayou"
            groundImgHeight.constant = UIScreen.main.bounds.height / 8
            groundImageName = UIImage(named: "ground3")!
            locationForegroundImg.isHidden = true
        
            groundImg.isHidden = false
            parrotImg.isHidden = true
            palmTreeImage.isHidden = true
            campFireImage.isHidden = false
            lootImg.isHidden = true
            
        case 6:
            locationImageName = UIImage(named: "greatreefbg")!
            locationLbl.text = "The Great Reef"
            locationForegroundImg.isHidden = true
            groundImg.isHidden = false
            parrotImg.isHidden = true
           
            lootImg.isHidden = true
            campFireImage.isHidden = true
            palmTreeImage.isHidden = true
            groundImgHeight.constant = UIScreen.main.bounds.height / 8
            groundImageName = UIImage(named: "groundcoral")!
        default:
            print("default")
        }
        
        addParrotImagesForAnimation()
        locationImg.image = locationImageName
        groundImg.image = groundImageName
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
                case 12:
                    timerPirate12 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                case 13:
                    timerPirate13 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                case 14:
                    timerPirate14 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
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
            tableView.reloadData()
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
            wallet[0].totalLootAmount += (amountOfMoneyMade + (amountOfMoneyMade * users[0].bonusAmount))
            
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
            wallet[0].totalLootAmount += (pirate.lootAmount + (pirate.lootAmount * users[0].bonusAmount))
            pirate.currentTime = pirate.lootTime
            updateWalletLoot()
        }
        
        do {
           try context.save()
        } catch {
            //handle error 
        }
        
        let indexPath = IndexPath(row: Int(pirate.currentRow), section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
        
        if UserDefaults.standard.bool(forKey: "appClosed") == true {

            timer.invalidate()
        } 
    }
    
  
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pirates.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height

    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wallet = self.wallet[0]
        let pirate = sortedPirates[indexPath.row]
        pirate.currentRow = Int32(indexPath.row)
        
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            try context.save()
        } catch {
            
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PirateCell") as? PirateCell {
            cell.configureCell(pirate: pirate, wallet: wallet)
          
            cell.buyPlankBtn.tag = indexPath.row
            cell.pirateImgBtn.tag = indexPath.row
            cell.plankBtn.tag = indexPath.row
            cell.pirateImg.tag = indexPath.row
            cell.resetPirateBtn.tag = indexPath.row 
            
            
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
            rowHeight = 160.0   
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
        self.turnViewOff()
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
                        case 12:
                        timer2Pirate12 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                        case 13:
                        timer2Pirate13 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
                        case 14:
                        timer2Pirate14 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.updateCoreDataFromTimer), userInfo: pirate, repeats: true)
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
    
    
    @IBAction func resetPiratePressed(_ sender: Any) {
     
        let button = sender as! UIButton
        
        let index = button.tag
        var pirateTimer: Int32!
        
        let pirate = sortedPirates[index]
        
        switch pirate.id {
        case 0:
            pirate.lootTime = 10
            pirate.lootAmount = 25
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 10
            pirate.piratePrice = 10
         
            
        case 1:
            pirate.lootTime = 13
            pirate.lootAmount = 100
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 13
            pirate.piratePrice = 75
           
        case 2:
            pirate.lootTime = 15
            pirate.lootAmount = 120
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 15
            pirate.piratePrice = 200
            
        case 3:
            pirate.lootTime = 18
            pirate.lootAmount = 200
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 18
            pirate.piratePrice = 1500
            
        case 4:
            pirate.lootTime = 27
            pirate.lootAmount = 400
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 27
            pirate.piratePrice = 2000
            
        case 5:
            pirate.lootTime = 36
            pirate.lootAmount = 500
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 36
            pirate.piratePrice = 2500
            
        case 6:
            pirate.lootTime = 45
            pirate.lootAmount = 600
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 45
            pirate.piratePrice = 3000
            
        case 7:
            pirate.lootTime = 54
            pirate.lootAmount = 700
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 54
            pirate.piratePrice = 3500
            
        case 8:
            pirate.lootTime = 63
            pirate.lootAmount = 800
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 63
            pirate.piratePrice = 4000
            
        case 9:
            pirate.lootTime = 72
            pirate.lootAmount = 900
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 72
            pirate.piratePrice = 4500
            
        case 10:
            pirate.lootTime = 10
            pirate.lootAmount = 84
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 84
            pirate.piratePrice = 5000
            
        case 11:
            pirate.lootTime = 86
            pirate.lootAmount = 1100
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 86
            pirate.piratePrice = 5500
        case 12:
            pirate.lootTime = 94
            pirate.lootAmount = 1150
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 94
            pirate.piratePrice = 6000
           
        case 13:
            pirate.lootTime = 97
            pirate.lootAmount = 1200
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 97
            pirate.piratePrice = 6500
           
        case 14:
            pirate.lootTime = 99
            pirate.lootAmount = 1250
            pirate.numberOfPirates = 1
            pirate.isAnimating = true
            pirate.isUnlocked = true
            pirate.currentTime = 99
            pirate.piratePrice = 6750
        default:
            print("default")
        }
        
        //add pirate points
        users[0].currentPiratePoints += 1
        
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            try context.save()
        } catch {
            
        }
        playPopSoundEffect()
        grabPirateData()
        sortPirates()
        
        
        tableView.reloadData()
        
    }
    
    
    
    @IBAction func buyBtnPressed(_ sender: Any, forEvent event: UIEvent) {
       tableView.reloadData()
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        
        let button = sender as! UIButton
        let index = button.tag
        var imageName: String!
        
        let pirate = sortedPirates[index]
        playPopSoundEffect()
        //checkIfAllPiratesAreFilled()
        
        
        
        pirate.numberOfPirates += 1
        wallet[0].totalLootAmount -= pirate.piratePrice
        pirate.piratePrice = (pirate.piratePrice + pirate.piratePrice / 20)
        pirate.lootTime += (pirate.lootTime / 10)
        pirate.lootAmount += (pirate.lootAmount / 15)
        //checkIfAllPiratesAreFilled()
        
        if pirate.numberOfPirates == pirate.levelToUnlockTreasure {
            var randomInt: Int!
            var plankImage: UIImage!
            var gemImg: UIImage!
            
            heightOfTreasureImg.constant = widthOfTreasureBoard.constant / 5
            widthOfTreasureImg.constant = widthOfTreasureBoard.constant / 5
          
            
            switch pirate.id {
            case 0...3:
                randomInt = Int.random(in: 1..<27)
                
                gemImg = UIImage(named: "category1")!
                plankImage = UIImage(named: "commonPlank")!
                imageName = "category1"
                self.treasureTypeLbl.text = "1x Common Treasure!"
            case 4...9:
                randomInt = Int.random(in: 28..<51)
                
                plankImage = UIImage(named: "rarePlank")!
                gemImg = UIImage(named: "category2")!
                imageName = "category2"
                self.treasureTypeLbl.text = "1x Rare Treasure!"
            case 10...14:
                randomInt = Int.random(in: 52..<78)
           
                plankImage = UIImage(named: "epicPlank")!
                gemImg = UIImage(named: "category3")!
                imageName = "category3"
                self.treasureTypeLbl.text = "1x Epic Treasure!"
            default:
                
                print("default")
            }
            
            self.labelForTreasure.text = "\(sortedTreasureItems[(randomInt - 1)].name!)"
            treasureImg.image = gemImg
            treasurePlankImg.image = plankImage
            
            for treasure in treasureItems {
                if treasure.id == randomInt {
                    treasure.isUnlocked = true
                    treasure.numberOfTreasures += 1
                    treasure.timeUnlocked = Int32(NSDate().timeIntervalSince1970)
                }
            }
            animateTreasureBoard()
            playPrestigeSoundEffect()
            
            let context = appDelegate.persistentContainer.viewContext
            
            do {
                try context.save()
            } catch {
                
            }
            
        } else {
             imageName = "singleLoot.png"
        }
        
        if pirate.numberOfPirates == 30 {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        }
        
        
        let image = UIImage(named: imageName)
        
        guard let touch = event.allTouches?.first else { return }
        let point = touch.location(in: view)
        
        
         for index in 1...15 {
                let boolean = Bool.random()
                let boolean2 = Bool.random()
            var theImageName: UIImage!
            if pirate.levelToUnlockTreasure == pirate.numberOfPirates {
                switch pirate.id {
                case 0...3:
                    theImageName = UIImage(named: "category1")
                case 4...9:
                    theImageName = UIImage(named: "category2")
                case 10...14:
                    theImageName = UIImage(named: "category3")
                default:
                    print("default")
                    
                }
            } else {
                theImageName = UIImage(named: "singleLoot")
            }
            
                let imageView = UIImageView(image: theImageName!)
                imageView.frame = CGRect(x: point.x, y: point.y  , width: 30, height: 30)
                self.view.addSubview(imageView)
                
                let randomInt = Int.random(in: 1..<100 )
                let randomInt2 = Int.random(in: 1..<100)
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    if boolean {
                        imageView.frame.origin.x += CGFloat(randomInt)
                        
                    } else {
                        imageView.frame.origin.x -= CGFloat(randomInt)
                    }
                    
                    if boolean2 {
                        imageView.frame.origin.y += CGFloat(randomInt2)
                    } else {
                        imageView.frame.origin.y -= CGFloat(randomInt2)
                    }
                    
                }) { (finished) in
                    UIView.animate(withDuration: 0.9, animations: {
                        imageView.alpha = 0
                        imageView.frame.origin.y += 1000
                    }) { (finished) in
                        imageView.removeFromSuperview()
                    }
                }
            }

        if pirate.numberOfPirates >= 100 {
            wallet[0].totalGemsAmount += 1
            playPrestigeSoundEffect()
            updateGemAmount()
        }
        do {
            try context.save()
            updateWalletLoot()
            //checkIfAllPiratesAreFilled()
            reloadTable()
            
        } catch {
            // handle error
        }
    }
    
    @IBAction func birdTapped(_ sender: Any) {

    }
    
    @IBAction func exitBtnBeggining(_ sender: Any) {
        playAhoySoundEffect()
        
    }
 
    @IBAction func locationsBtnPressed(_ sender: Any) {
        birdTimer.invalidate()
        playPopSoundEffect()
        performSegue(withIdentifier: "goToLocationsVC", sender: nil)
    }
}




