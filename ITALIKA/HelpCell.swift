//
//  HelpCell.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 04/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit

class HelpCell: UITableViewCell {
    
    @IBOutlet weak var iv: UIImageView!
    @IBOutlet weak var textL: UILabel!
    
    
    func setCell(image:String,title:String) {
        iv.image = UIImage(named: image)
        textL.text = title
    }
}
