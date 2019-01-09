//
//  TreasureCollectionVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2019-01-08.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import UIKit
import CoreData

class TreasureCollectionVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
 
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var treasureItemsArray = [Treasure]()
    var sortedTreasureArray = [Treasure]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let requestTreasureItems = NSFetchRequest<NSFetchRequestResult>(entityName: "Treasure")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        grabTreasureItems()
        sortTreasureItemData()
        // Do any additional setup after loading the view.
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: UIScreen.main.bounds.width / 3 - 10)
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
        self.dismiss(animated: true, completion: nil)
    }
    

}
