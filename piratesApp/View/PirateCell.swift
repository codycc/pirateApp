//
//  PirateCell.swift
//  piratesApp
//
//  Created by Cody Condon on 2018-10-20.
//  Copyright © 2018 Cody Condon. All rights reserved.
//

import UIKit

class PirateCell: UITableViewCell {

    @IBOutlet weak var pirateNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(pirate: Pirate) {
        print("pirate name\(pirate.name)")
        self.pirateNameLbl.text = pirate.name
        
    }
}
