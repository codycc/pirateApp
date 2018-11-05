//
//  IntroOutroVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-11-05.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit
import AVFoundation



class IntroOutroVC: UIViewController {
    @IBOutlet var gameBeatLbl: UILabel!
    @IBOutlet var gameBeatView: UIView!
    
    var amountOfMoneyMade = 0.0
    var ahoyPlayer: AVAudioPlayer!
    let ahoyPath = Bundle.main.path(forResource: "ahoy", ofType: "wav")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIfUserIsOnFirstUse()
        // Do any additional setup after loading the view.
    }
    
    func playAhoySoundEffect() {
        let ahoySoundUrl = NSURL(fileURLWithPath: ahoyPath!)
        do {
            try ahoyPlayer = AVAudioPlayer(contentsOf: ahoySoundUrl as URL)
            ahoyPlayer.prepareToPlay()
            ahoyPlayer.volume = 0.4
            ahoyPlayer.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    func showIfUserIsOnFirstUse() {
        let isFirstUse = UserDefaults.standard.bool(forKey: "isFirstUse")
        if isFirstUse {
            self.gameBeatLbl.text = "Ahoy Mate!, Welcome to Pirate Looter! The idle game where you can hire pirates! The goal is to get 100 of each pirate, Cheers!"
            UserDefaults.standard.set(false, forKey: "isFirstUse")
        }
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        //go to main vc
        playAhoySoundEffect()
        self.gameBeatLbl.text = "CONGRATS MATE! YOU HAVE JUST BEAT THE GAME! TO REPLAY, PLEASE REDOWNLOAD THE APP! CHEERS!"
        self.dismiss(animated: true, completion: nil)
    }
    

}
