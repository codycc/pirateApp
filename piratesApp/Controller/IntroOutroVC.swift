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

    override func viewDidLoad() {
        super.viewDidLoad()

        showIfUserIsOnFirstUse()
        print("IN VIEW CONTROLLER")
        // Do any additional setup after loading the view.
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
        self.dismiss(animated: true) {
            self.gameBeatLbl.text = "CONGRATS MATE! YOU HAVE JUST BEAT THE GAME! TO REPLAY, PLEASE REDOWNLOAD THE APP! CHEERS!"
        }
        
    }
    

}
