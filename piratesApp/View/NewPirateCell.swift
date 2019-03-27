//
//  NewPirateCell.swift
//  piratesAppRemake
//
//  Created by Cody Condon on 2019-03-11.
//  Copyright © 2019 Cody Condon. All rights reserved.
//

import UIKit

class NewPirateCell: UITableViewCell {

    
    @IBOutlet weak var pirateImg: UIImageView!
    
    @IBOutlet weak var pirateNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(pirate: Pirate) {
        pirateNameLbl.text = pirate.name
        let pirateImage = UIImage(named: "pirate\(pirate.id)idle0")!
        pirateImg.image = pirateImage
    }

}
