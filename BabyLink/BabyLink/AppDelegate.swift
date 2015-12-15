//
//  AppDelegate.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/25.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,WXApiDelegate,UIAlertViewDelegate{

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.updateLocation();
        self.checkLastLoginUser()
        self.addShareSDK()
        self.window?.backgroundColor = hexRGB(0xF8CFE1);
        return true
    }

    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        WXApi.handleOpenURL(url, delegate: self)
        let result = UMSocialSnsService.handleOpenURL(url);
        if (!result) {
            //调用其他SDK，例如支付宝SDK等
        }
        return result;
    }
    
    func onResp(resp: BaseResp!) {
        if resp.isKindOfClass(PayResp){
            switch resp.errCode {
            case 0:
                let alert = UIAlertView(title:nil, message: "支付结果：成功！", delegate: self, cancelButtonTitle: "确定");
                alert.show();
                break;
            default:
                NSHelper.showAlertViewWithTip("支付结果：失败！\n\(resp.errStr)")
                break;
            }
        }
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        NSNotificationCenter.defaultCenter().postNotificationName("UIPaymentSuccessNotification", object: nil);
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        WXApi.handleOpenURL(url, delegate: self)
        AlipaySDK.defaultService().processOrderWithPaymentResult(url) { (result) -> Void in
            NSLog("reslut back = %@",result);
            let resultStatus = result["resultStatus"] as! NSInteger
            let success = result["success"] as! Bool
            if resultStatus == 9000 && success {
                let alert = UIAlertView(title:nil, message: "支付结果：成功！", delegate: self, cancelButtonTitle: "确定");
                alert.show();
            } else {
                NSHelper.showAlertViewWithTip("支付结果：失败!")
            }
        }
        
        let result = UMSocialSnsService.handleOpenURL(url);
        if (!result) {
            //调用其他SDK，例如支付宝SDK等
            
        }
        return result;
    }
    
    func addShareSDK() {
//        wx0fbabc189e400940   微信appid
//        d4624c36b6795d1d99dcf0547af5443d  微信秘钥
        UMSocialData.setAppKey("562d96b0e0f55ae8010013b6");
        UMSocialQQHandler.setQQWithAppId("1104869195", appKey: "ZKscrjTqoGkHSEOE", url: "http://www.umeng.com/social");
        UMSocialWechatHandler.setWXAppId("wx0fbabc189e400940", appSecret: "d4624c36b6795d1d99dcf0547af5443d", url: "http://www.umeng.com/social")
        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey("1187574472", redirectURL: "http://sns.whalecloud.com/sina2/callback")
        
        //92abe680559bf68b1d8c087f27239992 weibo app secret
        
        
        /*[UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
        //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
        [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
        //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil ,需要 #import "UMSocialSinaHandler.h"
        [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
        */
    }
    func exchangeRootViewController(login:Bool){
        SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8))
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
        SVProgressHUD.setFont(UIFont.boldSystemFontOfSize(15.0))
        
        if login {
            let tabBar = UIBaseTabBarController(nibName: "UIBaseTabBarController", bundle: NSBundle.mainBundle());
            mainTabBar = tabBar;
            let nav = UIBaseNavViewController(rootViewController: tabBar);
            nav.setNavigationBarStyleLight();
            self.window?.rootViewController = nav
        } else {
            let enterVC = UIEnterViewController(nibName: "UIEnterViewController", bundle: NSBundle.mainBundle());
            let nav = UIBaseNavViewController(rootViewController: enterVC);
            nav.setNavigationBarStyleDark();
            self.window?.rootViewController = nav
        }
    }
    
    func checkLastLoginUser(){
        let  def:NSUserDefaults = NSUserDefaults.standardUserDefaults();
        let lastLogin = def.boolForKey(ISLOGIN)
        if lastLogin {
            NSUserInfo.shareInstance().member_id = def.objectForKey(MEMBER_ID) as! String;
            NSUserInfo.shareInstance().member_name = def.objectForKey(MEMBER_NAME) as! String;
            NSUserInfo.shareInstance().member_avar = def.objectForKey(MEMBER_AVAR) as! String;
            NSUserInfo.shareInstance().password = def.objectForKey(PASSWORD) as! String;
            NSUserInfo.shareInstance().passwordLocal = def.objectForKey(PASSWORDLocal) as! String;
            NSUserInfo.shareInstance().mobile = def.objectForKey(MOBILE) as! String;
            NSUserInfo.shareInstance().home = def.objectForKey(HOME) as! String;
            NSUserInfo.shareInstance().add_time = def.objectForKey(ADD_TIME) as! String;
            NSUserInfo.shareInstance().login_time = def.objectForKey(LOGIN_TIME) as! String;
            NSUserInfo.shareInstance().baby_sex = def.objectForKey(BABY_SEX) as! String;
            NSUserInfo.shareInstance().city = def.objectForKey(CITY) as! String;
            NSUserInfo.shareInstance().baby_nam = def.objectForKey(BABY_NAM) as! String;
            NSUserInfo.shareInstance().baby_link = def.objectForKey(BABY_LINK) as! String;
            NSUserInfo.shareInstance().baby_date = def.objectForKey(BABY_DATE) as! String;
            NSUserInfo.shareInstance().position = def.objectForKey(POSITION) as! String;
            NSUserInfo.shareInstance().home2 = def.objectForKey(HOME2) as! String;
        }
        NSUserInfo.shareInstance().islogin = lastLogin;
        self.exchangeRootViewController(lastLogin)
    }
    
    func logoutLastLoginUser(){
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setBool(false, forKey: ISLOGIN)
        userDefault.setObject("", forKey: MOBILE);
        userDefault.setObject("", forKey: PASSWORDLocal);
        userDefault.setObject("", forKey: MEMBER_ID)
        userDefault.setObject("", forKey: PASSWORD);
        userDefault.setObject("", forKey: MEMBER_NAME);
        userDefault.setObject("", forKey: MEMBER_AVAR);
        userDefault.setObject("", forKey: HOME);
        userDefault.setObject("", forKey: HOME2)
        userDefault.setObject("", forKey: ADD_TIME);
        userDefault.setObject("", forKey: LOGIN_TIME);
        userDefault.setObject("", forKey: BABY_SEX);
        userDefault.setObject("", forKey: BABY_NAM);
        userDefault.setObject("", forKey: BABY_LINK);
        userDefault.setObject("", forKey: BABY_DATE);
        userDefault.setObject("", forKey: POSITION);
        userDefault.setObject("", forKey: CITY);
        userDefault.synchronize();
    }
    
    func recordLastLoginUser(){
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setBool(true, forKey: ISLOGIN)
        userDefault.setObject(NSUserInfo.shareInstance().mobile, forKey: MOBILE);
        userDefault.setObject(NSUserInfo.shareInstance().passwordLocal, forKey: PASSWORDLocal);
        userDefault.setObject(NSUserInfo.shareInstance().member_id, forKey: MEMBER_ID)
        userDefault.setObject(NSUserInfo.shareInstance().password, forKey: PASSWORD);
        userDefault.setObject(NSUserInfo.shareInstance().member_name, forKey: MEMBER_NAME);
        userDefault.setObject(NSUserInfo.shareInstance().member_avar, forKey: MEMBER_AVAR);
        userDefault.setObject(NSUserInfo.shareInstance().home, forKey: HOME);
        userDefault.setObject(NSUserInfo.shareInstance().add_time, forKey: ADD_TIME);
        userDefault.setObject(NSUserInfo.shareInstance().login_time, forKey: LOGIN_TIME);
        userDefault.setObject(NSUserInfo.shareInstance().baby_sex, forKey: BABY_SEX);
        userDefault.setObject(NSUserInfo.shareInstance().baby_nam, forKey: BABY_NAM);
        userDefault.setObject(NSUserInfo.shareInstance().baby_link, forKey: BABY_LINK);
        userDefault.setObject(NSUserInfo.shareInstance().baby_date, forKey: BABY_DATE);
        userDefault.setObject(NSUserInfo.shareInstance().position, forKey: POSITION);
        userDefault.setObject(NSUserInfo.shareInstance().city, forKey: CITY);
        userDefault.synchronize();
    }
    
    func recordLastUserIcon(){
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(NSUserInfo.shareInstance().member_avar, forKey: MEMBER_AVAR);
        userDefault.synchronize();
    }
    func recordLastUserNickname(){
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(NSUserInfo.shareInstance().member_name, forKey: MEMBER_NAME);
        userDefault.synchronize();
    }
    
    func recordLastUserHome(){
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(NSUserInfo.shareInstance().home, forKey: HOME);
        userDefault.synchronize();
    }
    
    func recordLastUserHome2(){
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(NSUserInfo.shareInstance().home2, forKey: HOME2);
        userDefault.synchronize();
    }
    
    func recordLastUserPSW(){
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(NSUserInfo.shareInstance().passwordLocal, forKey: PASSWORDLocal);
        userDefault.synchronize();
    }
    func recordLastUserMobile(){
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(NSUserInfo.shareInstance().mobile, forKey: MOBILE);
        userDefault.synchronize();
    }
    func updateLocation(){
        CCLocationManager.shareLocation().getLocationCoordinate { (lo:CLLocationCoordinate2D) -> Void in
            locationParam = lo;
        }
    }
}

