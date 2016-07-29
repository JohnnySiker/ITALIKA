//
//  PromoView.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 04/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit

class PromoView: UIViewController {
    
    @IBOutlet weak var iv: UIImageView!
    
    var index:Int!
    var image:String!
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(animated: Bool) {
        if image != nil {
            iv.image = UIImage(named: image)
        }else{
            print("cadena vacia")
        }
    }
    
    func setView(image:String,index:Int) {
        self.image = image
        self.index = index
    }
    
    
}
