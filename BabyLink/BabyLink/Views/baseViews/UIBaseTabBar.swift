//
//  UIBaseTabBar.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/29.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

protocol  UIBaseTabBarDelegate: UITabBarDelegate{
    
    func tabBardidClickPlusButton(tabBar: UITabBar);
}

class UIBaseTabBar: UITabBar {


    var plusBtn:UIButton!;
    weak var baseTabBarDelegate:UIBaseTabBarDelegate!;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        plusBtn = UIButton.init(type: UIButtonType.Custom);
        plusBtn.setBackgroundImage(UIImage(named: "中间按钮"), forState: UIControlState.Normal)
        plusBtn.frame = CGRectMake(0, 0, 49, 49);
        plusBtn.addTarget(self, action: "plusClick", forControlEvents: UIControlEvents.TouchUpInside);
        self.addSubview(plusBtn);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        plusBtn.center.x = self.frame.size.width/2
        
        let itemWidth = self.frame.size.width/5
        var itemIndex = 0;
        for item in self.subviews {
            let subClass:AnyClass = NSClassFromString("UITabBarButton")!
            if item.isKindOfClass(subClass){
                item.frame.size.width = itemWidth;
                item.frame.origin.x = CGFloat(itemIndex) * itemWidth
                
                itemIndex++;
                if(itemIndex == 2){
                    itemIndex++;
                }
            } else if item.isKindOfClass(UIImageView) && item.bounds.size.height < 1{
                item.hidden = true
            }
        }
    }
    
    func plusClick() {
        self.baseTabBarDelegate.tabBardidClickPlusButton(self)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
