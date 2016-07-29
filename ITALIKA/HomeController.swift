//
//  HomeController.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 04/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit

class HomeController: UIViewController,SWRevealViewControllerDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController!
    var pageImage:[String] = ["Banner1","Banner2","Banner3","Banner4"]
   
    @IBOutlet weak var btn_menu: UIButton!
    
    @IBOutlet weak var pager1: UIView!
    @IBOutlet weak var pager2: UIView!
    
    override func viewDidLoad() {
        self.revealViewController().delegate = self
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        configPager()
        btn_menu.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: .TouchUpInside)
    }
    
    func configPager() {
        pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PVC") as! UIPageViewController
        
        var initViewController = self.getViewControllerByIndex(0) as! PromoView
        pageViewController.dataSource = self
        pageViewController.delegate = self
        var vcArray = [initViewController]
        pageViewController.setViewControllers(vcArray, direction: .Forward, animated: true, completion: nil)
        
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 205)
        
        for pc in pageViewController.view.subviews as![UIView] {
            if pc is UIScrollView {
               pc.hidden = false
            }
        }
        
        self.addChildViewController(pageViewController)
        self.pager1.addSubview(pageViewController.view)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().postNotificationName("disebleTouchinMap", object: nil, userInfo: nil)
    }
    
    func getViewControllerByIndex(index:Int) -> UIViewController{

        if ((self.pageImage.count == 0) || (index >= self.pageImage.count)) {
            return PromoView()
        }
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PromoView") as! PromoView
        vc.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 210)
        vc.setView(pageImage[index], index: index)
        return vc
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PromoView).index as Int
        
        if (index == NSNotFound){
            return nil
        }
        
        index++
        
        if (index == self.pageImage.count){
            return nil
        }
        
        //pc_topics.currentPage = index
        return self.getViewControllerByIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PromoView).index as Int
        
        
        if (index == 0 || index == NSNotFound){
            return nil
        }
        
        index--
        
        return self.getViewControllerByIndex(index)
        
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int{
        return self.pageImage.count
    }
    
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int{
        return 0
    }

    
    
    
}
