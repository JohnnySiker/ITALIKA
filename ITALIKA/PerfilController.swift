//
//  PerfilController.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 04/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit



class PerfilController: UIViewController,SWRevealViewControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var perfilView: UIView!
    @IBOutlet weak var motosView: UIView!
    
    @IBOutlet weak var viewPerfil: UIView!
    @IBOutlet weak var viewMoto: UIView!
    
    @IBOutlet weak var btn_menu: UIButton!
    
    var swipeLeft:UISwipeGestureRecognizer!
    var swipeRight:UISwipeGestureRecognizer!
    
    @IBOutlet weak var tb: UITableView!
    
    var count = 1
    
    override func viewDidLoad() {
        self.revealViewController().delegate = self
        //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        btn_menu.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: .TouchUpInside)
        
        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(PerfilController.changeProfile))
        swipeLeft.direction = .Left
        
        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(PerfilController.changeMotos))
        swipeRight.direction = .Right
        self.perfilView.addGestureRecognizer(swipeRight)
        self.motosView.addGestureRecognizer(swipeLeft)
        tb.delegate = self
        tb.dataSource = self
    }
    
    @IBAction func changeToProfile() {
        perfilView.hidden = false
        motosView.hidden = true
        
        viewPerfil.hidden = false
        viewMoto.hidden = true
    }
    func changeProfile() {
        perfilView.hidden = false
        motosView.hidden = true
        
        viewPerfil.hidden = false
        viewMoto.hidden = true
    }
    
    @IBAction func changeToMotos() {
        perfilView.hidden = true
        motosView.hidden =  false
        
        viewPerfil.hidden = true
        viewMoto.hidden = false
    }
    func changeMotos(){
        perfilView.hidden = true
        motosView.hidden =  false
        
        viewPerfil.hidden = true
        viewMoto.hidden = false
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tb.dequeueReusableCellWithIdentifier("mCell") as! mCell
        cell.setCell("TC200", placas: "ITALYKA FTS1530")
        return cell
    }
    
    @IBAction func addMotor(sender: UIButton) {
        count++
        tb.reloadData()
    }
    
}


