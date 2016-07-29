//
//  MotoDescriptorController.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 04/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit

class MotoDescriptorController: UIViewController {
    
    @IBOutlet weak var iv: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var image:String!
    var index:Int!
    var descripcion: String!
    
    override func viewDidLoad() {
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        if image != nil {
            iv.image = UIImage(named: image)
            label.text = descripcion
        }else{
            print("cadena vacia")
        }
    }
    func setView(image:String,descripcion:String,index:Int) {
        self.image = image
        self.index = index
        self.descripcion = descripcion
    }
    
}
