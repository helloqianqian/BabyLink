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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let titleView = NSBundle.mainBundle().loadNibNamed("UILocalNavigationView", owner: nil, options: nil).first as! UILocalNavigationView;
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
        self.view.addSubview(topicView);

        exchangeView = NSBundle.mainBundle().loadNibNamed("UIExchangeView", owner: nil, options: nil).first as! UIExchangeView;
        exchangeView.delegate = self;
        exchangeView.frame = viewFrame;
        self.view.addSubview(exchangeView);
        
        titleView.selectedItem = 0;
    }

    
    
    //MARK: - UIActivityViewDelegate
    func joinInTheActivity(index:Int) {
        let joinVC:UIJoinViewController = UIJoinViewController.init(nibName:"UIJoinViewController",bundle:NSBundle.mainBundle())
        joinVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(joinVC, animated: true);
    }
    
    func checkTheInfoOfActivity(index:Int) {
        let infoVC:UIActivityInfoViewController = UIActivityInfoViewController.init(nibName:"UIActivityInfoViewController",bundle:NSBundle.mainBundle())
        infoVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(infoVC, animated: true);
    }
    
    //MARK: - UIExchangeViewDelegate
    func checkTheInfoOfExchange(index: Int) {
        let infoVC:UIExchangeInfoViewController = UIExchangeInfoViewController.init(nibName:"UIExchangeInfoViewController", bundle:NSBundle.mainBundle());
        infoVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(infoVC, animated: true);
    }
    //MARK: - UILocalNavigationViewDelegate
    func didSelectedItem(index: Int) {
        switch index {
        case 0:
            self.view.bringSubviewToFront(activityView)
            break;
        case 1:
            self.view.bringSubviewToFront(topicView)
            break;
        case 2:
            self.view.bringSubviewToFront(exchangeView)
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
