//
//  LocationVC.swift
//  piratesAppRemake
//
//  Created by Cody Condon on 2019-03-07.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import UIKit
import CoreData
import Spring
import AVFoundation
import GoogleMobileAds

class LocationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, GADInterstitialDelegate {
   
 
    @IBOutlet weak var tableView: UITableView!
  
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let requestLocation = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
    let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
    let requestUser = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    let requestPirate = NSFetchRequest<NSFetchRequestResult>(entityName: "Pirate")
    var position: CGPoint!
    
    var locations = [Location]()
    var sortedLocations = [Location]()
    var wallet = [Wallet]()
    var users = [User]()
    var pirates = [Pirate]()
    var piratesToShow = [Pirate]()
    var locationForTableView: Location!
    var checkLocation = false
    var purchasePlayer: AVAudioPlayer!
    var popPlayer: AVAudioPlayer!
    var touchedCollectView = false
    var cellForLoot: LocationCell!
    var indexPathForLoot: IndexPath!
    var rectForLoot: CGRect!
    var rectInScreenForLoot: CGRect!
    var boolean: Bool!
    var boolean2: Bool!
    var randomInt: Int!
    var randomInt2: Int!
    var interstitial: GADInterstitial!
    
    
    var parallaxOffsetSpeed: CGFloat = 35
    var cellHeight: CGFloat = 150
    
    
    var locationResults: [Any]!
    let imageForSingleLoot = UIImage(named: "singleLoot")
   
    var parallaxImageHeight: CGFloat {
        let maxOffset = (sqrt(pow(cellHeight, 2) + 4 * parallaxOffsetSpeed * self.tableView.frame.height) - cellHeight) / 2
        return maxOffset + self.cellHeight
    }
    
    
    
    @IBOutlet weak var exitBtn: UIButton!
    
    
    @IBOutlet weak var blackOverlay: UIView!
    
    
    @IBOutlet weak var redeemView: UIView!
    
    @IBOutlet weak var heightOfRedeemView: NSLayoutConstraint!
    
    @IBOutlet weak var widthOfRedeemView: NSLayoutConstraint!
    
    @IBOutlet weak var redeemBtnInView: UIView!
    
    @IBOutlet weak var collectBonusLbl: UILabel!
    @IBOutlet weak var collectView: UIView!
    @IBOutlet weak var bonusLbl: UILabel!
    @IBOutlet weak var levelPoints: UILabel!
    
    @IBOutlet weak var piratePoints: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
       
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LocationVC.collectViewTapped(_:)))
        self.collectView.addGestureRecognizer(tapGesture)
        
        let redeemGesture = UITapGestureRecognizer(target: self, action: #selector(LocationVC.redeemViewTapped(_:)))
        self.redeemBtnInView.addGestureRecognizer(redeemGesture)
        
        
        
        interstitial = createAndLoadInterstitial()
        interstitial.delegate = self
        tableView.rowHeight = 150
        
        grabLocationData()
        grabWalletData()
        sortLocationData()
        grabUserData()
        updatePointLabels()
        updateCollectBonusLbl()
    }
    
    func updatePointLabels() {
        self.levelPoints.text = "\(users[0].currentLevelPoints)"
        self.piratePoints.text = "\(users[0].currentPiratePoints)"
        updateBonusLabel()
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    func updateCollectBonusLbl() {
        if users[0].currentPiratePoints == 0 && users[0].currentLevelPoints > 0 {
            collectBonusLbl.text = "\(Double(users[0].currentLevelPoints).rounded())%"
        } else if users[0].currentPiratePoints > 0 && users[0].currentLevelPoints == 0 {
          collectBonusLbl.text = "\(Double(users[0].currentPiratePoints).rounded())%"
        } else {
              collectBonusLbl.text = "\(users[0].currentPiratePoints) x \(users[0].currentLevelPoints) = \(Double((users[0].currentPiratePoints * users[0].currentLevelPoints)).rounded())%"
        }
        
    }
    
    func updateBonusLabel() {
        if users[0].piratePoints == 0 && users[0].levelPoints > 0 {
            bonusLbl.text = "\(users[0].levelPoints) Level Points = \(Double(users[0].levelPoints).rounded() / 100)"
        } else if users[0].piratePoints > 0 && users[0].levelPoints == 0 {
            bonusLbl.text = "\(users[0].piratePoints) Pirate Points = \(Double(users[0].piratePoints).rounded() / 100)"
        } else {
             bonusLbl.text = "\(users[0].piratePoints) Pirate Points x \(users[0].levelPoints) Level Points = \((users[0].bonusAmount * 100).rounded())% Bonus"
        }
       
    }
    
    func parallaxOffset(newOffsetY: CGFloat, cell: UITableViewCell) -> CGFloat {
        return (newOffsetY - cell.frame.origin.y) / parallaxImageHeight * parallaxOffsetSpeed
    }
    
    
    func grabLocationData() {
        
        let context = appDelegate.persistentContainer.viewContext
        locations = []
        do {
            locationResults = try context.fetch(requestLocation)
            if locationResults.count > 0 {
                for result in locationResults {
                    locations.append(result as! Location)
                }
            }
        } catch {
            // handle error
        }
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
   
    
    func sortLocationData() {
        sortedLocations = locations.sorted(by: { $0.id < $1.id })
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = sortedLocations[indexPath.row]

            if let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as? LocationCell {
                cell.configureCell(location: location, currentHighestLocation: users[0].currentHighestLocation)
                cell.imageTop.constant = parallaxOffset(newOffsetY: tableView.contentOffset.y, cell: cell)
                cell.selectionStyle = .none
                cell.locationPricesLbl.tag = indexPath.row
                cell.isUserInteractionEnabled = true 
                return cell
            } else {
                return LocationCell()
            }
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = tableView.contentOffset.y
        for cell in tableView.visibleCells as! [LocationCell] {
            cell.imageTop.constant = parallaxOffset(newOffsetY: tableView.contentOffset.y, cell: cell)
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
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let location = sortedLocations[indexPath.row]
        
        cellForLoot = tableView.cellForRow(at: indexPath) as! LocationCell!
        indexPathForLoot = tableView.indexPath(for: cellForLoot!)
        rectForLoot = self.tableView.rectForRow(at: indexPathForLoot!)
        rectInScreenForLoot = self.tableView.convert(rectForLoot, to: tableView.superview)
 
        
        if wallet[0].totalLootAmount >= Double(location.amountToUnlock) && !location.isUnlocked && (location.id  <= users[0].currentHighestLocation + 1) {
            location.isUnlocked = true
            location.isCurrent = true
            users[0].currentHighestLocation = location.id
            
            for location1 in locations {
                if location1.id == location.id {
                    location1.isCurrent = true
              
                } else {
                    location1.isCurrent = false
                
                }
            }
            
            wallet[0].totalLootAmount -= Double(location.amountToUnlock)
            users[0].currentLocation = location.id
            users[0].currentLevelPoints += 1
            
            playPurchaseSoundEffect()
           
            _ = UIScreen.main.bounds.width / 5
            
            for _ in 1...30 {
                autoreleasepool {
                   boolean = Bool.random()
                   boolean2 = Bool.random()
                    
                    let imageViewForSingleLoot = UIImageView(image: imageForSingleLoot!)
                    
                    imageViewForSingleLoot.frame = CGRect(x: rectInScreenForLoot.origin.x + (rectInScreenForLoot.width / 2 ), y: rectInScreenForLoot.origin.y + (rectInScreenForLoot.height / 2 ) , width: 40, height: 40)
                    self.view.addSubview(imageViewForSingleLoot)
                    
                    randomInt = Int.random(in: 50..<500 )
                    randomInt2 = Int.random(in: 50..<500)
                    
                    UIView.animate(withDuration: 0.8, animations: {
                        
                        if self.boolean {
                            imageViewForSingleLoot.frame.origin.x += CGFloat(self.randomInt)
                            
                        } else {
                            imageViewForSingleLoot.frame.origin.x -= CGFloat(self.randomInt)
                        }
                        
                        if self.boolean2 {
                            imageViewForSingleLoot.frame.origin.y += CGFloat(self.randomInt2)
                        } else {
                            imageViewForSingleLoot.frame.origin.y -= CGFloat(self.randomInt2)
                        }
                        
                    }) { (finished) in
                        UIView.animate(withDuration: 0.8, animations: {
                            imageViewForSingleLoot.alpha = 0
                            imageViewForSingleLoot.frame.origin.y += 1000
                        }) { (finished) in
                            imageViewForSingleLoot.removeFromSuperview()
                        }
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
                if self.interstitial.isReady {
                    self.interstitial.present(fromRootViewController: self)
                } else {
                    print("Ad wasn't ready")
                }
            }
            
          
            
            

        } else if location.isUnlocked {
            users[0].currentLocation = location.id
            location.isCurrent = true
            
            for location1 in locations {
                if location1.id == location.id {
                    location1.isCurrent = true
                } else {
                    location1.isCurrent = false
                }
            }

        }

            let context = appDelegate.persistentContainer.viewContext
            
            do {
                try context.save()
                updatePointLabels()
                updateCollectBonusLbl()
                grabLocationData()
                sortLocationData()
                tableView.reloadData()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeLocationImage"), object: nil, userInfo: nil)
               
            } catch {
                
            }
    }
    
    @IBAction func collectViewTapped(_ sender: Any) {
        if (users[0].currentPiratePoints + users[0].currentLevelPoints >= 1) {
            redeemView.isHidden = false
            blackOverlay.isHidden = false
            exitBtn.isHidden = false
        }
       // collectView.isHidden = false
       

    }
    
    func animateCoins() {
        for _ in 1...30 {
            autoreleasepool {
                boolean = Bool.random()
                boolean2 = Bool.random()
                
                
                let imageViewForSingleLoot = UIImageView(image: imageForSingleLoot!)
                
                imageViewForSingleLoot.frame = CGRect(x: UIScreen.main.bounds.width / 2 , y: UIScreen.main.bounds.height / 2  , width: 40, height: 40)
                self.view.addSubview(imageViewForSingleLoot)
                
                let randomInt = Int.random(in: 50..<500)
                let randomInt2 = Int.random(in: 50..<500)
                
                UIView.animate(withDuration: 0.8, animations: {
                    
                    if self.boolean {
                        imageViewForSingleLoot.frame.origin.x += CGFloat(randomInt)
                        
                    } else {
                        imageViewForSingleLoot.frame.origin.x -= CGFloat(randomInt)
                    }
                    
                    if self.boolean2 {
                        imageViewForSingleLoot.frame.origin.y += CGFloat(randomInt2)
                    } else {
                        imageViewForSingleLoot.frame.origin.y -= CGFloat(randomInt2)
                    }
                    
                }) { (finished) in
                    UIView.animate(withDuration: 0.7, animations: {
                        
                        imageViewForSingleLoot.frame.origin.y -= 1000
                    }) { (finished) in
                        imageViewForSingleLoot.removeFromSuperview()
                    }
                }
            }
            
        }
    }
    
    @IBAction func redeemViewTapped(_ sender: Any) {
        redeemView.isHidden = true
        blackOverlay.isHidden = true
        exitBtn.isHidden = true
        
        users[0].levelPoints = users[0].levelPoints + users[0].currentLevelPoints
        users[0].piratePoints = users[0].piratePoints + users[0].currentPiratePoints
        
        users[0].bonusAmount = Double(Double(users[0].piratePoints * users[0].levelPoints).rounded() / 100)
        for location in locations {
            if location.id == 0 {
                location.isUnlocked = true
                location.isCurrent = true
            } else {
                location.isUnlocked = false
                location.isCurrent = false
            }
        }
        users[0].currentHighestLocation = 0 
        users[0].currentLevelPoints = 0
        users[0].currentPiratePoints = 0
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        
        do {
            try context.save()
            updateBonusLabel()
            updateCollectBonusLbl()
            updatePointLabels()
            grabLocationData()
            sortLocationData()
            animateCoins()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resetPirateFromLocation"), object: nil, userInfo: nil)
            tableView.reloadData()
        } catch {
            
        }
    }
    
    @IBAction func exitRedeemPressed(_ sender: Any) {
        blackOverlay.isHidden = true
        redeemView.isHidden = true
        exitBtn.isHidden = true
    }
    

    @IBAction func exitLocationPressed(_ sender: Any) {
        playPopSoundEffect()
        self.dismiss(animated: true, completion: nil)
    }
    

}
