//
//  UILocalNavigationView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/2.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

protocol UILocalNavigationViewDelegate:NSObjectProtocol{
    func didSelectedItem(index:Int);
}

class UILocalNavigationView: UIView {
    dynamic var selectedItem = -1;
    private var mycontext = 0;

    @IBOutlet weak var activityTab: UIButton!
    @IBOutlet weak var topicTab: UIButton!
    @IBOutlet weak var exchangeTab: UIButton!
    
    weak var delegate:UILocalNavigationViewDelegate!
    
    override func awakeFromNib() {
        self.addObserver(self, forKeyPath: "selectedItem", options: NSKeyValueObservingOptions.New, context: &mycontext)
        
        activityTab.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Selected);
        topicTab.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Selected);
        exchangeTab.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Selected);
        
    }
//    deinit {
//        self.removeObserver(self, forKeyPath: "selectedItem")
//    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &mycontext {
            NSLog("\(change![NSKeyValueChangeNewKey])")
            switch selectedItem {
            case 0:
                activityTab.selected = true;
                topicTab.selected = false;
                exchangeTab.selected = false;
                break;
            case 1:
                activityTab.selected = false;
                topicTab.selected = true;
                exchangeTab.selected = false;
                break;
            case 2:
                activityTab.selected = false;
                topicTab.selected = false;
                exchangeTab.selected = true;
                break;
            default:
                break;
            }
            if self.delegate != nil {
                self.delegate.didSelectedItem(selectedItem);
            }
        }
    }
    @IBAction func activityTabFunction(sender: UIButton) {
        self.selectedItem=0;
    }
    
    @IBAction func TopicTabFunction(sender: UIButton) {
        self.selectedItem=1;
    }
    
    @IBAction func exchangeTabFunction(sender: UIButton) {
        self.selectedItem = 2;
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
