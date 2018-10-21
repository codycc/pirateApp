//
//  ViewController.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-10-17.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var plank1: UIImageView!
    @IBOutlet var plank2: UIImageView!
    @IBOutlet var leadingPlankConstraint: NSLayoutConstraint!
    
    var pirates = [Pirate]()
    var sortedPirates = [Pirate]()
    
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Pirate")
        
        request.returnsObjectsAsFaults = false
        
        //fetching coredata
        do {
            let results = try context.fetch(request)
            print("HERE IS RESULTS\(results)")
            if results.count > 0 {
                for result in results {
                    print("HERE IS INDIVIDUAL\(result)")
                    pirates.append(result as! Pirate)
                }
            }
        } catch {
            // handle error
        }
        
        animatePlanks()
        playMusic()
        sortPirates()
    }
    
    func animatePlanks() {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 4, animations: {
            self.plank1.center.x += 100
            
        }, completion: nil)
        
        UIView.animate(withDuration: 2, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 4, animations: {
             self.plank2.center.x += 100
            
        }, completion: nil)
        
        
       
    }
    
    func playMusic() {
        let path = Bundle.main.path(forResource: "piratesmusic", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func sortPirates() {
        sortedPirates = pirates.sorted(by: { $0.id < $1.id})
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("pirate count\(sortedPirates.count)")
        return sortedPirates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pirate = sortedPirates[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PirateCell") as? PirateCell {
            cell.configureCell(pirate: pirate)
            
            return cell
        } else {
            return PirateCell()
        }
    }
    
    
    
    


}

