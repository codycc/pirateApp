//
//  StatsVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-11-05.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit

class StatsVC: UIViewController {

    @IBOutlet var pirateNameInforLbl: UILabel!
    @IBOutlet var informationStackView: UIStackView!
    @IBOutlet var pirateTotalLbl: UILabel!
    @IBOutlet var lootPerSessionLbl: UILabel!
    @IBOutlet var piratePriceLbl: UILabel!
    @IBOutlet var lootingTimeLbl: UILabel!
    @IBOutlet var panDownView: UIView!
    @IBOutlet var pirateImageOverlay: UIImageView!
    @IBOutlet var piratePanDownViewImage: NSLayoutConstraint!
    var pirate: Pirate!
    var pirateImgArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lowerPanDownView(pirate: pirate)
    }
    
    func updatePirateFightingImage(pirate: Pirate) {
        pirateImgArray = []
        pirateImageOverlay.stopAnimating()
        
        for x in 0...14 {
            let img = UIImage(named:"pirate\(pirate.id)attack\(x)")
            pirateImgArray.append(img!)
        }
        setPirateOverlayImage()
    }
    
    
    func setPirateOverlayImage() {
        pirateImageOverlay.stopAnimating()
        pirateImageOverlay.animationImages = pirateImgArray
        pirateImageOverlay.animationDuration = 1.3
        pirateImageOverlay.animationRepeatCount = 0
        pirateImageOverlay.startAnimating()
    }
    
    
    func updateStackViewInformation(pirate:Pirate) {
        let pirateLootTimeInSeconds = pirate.lootTime
        let hours = Int(pirateLootTimeInSeconds) / 3600
        let minutes = Int(pirateLootTimeInSeconds) / 60 % 60
        let seconds = Int(pirateLootTimeInSeconds) % 60
        
        self.pirateNameInforLbl.text = pirate.name
        self.pirateTotalLbl.text = "\(pirate.numberOfPirates)"
        self.lootPerSessionLbl.text = String(format: "$%.2f", pirate.lootAmount)
        self.piratePriceLbl.text = String(format: "$%.2f", pirate.piratePrice)
        
        self.lootingTimeLbl.text = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        
    }
    
    func lowerPanDownView(pirate: Pirate) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 4, animations: {
            self.panDownView.center.y += 380
            
        }, completion: { finished in
            UIView.animate(withDuration: 0.5, animations: {
            }, completion: { finished in
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

    }
    
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
