//
//  ExploreVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-12-20.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit


class ExploreVC: UIViewController {
    
    @IBOutlet weak var mainBackground: UIImageView!
    
    @IBOutlet weak var jumpBtn: UIButton!
    
    @IBOutlet weak var startBtn: UIButton!
    
    var isRunning = true
    var count = 0
    var count2 = 0
    var toRunProgram = true
    var pirateHeight = 0
    var pirateWidth = 0
    var groundHeight = 0
    var pirateImgArray = [UIImage]()
    var pirateJumpArray = [UIImage]()
    var imageForPirate: UIImageView!

    var pirateIsJumping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPirateJumpArray()
        createPirateRunArray()
        // Do any additional setup after loading the view.
    }
    

    
    func createPirate() {
        pirateHeight = Int(UIScreen.main.bounds.height / 3)
        pirateWidth = Int(UIScreen.main.bounds.height / 3)
        if isRunning {
            let imageName = "pirate2idle0.png"
            let image = UIImage(named: imageName)
            imageForPirate = UIImageView(image: image!)
            imageForPirate.frame = CGRect(x: 50 , y: UIScreen.main.bounds.height - CGFloat((pirateHeight)) - CGFloat(groundHeight - 5) + (CGFloat(pirateHeight / 5)) , width: (UIScreen.main.bounds.height / 3) * 0.95 , height: UIScreen.main.bounds.height / 3)
            imageForPirate.contentMode = .scaleToFill
        
            imageForPirate.layer.zPosition = 2000
            self.view.addSubview(imageForPirate)
        pirateRun()
        }
    }
    
    func createLootTimer() {
        let timerLoot = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(createLoot), userInfo: nil, repeats: true)
        
    }
    
    @objc func createLoot() {
        let imageName = "singleLoot.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: UIScreen.main.bounds.width , y: (UIScreen.main.bounds.height / 2)  , width: 70  , height: 70 )
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        imageView.layer.zPosition = 10000
        UIView.animate(withDuration: 5, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            imageView.center.x -= UIScreen.main.bounds.width
          
          
        }) { (finished) in
            imageView.removeFromSuperview()
        }
    }
    
    
    func pirateRun() {
        imageForPirate.animationImages = []
        imageForPirate.stopAnimating()
        imageForPirate.animationImages = pirateImgArray
        imageForPirate.animationDuration = 1.0
        imageForPirate.animationRepeatCount = -1
        imageForPirate.startAnimating()
    }
    
    
//
    @objc func createMovingGround() {
        groundHeight = Int(UIScreen.main.bounds.height / 10)
        if isRunning {
            
            let imageName = "ground1.png"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: UIScreen.main.bounds.width , y: UIScreen.main.bounds.height - CGFloat(groundHeight) , width: UIScreen.main.bounds.width   , height: UIScreen.main.bounds.height / 10)
            imageView.contentMode = .scaleToFill
            self.view.addSubview(imageView)

            UIView.animate(withDuration: 3, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                imageView.center.x -= UIScreen.main.bounds.width * 2
                self.count += 1
                if self.count == 100 {
                    self.isRunning = false
                }
            }) { (finished) in
                
                 imageView.removeFromSuperview()
            }


         

        }

    }
    
    @objc func createMovingMiddle() {
        if isRunning {
        let imageName = "middlelayer.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: UIScreen.main.bounds.width , y: 0 , width: UIScreen.main.bounds.width  , height: UIScreen.main.bounds.height )
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)

        UIView.animate(withDuration: 10, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            imageView.center.x -= UIScreen.main.bounds.width * 2
            self.count += 1
            if self.count == 100 {
                self.isRunning = false
            }
        }) { (finished) in
            imageView.removeFromSuperview()
        }


//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                self.createMovingMiddle()
//            }

        }

    }
    
    @objc func createMovingMiddle2() {
        if isRunning {
            let imageName = "middle2layer.png"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: UIScreen.main.bounds.width , y: (UIScreen.main.bounds.height / 3) - 50 , width: UIScreen.main.bounds.width  , height: ((UIScreen.main.bounds.height / 3) * 2) - 50 )
            imageView.contentMode = .scaleToFill
            self.view.addSubview(imageView)

            UIView.animate(withDuration: 10, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                imageView.center.x -= UIScreen.main.bounds.width * 2
                self.count += 1
                if self.count == 100 {
                    self.isRunning = false
                }
            }) { (finished) in
                imageView.removeFromSuperview()
            }


        }

    }
    
    
    
    @objc func createMovingMiddle3() {
        //background mountaints
        if isRunning {
            let imageName = "backlayer.png"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: UIScreen.main.bounds.width , y: 0 , width: UIScreen.main.bounds.width  , height: (UIScreen.main.bounds.height) - 101 )
            imageView.contentMode = .scaleToFill
            self.view.addSubview(imageView)
            
            UIView.animate(withDuration: 20, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                imageView.center.x -= UIScreen.main.bounds.width * 2
                self.count += 1
                if self.count == 100 {
                    self.isRunning = false
                }
            }) { (finished) in
                imageView.removeFromSuperview()
            }
            
            
        }
        
    }
//    func createMiddleLayer() {
//
//        let image = UIImage(named: imageName)
//        let imageView = UIImageView(image: image!)
//        imageView.contentMode = .scaleAspectFit
//        imageView.frame = CGRect(x: 0 , y: 0 , width: UIScreen.main.bounds.width  , height: UIScreen.main.bounds.height  )
//        self.view.addSubview(imageView)
//    }
    
    func createMiddle2Layer() {
        let imageName = "middle2layer.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleToFill
        imageView.frame = CGRect(x: 0  , y: 0 + UIScreen.main.bounds.height / 3 , width: UIScreen.main.bounds.width  , height: UIScreen.main.bounds.height / 3 * 2  )
        self.view.addSubview(imageView)
    }

    func createBackLayer() {
        let imageName = "backlayer.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleToFill
        imageView.frame = CGRect(x: 0 , y: 0 , width: UIScreen.main.bounds.width  , height: UIScreen.main.bounds.height  )
        self.view.addSubview(imageView)
    }
    
    func createPirateJumpArray() {
        for x in 0...15 {
            let img = UIImage(named:"pirate0jump\(x)")
            pirateJumpArray.append(img!)
            
        }
    }
    func createPirateRunArray() {
        for x in 0...15 {
            let img = UIImage(named:"pirate\(0)run\(x)")
            pirateImgArray.append(img!)
        }
    }
//

    func movePirateAxis() {
        UIView.animate(withDuration: 0.5, animations: {
            self.imageForPirate.center.y -= 150
        }) { (finished) in
            UIView.animate(withDuration: 0.5, animations: {
                self.imageForPirate.center.y += 150
            }, completion: { (finished) in
                print("test")
            })
        }
    }
    
    @IBAction func jumpBtnPressed(_ sender: Any) {
        movePirateAxis()
        imageForPirate.animationImages = []
        imageForPirate.stopAnimating()
        imageForPirate.animationImages = pirateJumpArray
        imageForPirate.animationDuration = 1.0
        imageForPirate.animationRepeatCount = -1
        imageForPirate.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.pirateRun()
        }

    }
    
    @IBAction func startBtnPressed(_ sender: Any) {
        jumpBtn.isEnabled = true
        jumpBtn.isHidden = false
        startBtn.isEnabled = false
        startBtn.isHidden = true
        createBackLayer()
        createMovingMiddle()
        createMiddle2Layer()
        createMovingGround()
        createPirate()
        createLoot()
        let timer4 = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(createMovingMiddle3), userInfo: nil, repeats: true)
        
        let timer3 = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(createMovingMiddle2), userInfo: nil, repeats: true)
        
        let timer = Timer.scheduledTimer(timeInterval: 1.4, target: self, selector: #selector(createMovingGround), userInfo: nil, repeats: true)
        
        let timer2 = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(createMovingMiddle), userInfo: nil, repeats: true)
        
        
    }
    

}


