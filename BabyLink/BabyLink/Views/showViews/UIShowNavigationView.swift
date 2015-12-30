//
//  UIShowNavigationView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/3.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

protocol UIShowNavigationViewDelegate:NSObjectProtocol {
    func didSelectedAtIndex(index:Int);
}


class UIShowNavigationView: UIView {

//    @IBOutlet weak var letfOfSlideView: NSLayoutConstraint!
    
    @IBOutlet weak var linkBtn: UIButton!
    @IBOutlet weak var squareBtn: UIButton!
    
    @IBOutlet weak var sliderView: UIImageView!
    dynamic var selectedIndex = -1;
    private var mycontext = 1;
    
    weak var delegate:UIShowNavigationViewDelegate!;
    
    override func awakeFromNib() {
        self.addObserver(self, forKeyPath: "selectedIndex", options: NSKeyValueObservingOptions.New, context: &mycontext)
        
        linkBtn.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Selected)
        squareBtn.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Selected)
    }
    
    deinit{
        self.removeObserver(self, forKeyPath: "selectedIndex", context: &mycontext);
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &mycontext {
//            NSLog("\(change![NSKeyValueChangeNewKey])")
            switch selectedIndex {
            case 0:
                linkBtn.selected = true;
                squareBtn.selected = false;
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.sliderView.frame = self.linkBtn.frame;
                })
                break;
            case 1:
                linkBtn.selected = false;
                squareBtn.selected = true;
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.sliderView.frame = self.squareBtn.frame;
                })
                break;
            default:break;
            }
            if self.delegate != nil {
                self.delegate.didSelectedAtIndex(selectedIndex);
            }
        }
    }
    
    @IBAction func squareTabFunction(sender: UIButton) {
        self.selectedIndex = 1;
    }
    @IBAction func linkTabFunction(sender: UIButton) {
        self.selectedIndex = 0;
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
