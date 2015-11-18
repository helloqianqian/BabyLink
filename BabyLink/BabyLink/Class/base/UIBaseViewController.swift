//
//  UIBaseViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIBaseViewController: UIViewController ,UITextFieldDelegate{

    var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet var tapsGesture: UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: "")
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        tapGesture = UITapGestureRecognizer(target: self, action: "endEditing")
    }
    
    
    func addGesture(){
        self.view.addGestureRecognizer(self.tapGesture);
    }
    
    func removeGesture(){
        self.view.removeGestureRecognizer(self.tapGesture);
    }

    func keyboardWillShow(notification:NSNotification){
        self.addGesture();
    }
    func keyboardWillHide(notification:NSNotification){
        self.removeGesture();
    }
    func keyboardWillChangeFrame(notification: NSNotification){
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
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
    
    func textFieldDidEndEditing(textField: UITextField) {
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
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    func endEditing(){
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
