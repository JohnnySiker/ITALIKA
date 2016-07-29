//
//  TiendaController.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 04/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit
enum TiendaState {
    case models,accesories,refactions
}

class TiendaController: UIViewController,SWRevealViewControllerDelegate {
    
    
    @IBOutlet weak var btn_menu: UIButton!
    
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    
    var swipeLeft: UISwipeGestureRecognizer!
    var swipeRight: UISwipeGestureRecognizer!
    
    var stateTienda = TiendaState.models {
        didSet{
            switch stateTienda {
            case .models:
                becomeModels()
            case .accesories:
                becomeAccesories()
            case .refactions:
                becomeRefection()
            }
        }
    }
    
    
    override func viewDidLoad() {
        self.revealViewController().delegate = self
        //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        btn_menu.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: .TouchUpInside)
        
        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(TiendaController.goLeft))
        swipeLeft.direction = .Left
        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(TiendaController.goRight))
        swipeRight.direction = .Right
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func goRight() {
        if stateTienda == .refactions {
            return
        }
        if stateTienda == .models {
            stateTienda = .accesories
            return
        }
        if stateTienda == .accesories {
            stateTienda = .refactions
            return
        }
        
    }
    
    func goLeft() {
        if stateTienda == .models {
            return
        }
        if stateTienda == .accesories {
            stateTienda = .models
            return
        }
        if stateTienda == .refactions {
            stateTienda = .accesories
            return
        }
    }
    
    
    @IBAction func changeToModels(sender: UIButton) {
        line1.hidden = false
        line2.hidden = true
        line3.hidden = true
        
        label1.text = "XTH\n$25,000"
        label2.text = "250Z\n$25,000"
        img1.image = UIImage(named: "shop1")
        img2.image = UIImage(named: "shop2")
    }
    
    @IBAction func changeToAccesories(sender: UIButton) {
        line1.hidden = true
        line2.hidden = false
        line3.hidden = true
        label1.text = "Caso\n$4,999"
        label2.text = "Aceite\n$300"
        img1.image = UIImage(named: "shop3")
        img2.image = UIImage(named: "shop4")
    }
    
    @IBAction func changeToRefection(sender: UIButton) {
        line1.hidden = true
        line2.hidden = true
        line3.hidden = false
        label1.text = "Frenos\n$15,000"
        label2.text = "Llantas\n$5,000"
        img1.image = UIImage(named: "shop5")
        img2.image = UIImage(named: "shop6")
    }
    
    
    func becomeModels(){
        line1.hidden = false
        line2.hidden = true
        line3.hidden = true
        label1.text = "XTH\n$25,000"
        label2.text = "250Z\n$25,000"
        
        img1.image = UIImage(named: "shop1")
        img2.image = UIImage(named: "shop2")
    }
    
    func becomeAccesories() {
        line1.hidden = true
        line2.hidden = false
        line3.hidden = true
        label1.text = "Caso\n$4,999"
        label2.text = "Aceite\n$300"
        img1.image = UIImage(named: "shop3")
        img2.image = UIImage(named: "shop4")
    }
    
    func becomeRefection() {
        line1.hidden = true
        line2.hidden = true
        line3.hidden = false
        label1.text = "Frenos\n$15,000"
        label2.text = "Llantas\n$5,000"
        img1.image = UIImage(named: "shop5")
        img2.image = UIImage(named: "shop6")
    }
    
}
