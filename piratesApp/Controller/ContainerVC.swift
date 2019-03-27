//
//  ContainerVC.swift
//  piratesApp
//
//  Created by Cody Condon on 2019-03-05.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {

    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    var sideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    @objc func toggleSideMenu() {
        
        if sideMenuOpen {
            sideMenuOpen = false
            leadingConstraint.constant = 240
        } else {
            sideMenuOpen = true
            leadingConstraint.constant = 0 
        }
    }
    

}
