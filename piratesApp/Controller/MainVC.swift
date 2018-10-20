//
//  ViewController.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-10-17.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var pirates = [Pirate]()
    
    
    
    
    
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
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("pirate count\(pirates.count)")
        return pirates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pirate = pirates[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PirateCell") as? PirateCell {
            cell.configureCell(pirate: pirate)
            
            return cell
        } else {
            return PirateCell()
        }
    }
    
    
    
    


}

