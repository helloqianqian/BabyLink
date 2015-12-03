//
//  UICreateView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

protocol UICreateDelegate:NSObjectProtocol{
    func didSelectedCreateIndex(index:Int)
}
class UICreateView: UIView {

    @IBOutlet weak var createActBtn: UIButton!
    @IBOutlet weak var createTalkBtn: UIButton!
    @IBOutlet weak var createExchangeBtn: UIButton!
    @IBOutlet weak var createShowBtn: UIButton!
    weak var delegate:UICreateDelegate!;
    @IBAction func createEnter(sender: UIButton) {
        self.removeFromSuperview();
        if delegate != nil {
            self.delegate.didSelectedCreateIndex(sender.tag);
        }
    }
    func showView(){
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight);
        }) { (finish:Bool) -> Void in
                
        }
    }
    func unloadView(){
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, MainScreenHeight);
            }) { (finish:Bool) -> Void in
                self.removeFromSuperview();
        }
    }
    
    @IBAction func closeView(sender: UIButton) {
        self.unloadView()
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
