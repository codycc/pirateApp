//
//  DashboardVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2019-01-07.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
    

    @IBOutlet weak var wheelHeight: NSLayoutConstraint!
    @IBOutlet weak var plankLightImg: UIImageView!
    
    @IBOutlet weak var parrotImage: UIImageView!
    @IBOutlet weak var exitBtn: UIButton!
    
    @IBOutlet weak var planksHeight: NSLayoutConstraint!
    @IBOutlet weak var wheelSpinnerHeight: NSLayoutConstraint!

    @IBOutlet weak var wheel: UIImageView!
    @IBOutlet weak var pirateWheel: UIImageView!
    var parrotImages = [UIImage]()
    var totalDegree = 0
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let tapGestureWheel = UITapGestureRecognizer(target: self, action: #selector(DashboardVC.wheelSpinPressed(_:)))
        self.wheel.addGestureRecognizer(tapGestureWheel)
        
        self.wheelHeight.constant = self.view.frame.height / 2 - 50
        self.wheelSpinnerHeight.constant = self.view.frame.height / 2 - 50
        showParrotAnimation()
        animateAxisOfParrot()
        parrotImage.layer.zPosition = 5000
        UIView.animate(withDuration: 20, delay: 0, options: .curveLinear, animations: {
            self.parrotImage.transform = CGAffineTransform(translationX:100 , y: 0)
            
        }) { (true) in
            
        }
        // Do any additional setup after loading the view.
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
                case 37...72:
                    print("youve won 25k loot")
                case 73...108:
                    print("youve won 10k loot ")
                case 109...144:
                    print("youve won 50k loot ")
                case 145...180:
                    print("youve won 2x gems ")
                case 181...216:
                    print("youve won 25k loot")
                case 217...252:
                    print("youve won 1 gem ")
                case 253...288:
                    print("youve won 50k loot ")
                case 289...324:
                    print("youve won25k loot ")
                case 324...360:
                    print("youve won 100k loot")
                default:
                    print("default")
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
