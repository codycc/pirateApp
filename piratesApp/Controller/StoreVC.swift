//
//  StoreVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-11-03.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit
import CoreData

class StoreVC: UIViewController {
    
    
    @IBOutlet weak var seagullImage: UIImageView!
    @IBOutlet weak var campFireImage: UIImageView!
    @IBOutlet weak var pelicanImage: UIImageView!
    @IBOutlet weak var vultureImage: UIImageView!
    @IBOutlet weak var koalaImage: UIImageView!
    @IBOutlet weak var shipImage: UIImageView!
    
    @IBOutlet weak var seagullBlueboard: UIImageView!
    
    @IBOutlet weak var campFireBlueboard: UIImageView!
    
    @IBOutlet weak var pelicanBlueboard: UIImageView!
    
    @IBOutlet weak var vultureBlueboard: UIImageView!
    
    @IBOutlet weak var koalaBlueboard: UIImageView!
    
    @IBOutlet weak var shipBlueboard: UIImageView!
    
    
    var users = [User]()
    var wallet = [Wallet]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = appDelegate.persistentContainer.viewContext
        let requestUser = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let requestWallet = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
        
        
        self.seagullImage.isUserInteractionEnabled = true
        self.campFireImage.isUserInteractionEnabled = true
        self.pelicanImage.isUserInteractionEnabled = true
        self.vultureImage.isUserInteractionEnabled = true
        self.koalaImage.isUserInteractionEnabled = true
        self.shipImage.isUserInteractionEnabled = true

        let seagullGesture = UITapGestureRecognizer(target: self, action: #selector(StoreVC.seagullImageTapped(_:)))
        self.seagullImage.addGestureRecognizer(seagullGesture)
        
        let campFireGesture = UITapGestureRecognizer(target: self, action: #selector(StoreVC.campFireImageTapped(_:)))
        self.campFireImage.addGestureRecognizer(campFireGesture)
        
        let pelicanGesture = UITapGestureRecognizer(target: self, action: #selector(StoreVC.pelicanImageTapped(_:)))
        self.pelicanImage.addGestureRecognizer(pelicanGesture)
        
        let vultureGesture = UITapGestureRecognizer(target: self, action: #selector(StoreVC.vultureImageTapped(_:)))
        self.vultureImage.addGestureRecognizer(vultureGesture)
        
        let koalaGesture = UITapGestureRecognizer(target: self, action: #selector(StoreVC.koalaImageTapped(_:)))
        self.koalaImage.addGestureRecognizer(koalaGesture)
        
        let shipGesture = UITapGestureRecognizer(target: self, action: #selector(StoreVC.shipImageTapped(_:)))
        self.shipImage.addGestureRecognizer(shipGesture)
        
        
        
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
    
    
    @IBAction func seagullImageTapped(_ sender: Any) {
        if !users[0].hasSeagull && wallet[0].totalLootAmount >= 500000 {
            wallet[0].totalLootAmount = wallet[0].totalLootAmount - 500000
            users[0].hasSeagull = true
            seagullImage.image = UIImage(named: "purchasedboard")
        }
    }
    
    @IBAction func campFireImageTapped(_ sender: Any) {
        if !users[0].hasCampFire && wallet[0].totalLootAmount >= 750000 {
            wallet[0].totalLootAmount = wallet[0].totalLootAmount - 750000
            users[0].hasCampFire = true
            campFireImage.image = UIImage(named: "purchasedboard")
        }
    }
    
    @IBAction func pelicanImageTapped(_ sender: Any) {
        if !users[0].hasPelican && wallet[0].totalLootAmount >= 850000 {
            wallet[0].totalLootAmount = wallet[0].totalLootAmount - 850000
            users[0].hasPelican = true
            pelicanImage.image = UIImage(named: "purchasedboard")
        }
    }
    
    @IBAction func vultureImageTapped(_ sender: Any) {
        if !users[0].hasVulture && wallet[0].totalLootAmount >= 1000000 {
            wallet[0].totalLootAmount = wallet[0].totalLootAmount - 1000000
            users[0].hasVulture = true
            vultureImage.image = UIImage(named: "purchasedboard")
        }
    }
    
    @IBAction func koalaImageTapped(_ sender: Any) {
        if !users[0].hasKoala && wallet[0].totalLootAmount >= 1500000 {
            wallet[0].totalLootAmount = wallet[0].totalLootAmount - 1500000
            users[0].hasKoala = true
            koalaImage.image = UIImage(named: "purchasedboard")
        }
    }
    
    @IBAction func shipImageTapped(_ sender: Any) {
        if !users[0].hasShip && wallet[0].totalLootAmount >= 3000000 {
            wallet[0].totalLootAmount = wallet[0].totalLootAmount - 3000000
            users[0].hasShip = true
            shipImage.image = UIImage(named: "purchasedboard")
        }
    }
    

    @IBAction func exitIconTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
