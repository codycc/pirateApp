//
//  OfflineBonusVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-11-05.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit

import Firebase
import GoogleMobileAds

class OfflineBonusVC: UIViewController {

    @IBOutlet var offlineNonAdLbl: UILabel!
    
    @IBOutlet var offlineAdLbl: UILabel!
    
    @IBOutlet var blueboardAd: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //offlineNonAdLbl.text = String(format: "$%.2f", amountOfMoneyMade)
        //offlineAdLbl.text = String(format: "$%.2f", amountOfMoneyMade * 2)

        
        let tapGestureNonAd = UITapGestureRecognizer(target: self, action: #selector(OfflineBonusVC.offlineNonAdLabelPressed(_:)))
        self.offlineNonAdLbl.addGestureRecognizer(tapGestureNonAd)
        
        let tapGestureAd = UITapGestureRecognizer(target: self, action: #selector(OfflineBonusVC.offlineAdLabelPressed(_:)))
        self.offlineAdLbl.addGestureRecognizer(tapGestureAd)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func offlineAdLabelPressed(_ sender: Any) {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
        self.dismiss(animated: true, completion: nil)
       
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        self.blueboardAd.alpha = 1
        self.offlineAdLbl.alpha = 1
        self.offlineAdLbl.isUserInteractionEnabled = true
    }
    
    
    @IBAction func offlineNonAdLabelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }

}
