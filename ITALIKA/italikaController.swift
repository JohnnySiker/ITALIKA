//
//  italikaController.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 04/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit

class italikaController: UIViewController {
    
    
    @IBAction func openItalika(sender: UIButton) {
        let url = NSURL(string: "http://www.italika.mx")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func goToInstagram(sender: UIButton) {
        let url = NSURL(string: "https://www.instagram.com/italikaoficial/")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    @IBAction func goToTwitter(sender: UIButton) {
        let url = NSURL(string: "https://twitter.com/ItalikaOficial")
        UIApplication.sharedApplication().openURL(url!)
    }

    @IBAction func goToFacebook(sender: UIButton) {
        let url = NSURL(string: "https://www.facebook.com/ItalikaOficial")
        UIApplication.sharedApplication().openURL(url!)
    }
}
