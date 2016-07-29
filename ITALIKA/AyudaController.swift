//
//  AyudaController.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 04/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit

class AyudaController: UIViewController, SWRevealViewControllerDelegate, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var btn_menu: UIButton!
    
    
    @IBOutlet weak var tb: UITableView!
    var textos = ["Reportar Siniestro","Preguntas frecuentes","Contacto"]
    var imagenes = ["help1","help2","help3"]
    
    override func viewDidLoad() {
        self.revealViewController().delegate = self
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.navigationController?.navigationBar.hidden = true
        
        tb.dataSource = self
        tb.delegate = self
        btn_menu.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: .TouchUpInside)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tb.dequeueReusableCellWithIdentifier("HelpCell") as! HelpCell
        cell.setCell(imagenes[indexPath.row],title:textos[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let nview = self.storyboard?.instantiateViewControllerWithIdentifier("Poliza")
            self.navigationController?.pushViewController(nview!, animated: true)
        case 1:
            let nview = self.storyboard?.instantiateViewControllerWithIdentifier("FAQController")
            self.navigationController?.pushViewController(nview!, animated: true)
            break;
        case 2:
            let nview = self.storyboard?.instantiateViewControllerWithIdentifier("italikaController")
            self.navigationController?.pushViewController(nview!, animated: true)
            break
        default:
            break;
        }
    }
}
