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
        
        checkWhatItemsAreBought()
        
    }
    
    func checkWhatItemsAreBought() {
        if users[0].hasSeagull {
            seagullImage.isUserInteractionEnabled = false
            seagullImage.alpha = 0.6
            seagullBlueboard.image = UIImage(named: "purchasedboard")
        }
        
        if users[0].hasCampFire {
            campFireImage.isUserInteractionEnabled = false
            campFireImage.alpha = 0.6
            campFireBlueboard.image = UIImage(named: "purchasedboard")
        }
        
        if users[0].hasPelican {
            pelicanImage.isUserInteractionEnabled = false
            pelicanImage.alpha = 0.6
            pelicanBlueboard.image = UIImage(named: "purchasedboard")
        }
        
        if users[0].hasVulture {
            vultureImage.isUserInteractionEnabled = false
            vultureImage.alpha = 0.6
            vultureBlueboard.image = UIImage(named: "purchasedboard")
        }
        
        if users[0].hasKoala {
            koalaImage.isUserInteractionEnabled = false
            koalaImage.alpha = 0.6
            koalaBlueboard.image = UIImage(named: "purchasedboard")
        }
        
        if users[0].hasShip {
            shipImage.isUserInteractionEnabled = false
            shipImage.alpha = 0.6
            shipBlueboard.image = UIImage(named: "purchasedboard")
            
        }
    }
    
    
    @IBAction func seagullImageTapped(_ sender: Any) {
        
        if !users[0].hasSeagull && wallet[0].totalLootAmount >= 500000 {
            wallet[0].totalLootAmount = wallet[0].totalLootAmount - 500000
            users[0].hasSeagull = true
            seagullBlueboard.image = UIImage(named: "purchasedboard")
            seagullImage.alpha = 0.7
            
            let context = appDelegate.persistentContainer.viewContext
            do {
                try context.save()
            } catch {
                
            }
        }
    }
    
    @IBAction func campFireImageTapped(_ sender: Any) {
        if !users[0].hasCampFire && wallet[0].totalLootAmount >= 750000 {
            wallet[0].totalLootAmount = wallet[0].totalLootAmount - 750000
            users[0].hasCampFire = true
            campFireBlueboard.image = UIImage(named: "purchasedboard")
            campFireImage.alpha = 0.7
            
            let context = appDelegate.persistentContainer.viewContext
            do {
                try context.save()
            } catch {
                
            }
        }
    }
    
    @IBAction func pelicanImageTapped(_ sender: Any) {
        if !users[0].hasPelican && wallet[0].totalLootAmount >= 850000 {
            wallet[0].totalLootAmount = wallet[0].totalLootAmount - 850000
            users[0].hasPelican = true
            pelicanBlueboard.image = UIImage(named: "purchasedboard")
            pelicanImage.alpha = 0.7
            
            let context = appDelegate.persistentContainer.viewContext
            do {
                try context.save()
            } catch {
                
            }
        }
    }
    
    @IBAction func vultureImageTapped(_ sender: Any) {
        if !users[0].hasVulture && wallet[0].totalLootAmount >= 1000000 {
            wallet[0].totalLootAmount = wallet[0].totalLootAmount - 1000000
            users[0].hasVulture = true
            vultureBlueboard.image = UIImage(named: "purchasedboard")
            vultureImage.alpha = 0.7
            
            let context = appDelegate.persistentContainer.viewContext
            do {
                try context.save()
            } catch {
                
            }
        }
    }
    
    @IBAction func koalaImageTapped(_ sender: Any) {
        if !users[0].hasKoala && wallet[0].totalLootAmount >= 1500000 {
            wallet[0].totalLootAmount = wallet[0].totalLootAmount - 1500000
            users[0].hasKoala = true
            koalaBlueboard.image = UIImage(named: "purchasedboard")
            koalaImage.alpha = 0.7
            
            let context = appDelegate.persistentContainer.viewContext
            do {
                try context.save()
            } catch {
                
            }
        }
    }
    
    @IBAction func shipImageTapped(_ sender: Any) {
        if !users[0].hasShip && wallet[0].totalLootAmount >= 3000000 {
            wallet[0].totalLootAmount = wallet[0].totalLootAmount - 3000000
            users[0].hasShip = true
            shipBlueboard.image = UIImage(named: "purchasedboard")
            shipImage.alpha = 0.7
            
            let context = appDelegate.persistentContainer.viewContext
            do {
                try context.save()
            } catch {
                
            }
        }
    }
    

    @IBAction func exitIconTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
