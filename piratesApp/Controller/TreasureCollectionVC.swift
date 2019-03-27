//
//  TreasureCollectionVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2019-01-08.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class TreasureCollectionVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    
    @IBOutlet weak var collectionView: UICollectionView!
    
  
    var treasureItemsArray = [Treasure]()
    var sortedTreasureArray = [Treasure]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let requestTreasureItems = NSFetchRequest<NSFetchRequestResult>(entityName: "Treasure")
    var exitPlayer: AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        grabTreasureItems()
        sortTreasureItemData()
        
      
     
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.collectionView.frame.size.width / 3) - 20 ;
        
        
        return CGSize(width: width, height: width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
    
    func grabTreasureItems() {
        let context = appDelegate.persistentContainer.viewContext
        treasureItemsArray = []
        // fetching Wallet Entity from CoreData
        do {
            let results = try context.fetch(requestTreasureItems)
            if results.count > 0 {
                for result in results {
                    treasureItemsArray.append(result as! Treasure)
                }
            }
        } catch {
            // handle error
        }
    }
    
    func sortTreasureItemData() {
        sortedTreasureArray = treasureItemsArray.sorted(by: { $0.id < $1.id })
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortedTreasureArray.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
////        return CGSize(width: UIScreen.main.bounds.width / 3 - 15, height: UIScreen.main.bounds.width / 3 - 15)
//    }
    
    func playExitSoundEffect() {
        let path = Bundle.main.path(forResource: "pop", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try exitPlayer = AVAudioPlayer(contentsOf: soundUrl as URL)
            exitPlayer.prepareToPlay()
            exitPlayer.volume = 0.3
            exitPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let treasureItem = sortedTreasureArray[indexPath.row]
      
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TreasureCell", for: indexPath) as? TreasureCell {
            cell.configureCell(treasureItem: treasureItem)
            return cell
        } else {
            return TreasureCell()
        }
        
    }
    
    @IBAction func exitBtnTapped(_ sender: Any) {
        playExitSoundEffect()
        self.dismiss(animated: true, completion: nil)
    }
    

}
