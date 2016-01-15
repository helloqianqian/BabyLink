//
//  UIMineViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/12.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIMineViewController: UIBaseViewController {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var activityBtn: UIButton!
    @IBOutlet weak var topicBtn: UIButton!
    @IBOutlet weak var exchangeBtn: UIButton!
    @IBOutlet weak var showBtn: UIButton!
    @IBOutlet weak var friendsBtn: UIButton!
    @IBOutlet weak var fansBtn: UIButton!
    
    @IBOutlet weak var numLabel1: UILabel!
    @IBOutlet weak var numLabel2: UILabel!
    @IBOutlet weak var numLabel3: UILabel!
    @IBOutlet weak var numLabel4: UILabel!
    @IBOutlet weak var numLabel5: UILabel!
    
    @IBOutlet weak var width1: NSLayoutConstraint!
    @IBOutlet weak var width2: NSLayoutConstraint!
    @IBOutlet weak var width3: NSLayoutConstraint!
    @IBOutlet weak var width4: NSLayoutConstraint!
    @IBOutlet weak var width5: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的主页"
        headIcon.layer.cornerRadius = 32;
        headIcon.layer.masksToBounds = true;
        headIcon.layer.borderColor = UIColor.whiteColor().CGColor;
        headIcon.layer.borderWidth = 1;
        
        headIcon.sd_setImageWithURL(NSURL(string: NSUserInfo.shareInstance().member_avar), placeholderImage: UIImage(named: "morentoux"));
        nameLabel.text = NSUserInfo.shareInstance().member_name;
        
        numLabel1.layer.cornerRadius = 8;
        numLabel1.layer.masksToBounds = true;
        numLabel2.layer.cornerRadius = 8;
        numLabel2.layer.masksToBounds = true;
        numLabel3.layer.cornerRadius = 8;
        numLabel3.layer.masksToBounds = true;
        numLabel4.layer.cornerRadius = 8;
        numLabel4.layer.masksToBounds = true;
        numLabel5.layer.cornerRadius = 8;
        numLabel5.layer.masksToBounds = true;
        
        self.setNums();
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setNums", name: "UpdateNumNotification", object: nil);
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        mainTabBar.getNums();
    }

    func setNums(){
        if NSUserInfo.shareInstance().activity_num == "0" {
            numLabel1.hidden = true;
        } else {
            numLabel1.hidden = false;
            numLabel1.text = NSUserInfo.shareInstance().activity_num;
            let size = numLabel1.sizeThatFits(CGSizeMake(MainScreenWidth, 16));
            width1.constant = size.width > 16 ? size.width : 16;
        }
        
        if NSUserInfo.shareInstance().talk_num == "0" {
            numLabel2.hidden = true;
        } else {
            numLabel2.hidden = false;
            numLabel2.text = NSUserInfo.shareInstance().talk_num;
            let size = numLabel2.sizeThatFits(CGSizeMake(MainScreenWidth, 16));
            width2.constant = size.width > 16 ? size.width : 16;
        }
        
        if NSUserInfo.shareInstance().exchange_num == "0" {
            numLabel3.hidden = true;
        } else {
            numLabel3.hidden = false;
            numLabel3.text = NSUserInfo.shareInstance().exchange_num;
            let size = numLabel3.sizeThatFits(CGSizeMake(MainScreenWidth, 16));
            width3.constant = size.width > 16 ? size.width : 16;
        }
        
        if NSUserInfo.shareInstance().xiu_num == "0" {
            numLabel4.hidden = true;
        } else {
            numLabel4.hidden = false;
            numLabel4.text = NSUserInfo.shareInstance().xiu_num;
            let size = numLabel4.sizeThatFits(CGSizeMake(MainScreenWidth, 16));
            width4.constant = size.width > 16 ? size.width : 16;
        }
        
        if NSUserInfo.shareInstance().fans_num == "0" {
            numLabel5.hidden = true;
        } else {
            numLabel5.hidden = false;
            numLabel5.text = NSUserInfo.shareInstance().fans_num;
            let size = numLabel5.sizeThatFits(CGSizeMake(MainScreenWidth, 16));
            width5.constant = size.width > 16 ? size.width : 16;
        }
    }
    
    @IBAction func enterActivityPage(sender: UIButton) {
        let myAcVC = MyActivityViewController(nibName:"MyActivityViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(myAcVC, animated: true);
    }
    @IBAction func enterTopicPage(sender: UIButton) {
        let myAcVC = MyTopicViewController(nibName:"MyTopicViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(myAcVC, animated: true);
    }
    @IBAction func enterExchangeBtn(sender: UIButton) {
        let myAcVC = MyExchangeViewController(nibName:"MyExchangeViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(myAcVC, animated: true);
    }
    @IBAction func enterShowPage(sender: UIButton) {
        let myAcVC = MyShowViewController(nibName:"MyShowViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(myAcVC, animated: true);
    }
    @IBAction func enterFriendsPage(sender: UIButton) {
        let myAcVC = MyFriendsViewController(nibName:"MyFriendsViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(myAcVC, animated: true);
    }
    @IBAction func enterFansPage(sender: UIButton) {
        let myAcVC = MyFansViewController(nibName:"MyFansViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(myAcVC, animated: true);
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
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
