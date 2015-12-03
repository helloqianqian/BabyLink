//
//  UIExchangeTipView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/26.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

protocol UITipViewDelegate:NSObjectProtocol{
    func createNewExchange();
}
class UIExchangeTipView: UIView {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    weak var delegate:UITipViewDelegate!;
    override func awakeFromNib() {
        confirmBtn.makeBackGroundColor_Purple();
        cancelBtn.makeBackGroundColor_White();
    }
    
    
    @IBAction func confirmView(sender: UIButton) {
        delegate.createNewExchange()
        self.removeFromSuperview();
    }
    @IBAction func closeView(sender: UIButton) {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, MainScreenHeight)
        }) { (finish:Bool) -> Void in
            self.removeFromSuperview()
        }
    }
    
    func showView(){
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)
            }) { (finish:Bool) -> Void in
        }
    }

}
