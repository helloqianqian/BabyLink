//
//  UIShowItemView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/12/3.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIShowItemView: UIView {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var headIcon: UIImageView!
    var cancelAnimate = false;
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        backView.layer.cornerRadius = 7;
        backView.layer.masksToBounds = true;
        
        headIcon.layer.masksToBounds = true;
        headIcon.layer.cornerRadius = 15;
    }
    
    func start(){
        let delay = rand()%20;
        self.startAnimation(Double(delay)/10)
    }
    func startAnimation(delay:Double){
        UIView.animateWithDuration(3, delay: delay, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            self.alpha = 0;
//            NSLog("1111111111111111")
            }) { (finish:Bool) -> Void in
//                NSLog("2222222222222222")
                if finish{
//                    NSLog("33333333333333333")
                    UIView.animateWithDuration(1, delay: 1, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                        self.alpha = 1;
//                        NSLog("44444444444444444444")
                        }, completion: { (finish:Bool) -> Void in
//                            NSLog("555555555555555555555")
                            if !self.cancelAnimate && finish{
//                                NSLog("6666666666666666666")
                                self.startAnimation(0);
                            }
                    })
                }
        }
    }
    
    func stopAnimation(){
        self.cancelAnimate = true;
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame);
//        
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
