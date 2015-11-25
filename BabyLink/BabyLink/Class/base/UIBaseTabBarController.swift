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
        localView.tabBarItem = UITabBarItem(title: "本小区", image: UIImage(named: "wben"), selectedImage: UIImage(named: "dben"))
        let localNav = UIBaseNavViewController(rootViewController: localView)
        localNav.setNavigationBarStyleLight();
        self.addChildViewController(localNav)
        
        showView = UIShowViewController(nibName:"UIShowViewController", bundle: NSBundle.mainBundle())
        showView.title = "秀逗"
        showView.tabBarItem = UITabBarItem(title: "秀逗", image: UIImage(named: "wxiu"), selectedImage: UIImage(named: "dxiiu"))
        let showNav = UIBaseNavViewController(rootViewController: showView)
        showNav.setNavigationBarStyleLight();
        self.addChildViewController(showNav)
        
        findView = UIFindViewController(nibName:"UIFindViewController", bundle: NSBundle.mainBundle())
        findView.title = "发现"
        findView.tabBarItem = UITabBarItem(title: "发现", image: UIImage(named: "wfa"), selectedImage: UIImage(named: "dfa"))
        let findNav = UIBaseNavViewController(rootViewController: findView)
        findNav.setNavigationBarStyleLight();
        self.addChildViewController(findNav)
        
        centerView = UICenterViewController(nibName:"UICenterViewController", bundle: NSBundle.mainBundle())
        centerView.title = "我"
        centerView.tabBarItem = UITabBarItem(title: "我", image: UIImage(named: "wwo"), selectedImage: UIImage(named: "dwo"))
        let centerNav = UIBaseNavViewController(rootViewController: centerView)
        centerNav.setNavigationBarStyleLight();
        self.addChildViewController(centerNav)
                
        let tabbarReplace = UIBaseTabBar.init(frame: CGRectZero)
        tabbarReplace.baseTabBarDelegate = self;
        tabbarReplace.translucent = false;
        tabbarReplace.tintColor = SPurpleBtnColor;
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
