//
//  DashboardVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2019-01-07.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class DashboardVC: UIViewController {
    

    @IBOutlet weak var wheelHeight: NSLayoutConstraint!
    @IBOutlet weak var plankLightImg: UIImageView!
    
    @IBOutlet weak var parrotImage: UIImageView!
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var pirateWidth: NSLayoutConstraint!
    
    @IBOutlet weak var pirateHeight: NSLayoutConstraint!
    @IBOutlet weak var planksHeight: NSLayoutConstraint!
    @IBOutlet weak var wheelSpinnerHeight: NSLayoutConstraint!

    @IBOutlet weak var wheel: UIImageView!
    @IBOutlet weak var pirateWheel: UIImageView!
    var parrotImages = [UIImage]()
    var totalDegree = 0
    var walletArray = [Wallet]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
    var lootPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let tapGestureWheel = UITapGestureRecognizer(target: self, action: #selector(DashboardVC.wheelSpinPressed(_:)))
        self.wheel.addGestureRecognizer(tapGestureWheel)
        
        self.wheelHeight.constant = self.view.frame.height / 2 - 50
        self.wheelSpinnerHeight.constant = self.view.frame.height / 2 - 50
        showParrotAnimation()
        animateAxisOfParrot()
        grabWalletData()
        pirateWidth.constant = UIScreen.main.bounds.width / 2
        pirateHeight.constant = UIScreen.main.bounds.height / 3
        // Do any additional setup after loading the view.
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
    
    
    func showParrotAnimation() {
//      parrotImages = []
//
//
//        for x in 0...15 {
//            let img = UIImage(named:"parrot0redfly\(x)")
//            parrotImages.append(img!)
//        }
//        setParrotOverlayImage()
        
    }
    
    func setParrotOverlayImage() {
//        parrotImage.stopAnimating()
//        parrotImage.animationImages = parrotImages
//        parrotImage.animationDuration = 1.3
//        parrotImage.animationRepeatCount = 0
//        parrotImage.startAnimating()
        
    }
    
    func animateAxisOfParrot() {
     
//        UIView.animate(withDuration: 30.0, animations: {
//
//            self.parrotImage.center.x += 100
//        }) { (finished) in
//
//        }
    }
    
    func grabWalletData() {
        let context = appDelegate.persistentContainer.viewContext
        walletArray = []
        // fetching Wallet Entity from CoreData
        do {
            let results = try context.fetch(requestWallet)
            if results.count > 0 {
                for result in results {
                    walletArray.append(result as! Wallet)
                }
            }
        } catch {
            // handle error
        }
    }
    
    func radiansToDegress(radians: CGFloat) -> CGFloat {
        return radians * 180 / CGFloat(Double.pi)
    }
    
    func doWheelSpin() {
        if wheel.isUserInteractionEnabled {
            let rotateView = CABasicAnimation()
            let randonAngle = arc4random_uniform(361) + 1440
            rotateView.fromValue = 1
            rotateView.toValue = Float(randonAngle) * Float(Double.pi) / 100//180.0
            let randomSpeed = 5.0
            rotateView.duration = CFTimeInterval(randomSpeed)
            rotateView.repeatCount = 0
            rotateView.isRemovedOnCompletion = false
            rotateView.fillMode = CAMediaTimingFillMode.forwards
            rotateView.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            pirateWheel.layer.add(rotateView, forKey: "transform.rotation.z")
            self.wheel.isUserInteractionEnabled = false
            
            var testAngle = CGFloat(0)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.6) {
                let transform:CATransform3D = self.pirateWheel.layer.presentation()!.transform
                let angle: CGFloat = atan2(transform.m12, transform.m11)
                testAngle = self.radiansToDegress(radians: angle)
                if testAngle < 0 {
                    testAngle = 360 + testAngle
                }
                self.wheel.isUserInteractionEnabled = true
                print("\(testAngle)")
                switch testAngle {
                case 0...36:
                    print("youve won 1 gem")
                    self.playLootSoundEffect()
                    self.walletArray[0].totalGemsAmount += 1
                case 37...72:
                    print("youve won 25k loot")
                    self.playLootSoundEffect()
                    self.walletArray[0].totalLootAmount += 25000
                case 73...108:
                    print("youve won 10k loot ")
                    self.playLootSoundEffect()
                    self.walletArray[0].totalLootAmount += 10000
                case 109...144:
                    print("youve won 50k loot ")
                    self.playLootSoundEffect()
                    self.walletArray[0].totalLootAmount += 50000
                case 145...180:
                    print("youve won 2x gems ")
                    self.playLootSoundEffect()
                    self.walletArray[0].totalGemsAmount += 2
                case 181...216:
                    print("youve won 25k loot")
                    self.playLootSoundEffect()
                    self.walletArray[0].totalLootAmount += 25000
                case 217...252:
                    print("youve won 1 gem ")
                    self.playLootSoundEffect()
                    self.walletArray[0].totalGemsAmount += 1
                case 253...288:
                    print("youve won 50k loot ")
                    self.playLootSoundEffect()
                    self.walletArray[0].totalLootAmount += 50000
                case 289...324:
                    print("youve won25k loot ")
                    self.playLootSoundEffect()
                    self.walletArray[0].totalLootAmount += 25000
                case 324...360:
                    print("youve won 100k loot")
                    self.playLootSoundEffect()
                    self.walletArray[0].totalLootAmount += 100000
                default:
                    print("default")
                }
                let context = self.appDelegate.persistentContainer.viewContext
                do {
                    try context.save()
                } catch {
                    
                }
            }
            
            
        }
 
    }
    
    
    
    @IBAction func wheelSpinPressed(_ sender: Any) {
       doWheelSpin()
      
      
        // Here is the helper function
        
       
    
    }
    

    @IBAction func exitBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
}
