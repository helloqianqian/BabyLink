//
//  UICenterViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UICenterViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userCoupon: UILabel!
    @IBOutlet weak var leftPayment: UILabel!
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var finalPayBtn: UIButton!
    @IBOutlet weak var convertBtn: UIButton!
    
    @IBOutlet weak var blurEffectionView2: UIVisualEffectView!
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    let listTitles = ["我的主页","我的订单","账号设置","帮助中心","版本升级"];
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "我"
        self.userCoupon.text = "兑换码\n2"
        self.leftPayment.text = "支付尾款\n2";

        blurEffectView.effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        blurEffectionView2.effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        
        headImageView.layer.cornerRadius = 30;
        headImageView.layer.masksToBounds = true;
        headImageView.sd_setImageWithURL(NSURL(string: NSUserInfo.shareInstance().member_avar), placeholderImage: UIImage(named: "morentoux"))
        
        userName.text = NSUserInfo.shareInstance().member_name;
        
        listTableView.registerNib(UINib(nibName: "UICenterTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "centerCellIndentifier")
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if centerHeadIconLoad {
            centerHeadIconLoad = false;
            headImageView.sd_setImageWithURL(NSURL(string: NSUserInfo.shareInstance().member_avar), placeholderImage: UIImage(named: "morentoux"))
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if section == 0 {
            return 10;
        } else {
            return 5;
        }
        
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40;
    }
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView();
//    }
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return UIView();
//    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        switch indexPath.row {
        case 0:
            if indexPath.section == 0 {
                let mineVC = UIMineViewController(nibName:"UIMineViewController", bundle: NSBundle.mainBundle());
                mineVC.hidesBottomBarWhenPushed = true;
                self.navigationController?.pushViewController(mineVC, animated: true);
            } else {
                let myOrderVC = UIMyOrderListViewController(nibName:"UIMyOrderListViewController", bundle: NSBundle.mainBundle());
                myOrderVC.hidesBottomBarWhenPushed = true;
                self.navigationController?.pushViewController(myOrderVC, animated: true);
            }
            break;
        case 1:
            let accountVC = UIAccountSetViewController(nibName:"UIAccountSetViewController", bundle: NSBundle.mainBundle());
            accountVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(accountVC, animated: true);
            break;
        case 2:
            let helpVC = UIHelpViewController(nibName:"UIHelpViewController", bundle: NSBundle.mainBundle());
            helpVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(helpVC, animated: true);
            break;
        case 3:
            break;
        default:break;
        }
    }
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1;
        } else {
            return 4;
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("centerCellIndentifier", forIndexPath: indexPath) as? UICenterTableViewCell
        cell?.textLabel?.textColor = hexRGB(0xA6A7A8)
        cell?.textLabel?.font = UIFont.systemFontOfSize(14.0)
        cell?.textLabel?.text = listTitles[indexPath.row + indexPath.section];
        return cell!;
    }

    
    @IBAction func convertEnter(sender: UIButton) {
        let convertVC = UIConvertViewController(nibName:"UIConvertViewController",bundle: NSBundle.mainBundle());
        convertVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(convertVC, animated: true);
    }
    
    @IBAction func payMoneyEnter(sender: UIButton) {
        let finalVC = UIFinalPayViewController(nibName:"UIFinalPayViewController",bundle: NSBundle.mainBundle());
        finalVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(finalVC, animated: true);
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
