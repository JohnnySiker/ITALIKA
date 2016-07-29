//
//  MenuController.swift
//  
//
//  Created by Jonathan Velazquez on 04/06/16.
//
//

import UIKit
import AlamofireImage
import Alamofire

class MenuController: UIViewController {
    
    @IBOutlet weak var btn_clima: UIButton!
    
    @IBOutlet weak var lblClima: UILabel!
    @IBOutlet weak var iv: CircularImage!
    var clima = true
    
    override func viewDidLoad() {
        Alamofire.request(.GET, User.currentUser.imgURL).responseImage { response in
            
            if let im = response.result.value {
                self.iv.image = im
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
 
    
    @IBAction func changeToDegrees(sender: UIButton) {
        
        if clima {
            sender.setBackgroundImage(UIImage(), forState: .Normal)
            lblClima.hidden = false
            clima = false
        }else{
            sender.setBackgroundImage(UIImage(named: "cloudIcon"), forState: .Normal)
            lblClima.hidden = true
            clima = true
        }
        
    }
    
    @IBAction func logout(sender: UIButton) {
         FBSDKLoginManager().logOut()
        let nv = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController")
        UIApplication.sharedApplication().keyWindow?.rootViewController = nv
    }
    
}
