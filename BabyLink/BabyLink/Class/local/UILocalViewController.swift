//
//  UILocalViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UILocalViewController: UIBaseViewController ,UIActivityViewDelegate{

    var activityView:UIActivityView!;
    var topicView:UITopicView!;
    var exchangeView:UIExchangeView!;
    
    @IBOutlet weak var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let titleView = NSBundle.mainBundle().loadNibNamed("UILocalNavigationView", owner: nil, options: nil).first as! UILocalNavigationView;
        titleView.selectedItem = 0;
        titleView.frame = CGRectMake(0, 0, MainScreenWidth, 44)
        self.navigationItem.titleView = titleView;
        
        var viewFrame = scrollview.frame;
        
        scrollview.contentSize = CGSizeMake(3 * viewFrame.width, viewFrame.height);

        activityView = NSBundle.mainBundle().loadNibNamed("UIActivityView", owner: nil, options: nil).first as! UIActivityView;
        activityView.frame = viewFrame;
        activityView.delegate = self;
        scrollview.addSubview(activityView);

        topicView = NSBundle.mainBundle().loadNibNamed("UITopicView", owner: nil, options: nil).first as! UITopicView;
        viewFrame.origin.x = MainScreenWidth;
        topicView.frame = viewFrame;
        scrollview.addSubview(topicView);

        exchangeView = NSBundle.mainBundle().loadNibNamed("UIExchangeView", owner: nil, options: nil).first as! UIExchangeView;
        viewFrame.origin.x = 2*MainScreenWidth;
        exchangeView.frame = viewFrame;
        scrollview.addSubview(exchangeView);
    }

    
    
    //MARK - UIActivityViewDelegate
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
