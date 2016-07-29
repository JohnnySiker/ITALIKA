//
//  SettingsController.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 05/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit

class SettingsController: UIViewController,SWRevealViewControllerDelegate {
    @IBOutlet weak var btn_menu: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().delegate = self
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        // Do any additional setup after loading the view.
        btn_menu.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
