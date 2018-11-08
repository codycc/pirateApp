//
//  IntroOutroVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-11-05.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit
import AVFoundation



class IntroOutroVC: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet var gameBeatLbl: UILabel!
    @IBOutlet var gameBeatView: UIView!
    @IBOutlet weak var nextBtn: UIButton!

    @IBOutlet weak var tutorialLabel: UILabel!
    
    @IBOutlet weak var tutorialImage: UIImageView!
    
    @IBOutlet weak var exitBtn: UIButton!
    
    var popPlayer: AVAudioPlayer!
    
    var imagesArray = ["TUTORIAL1","TUTORIAL2","TUTORIAL3"]
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        exitBtn.isUserInteractionEnabled = false
        exitBtn.alpha = 0.5
        showIfUserIsOnFirstUse()
        print("IN VIEW CONTROLLER")
        // Do any additional setup after loading the view.
    }
    
    func playPopSoundEffect() {
        let path = Bundle.main.path(forResource: "pop", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try popPlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            popPlayer.prepareToPlay()
            popPlayer.volume = 0.3
            popPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func showIfUserIsOnFirstUse() {
        let isFirstUse = UserDefaults.standard.bool(forKey: "isFirstUse")
        if isFirstUse {
            self.gameBeatLbl.text = "AHOY MATEY! WELCOME TO PIRATE LOOTER. THE IDLE GAME THAT ALLOWS YOU TO LOOT THE SEAS. THE GOAL IS TO GET 100 OF EACH PIRATE! CHEERS!"
            UserDefaults.standard.set(false, forKey: "isFirstUse")
        }
    }
    
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        //go to main vc
        playPopSoundEffect()
        self.dismiss(animated: true) {
            self.gameBeatLbl.text = "CONGRATS MATE! YOU HAVE JUST BEAT THE GAME! TO REPLAY, PLEASE REDOWNLOAD THE APP! CHEERS!"
            self.tutorialLabel.isHidden = true
            self.gameBeatView.alpha = 0.7
            self.tutorialImage.isHidden = true
            self.gameBeatLbl.isHidden = false
        }
        
    }
    
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        playPopSoundEffect()
       
        tutorialLabel.isHidden = false
        tutorialImage.isHidden = false
        gameBeatView.alpha = 0.9
        tutorialImage.image = UIImage(named: imagesArray[count])
        count += 1
        if count == 3 {
            exitBtn.isUserInteractionEnabled = true
            exitBtn.alpha = 1.0
            nextBtn.isUserInteractionEnabled = false
            nextBtn.alpha = 0
        }
        
    }
    

}
