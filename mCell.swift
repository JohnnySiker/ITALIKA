//
//  mCell.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 05/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit

class mCell: UITableViewCell {

    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firtsLabel: UILabel!
    @IBOutlet weak var iv: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell( model:String, placas:String) {
        iv.image = UIImage(named: "TC200")
        firtsLabel.text = model
        secondLabel.text = placas
    }

}
