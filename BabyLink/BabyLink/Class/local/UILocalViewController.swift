//
//  UILocalViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UILocalViewController: UIBaseViewController ,UILocalNavigationViewDelegate,UIActivityViewDelegate,UIExchangeViewDelegate{

    var activityView:UIActivityView!;
    var topicView:UITopicView!;
    var exchangeView:UIExchangeView!;
    var titleView:UILocalNavigationView!;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleView = NSBundle.mainBundle().loadNibNamed("UILocalNavigationView", owner: nil, options: nil).first as! UILocalNavigationView;
        titleView.delegate = self;
        titleView.frame = CGRectMake(0, 0, MainScreenWidth, 44)
        self.navigationItem.titleView = titleView;
        
        let viewFrame = self.view.frame;
        
        activityView = NSBundle.mainBundle().loadNibNamed("UIActivityView", owner: nil, options: nil).first as! UIActivityView;
        activityView.frame = viewFrame;
        activityView.delegate = self;
        self.view.addSubview(activityView);

        topicView = NSBundle.mainBundle().loadNibNamed("UITopicView", owner: nil, options: nil).first as! UITopicView;
        topicView.frame = viewFrame;
        topicView.superVC = self;
        self.view.addSubview(topicView);

        exchangeView = NSBundle.mainBundle().loadNibNamed("UIExchangeView", owner: nil, options: nil).first as! UIExchangeView;
        exchangeView.delegate = self;
        exchangeView.frame = viewFrame;
        self.view.addSubview(exchangeView);
        
        titleView.selectedItem = 0;
        
        activityListLoad = false;
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
    }
    func keyboardWillShow(notification:NSNotification){
        self.addGesture();
    }
    func keyboardWillHide(notification:NSNotification){
        self.removeGesture();
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        if self.titleView.selectedItem == 0{
            if activityListLoad {
                activityListLoad = false;
                activityView.loadContentData(true, withAnimate: false)
            }
        } else if self.titleView.selectedItem == 1 {
            
        } else {
            if exchangeListLoad {
                exchangeListLoad = false;
                exchangeView.loadContentData(true, withAnimate: false);
            }
        }
    }
    
    //MARK: - UIActivityViewDelegate
    func joinInTheActivity(actObject: NSActListObject) {
        let joinVC:UIJoinViewController = UIJoinViewController(nibName:"UIJoinViewController",bundle:NSBundle.mainBundle())
        joinVC.activityID = actObject.activity_id;
        joinVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(joinVC, animated: true);
    }
    func checkTheInfoOfActivity(actObject: NSActListObject) {
        let infoVC:UIActivityInfoViewController = UIActivityInfoViewController(nibName:"UIActivityInfoViewController",bundle:NSBundle.mainBundle())
        infoVC.activityID = actObject.activity_id;
        infoVC.listModel = actObject;
        if actObject.member_id == NSUserInfo.shareInstance().member_id {
            infoVC.sourceFrom = 1;
        }
        infoVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(infoVC, animated: true);
    }
    func didClickAdImage(adModle:ADModel) {
        let info:UIInfoViewController = UIInfoViewController(nibName:"UIInfoViewController" ,bundle: NSBundle.mainBundle());
        info.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(info, animated: true);
    }
    //MARK: - UIExchangeViewDelegate
    func checkTheInfoOfExchange(exchange:NSExchange) {
        let infoVC:UIExchangeInfoViewController = UIExchangeInfoViewController(nibName:"UIExchangeInfoViewController", bundle:NSBundle.mainBundle());
        infoVC.exchangeList = exchange;
        infoVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(infoVC, animated: true);
    }
    //MARK: - UILocalNavigationViewDelegate
    func didSelectedItem(index: Int, withForce force: Bool) {
        switch index {
        case 0:
            self.view.bringSubviewToFront(activityView)
            activityView.loadContentData(createSuccess, withAnimate: true)
            break;
        case 1:
            self.view.bringSubviewToFront(topicView)
            topicView.loadContentData((createSuccess || talkListLoad))
            talkListLoad = false;
            break;
        case 2:
            self.view.bringSubviewToFront(exchangeView)
            exchangeView.loadContentData(createSuccess, withAnimate: true)
            break;
        default:
            break;
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
