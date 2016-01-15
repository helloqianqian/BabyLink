//
//  UIBaseTabBarController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/26.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIBaseTabBarController: UITabBarController, UIBaseTabBarDelegate ,UICreateDelegate{

    var localView:UILocalViewController!;
    var showView:UIShowViewController!;
    var findView:UIFindViewController!;
    var centerView:UICenterViewController!;
    
    var reloadListType = -1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: "")
        
        localView = UILocalViewController(nibName: "UILocalViewController", bundle: NSBundle.mainBundle())
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
        
//        self.getNums()
        
    }
    
    func setTabbarItemBadge(num:String) {
        if num == "0"{
            centerView.tabBarItem.badgeValue = nil;
        } else {
            centerView.tabBarItem.badgeValue = num;
        }
    }
    
    func getNums(){
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id] , forKeys: [MEMBER_ID]);
        NSHttpHelp.httpHelpWithUrl(NSHttpModel.getOrderNumUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                let datas = dic["datas"] as! NSDictionary;
                NSUserInfo.shareInstance().code_num = datas["code_num"] as! String;
                NSUserInfo.shareInstance().wei_num = datas["wei_num"] as! String;
                NSUserInfo.shareInstance().activity_num = datas["activity_num"] as! String;
                NSUserInfo.shareInstance().exchange_num = datas["exchange_num"] as! String;
                NSUserInfo.shareInstance().xiu_num = datas["xiu_num"] as! String;
                NSUserInfo.shareInstance().talk_num = datas["talk_num"] as! String;
                NSUserInfo.shareInstance().sum_num = datas["sum_num"] as! String;
                NSUserInfo.shareInstance().fans_num = datas["fans_num"] as! String;
                
                self.setTabbarItemBadge(NSUserInfo.shareInstance().sum_num);
                NSNotificationCenter.defaultCenter().postNotificationName("UpdateNumNotification", object: nil);
            } else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if createSuccess {
            if reloadListType<3{
                localView.titleView.selectedItem = self.reloadListType;
            } else {
                showView.titleView.selectedIndex = 0
            }
            createSuccess = false;
        }
        reloadListType = -1;
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tabBardidClickPlusButton(tabBar: UITabBar) {        
        let createView = NSBundle.mainBundle().loadNibNamed("UICreateView", owner: nil, options: nil).first as! UICreateView;
        createView.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, MainScreenHeight);
        createView.delegate = self;
        self.view.addSubview(createView);
        createView.showView();
    }

    func didSelectedCreateIndex(index: Int) {
        switch index {
        case 110:
            self.selectedIndex = 0;
            self.reloadListType = 0;
            let createActVC = UICreateActViewController(nibName:"UICreateActViewController" ,bundle: NSBundle.mainBundle());
            self.navigationController?.pushViewController(createActVC, animated: true);
            break;
        case 111:
            self.selectedIndex = 0;
            self.reloadListType = 1;
            let createActVC = UICreateShowViewController(nibName:"UICreateShowViewController" ,bundle: NSBundle.mainBundle());
            self.navigationController?.pushViewController(createActVC, animated: true);
            break;
        case 112:
            self.selectedIndex = 0;
            self.reloadListType = 2;
            let createActVC = UICreateExcViewController(nibName:"UICreateExcViewController" ,bundle: NSBundle.mainBundle());
            self.navigationController?.pushViewController(createActVC, animated: true);
            break;
        case 113:
            self.selectedIndex = 1;
            self.reloadListType = 3;
            let createActVC = UICreateTalkViewController(nibName:"UICreateTalkViewController" ,bundle: NSBundle.mainBundle());
            self.navigationController?.pushViewController(createActVC, animated: true);
            break;
        default:
            break;
        }
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
