//
//  ShopVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2019-01-03.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import UIKit
import CoreData

import StoreKit



class ShopVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    @IBOutlet weak var tableView: UITableView!
    
   
   
    
    var storeItems = [StoreItem]()
    var sortedStoreItems = [StoreItem]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let requestStoreItems = NSFetchRequest<NSFetchRequestResult>(entityName: "StoreItem")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        grabStoreItemData()
        sortStoreItemData()
        
        InAppPurchaseService.shared.getProducts()
        // Do any additional setup after loading the view.
    }
    
    func grabStoreItemData() {
        let context = appDelegate.persistentContainer.viewContext
        storeItems = []
        // fetching Wallet Entity from CoreData
        do {
            let results = try context.fetch(requestStoreItems)
            if results.count > 0 {
                for result in results {
                    storeItems.append(result as! StoreItem)
                }
            }
        } catch {
            // handle error
        }
    }
    
    func sortStoreItemData() {
        sortedStoreItems = storeItems.sorted(by: { $0.id < $1.id })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedStoreItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            InAppPurchaseService.shared.purchase(product: .consumable)
        default:
            InAppPurchaseService.shared.restorePurchases()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storeItem = sortedStoreItems[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell") as? StoreCell {
            cell.configureCell(storeItem: storeItem)
            return cell
        } else {
            return StoreCell()
        }
    }

    @IBAction func exitIconTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
