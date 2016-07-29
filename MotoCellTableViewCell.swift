//
//  MotoCellTableViewCell.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 05/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit
import FoldingCell

class MotoCellTableViewCell: FoldingCell {

    
    
    override func awakeFromNib() {
        
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        
        
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }


}
