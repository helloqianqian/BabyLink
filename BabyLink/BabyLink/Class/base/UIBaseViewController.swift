//
//  UIBaseViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIBaseViewController: UIViewController{

    var tapGesture: UITapGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: "")
        tapGesture = UITapGestureRecognizer(target: self, action: "endCurrentViewEditing");
    }
    
    
    func addGesture(){
        self.view.addGestureRecognizer(tapGesture);
    }
    
    func removeGesture(){
        self.view.removeGestureRecognizer(tapGesture);
    }
    
    func didBeginEditing(textField: UITextField) {
        let view = textField.superview;
        let offY = (view?.frame.size.height)! + (view?.frame.origin.y)!;
        if offY > MainScreenHeight - 256 {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                var frame = self.view.frame;
                frame.origin.y = frame.origin.y - (offY - MainScreenHeight + 256);
                self.view.frame = frame;
                }, completion: { (finished:Bool) -> Void in
                    
            })
        }
    }
    
    func didEndEditing(textField: UITextField) {
        let h=self.view.frame.origin.y;
        if h<0{
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                var frame = self.view.frame;
                frame.origin.y = 0;
                self.view.frame = frame;
                }, completion: { (finished:Bool) -> Void in
                    
            })
        }
    }
    func shouldReturn(textField: UITextField) -> Bool {
        if textField.returnKeyType == UIReturnKeyType.Next {
            self.nextFieldEditing(textField);
        } else if textField.returnKeyType == UIReturnKeyType.Done {
            textField.resignFirstResponder()
        }
        return true;
    }
    
    func nextFieldEditing(textField: UITextField){
        
    }
    
    func endCurrentViewEditing(){
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
