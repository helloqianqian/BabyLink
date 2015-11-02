//
//  UIBaseTabBarController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/26.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIBaseTabBarController: UITabBarController, UIBaseTabBarDelegate {

    var localView:UILocalViewController!;
    var showView:UIShowViewController!;
    var findView:UIFindViewController!;
    var centerView:UICenterViewController!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        localView = UILocalViewController.init(nibName: "UILocalViewController", bundle: NSBundle.mainBundle())
        localView.title = "本小区"
        let localNav = UIBaseNavViewController(rootViewController: localView)
        self.addChildViewController(localNav)
        
        showView = UIShowViewController(nibName:"UIShowViewController", bundle: NSBundle.mainBundle())
        showView.title = "秀逗"
        let showNav = UIBaseNavViewController(rootViewController: showView)
        self.addChildViewController(showNav)
        
        findView = UIFindViewController(nibName:"UIFindViewController", bundle: NSBundle.mainBundle())
        findView.title = "发现"
        let findNav = UIBaseNavViewController(rootViewController: findView)
        self.addChildViewController(findNav)
        
        centerView = UICenterViewController(nibName:"UICenterViewController", bundle: NSBundle.mainBundle())
        centerView.title = "我"
        let centerNav = UIBaseNavViewController(rootViewController: centerView)
        self.addChildViewController(centerNav)
                
        let tabbarReplace = UIBaseTabBar.init(frame: CGRectZero)
        tabbarReplace.baseTabBarDelegate = self;
        tabbarReplace.translucent = false;
        tabbarReplace.tintColor = UIColor.purpleColor();
        tabbarReplace.barTintColor = UIColor.blackColor();
        self.setValue(tabbarReplace, forKey: "tabBar")
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tabBardidClickPlusButton(tabBar: UITabBar) {
        
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
