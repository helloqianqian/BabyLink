//
//  UIBaseViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIBaseViewController: UIViewController {

    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let backButton = UIBarButtonItem(image: UIImage(named: "nav_left_btn"), style: UIBarButtonItemStyle.Plain, target: Common.rootViewController, action: Selector("showLeft"))
//        self.navigationItem.leftBarButtonItem = backButton
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: "")
    }
    
    
    func addGesture(){
        self.view.addGestureRecognizer(tapGesture);
    }
    
    func removeGesture(){
        self.view.removeGestureRecognizer(tapGesture);
    }

    
    @IBAction func endEditing(sender: UITapGestureRecognizer) {
        for subView in self.view.subviews {
            if subView.isKindOfClass(UITextField) {
                subView.resignFirstResponder()
            } else if subView.isKindOfClass(UIView){
                for sub in subView.subviews {
                    if sub.isKindOfClass(UITextField) {
                        sub.resignFirstResponder()
                    }
                }
            }
        }
        self.view.endEditing(true);
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
