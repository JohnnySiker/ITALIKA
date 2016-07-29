//
//  SiniestroController.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 05/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit

class SiniestroController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func back(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
 

}
