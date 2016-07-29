//
//  PromocionesController.swift
//  ITALIKA
//
//  Created by Jonathan Velazquez on 04/06/16.
//  Copyright © 2016 Siker. All rights reserved.
//

import UIKit

class PromocionesController: UIViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController!
    var pageImage:[String] = ["Banner1","Banner2","Banner3","Banner4"]
    
    
    override func viewDidLoad() {
        
        pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PVC") as! UIPageViewController
        var initViewController = self.getViewControllerByIndex(0) as! PromoView
        pageViewController.dataSource = self
        pageViewController.delegate = self
        var vcArray = [initViewController]
        pageViewController.setViewControllers(vcArray, direction: .Forward, animated: true, completion: nil)
        
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        
        
        
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
    }
    
    func getViewControllerByIndex(index:Int) -> UIViewController{
        
        
        if ((self.pageImage.count == 0) || (index >= self.pageImage.count)) {
            return PromoView()
        }
        
        var vc = self.storyboard?.instantiateViewControllerWithIdentifier("PromoView") as! PromoView
        vc.view.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        vc.index = index
        vc.image =  pageImage[index]
        
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
