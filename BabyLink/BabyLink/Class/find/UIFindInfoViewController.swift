//
//  UIFindInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/8.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFindInfoViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerNib(UINib(nibName: "UIFindInfoFirstTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFindInfoFirstTableViewCellIdentifier")
        self.listTableView.registerNib(UINib(nibName: "UIFindInfoSecondTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFindInfoSecondTableViewCellIdentifier")
        self.listTableView.registerNib(UINib(nibName: "UIFindInfoThirdTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFindInfoThirdTableViewCellIdentifier")
        self.listTableView.registerNib(UINib(nibName: "UIFindInfoForthTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFindInfoForthTableViewCellIdentifier")
        self.listTableView.registerNib(UINib(nibName: "UIFindInfoFifithTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFindInfoFifthTableViewCellIdentifier")
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIFindInfoFirstTableViewCellIdentifier", forIndexPath: indexPath) as! UIFindInfoFirstTableViewCell;
            return cell;
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIFindInfoSecondTableViewCellIdentifier", forIndexPath: indexPath) as! UIFindInfoSecondTableViewCell;
            cell.inviteBtn.addTarget(self, action: "inviteNeighbor:", forControlEvents: UIControlEvents.TouchUpInside);
            return cell;
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIFindInfoThirdTableViewCellIdentifier", forIndexPath: indexPath) as! UIFindInfoThirdTableViewCell;
            return cell;
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIFindInfoForthTableViewCellIdentifier", forIndexPath: indexPath) as! UIFindInfoForthTableViewCell;
            return cell;
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIFindInfoFifthTableViewCellIdentifier", forIndexPath: indexPath) as! UIFindInfoFifithTableViewCell;
            return cell;
        default:
            var cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCellIdentifer")
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "UITableViewCellIdentifer")
            }
            return cell!;
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        switch indexPath.row {
        case 0:
            return 366;
        case 1:
            return 130;
        case 2:
            return 44;
        case 3:
            return 170;
        case 4:
            return 138;
        default:
            return 44;
        }
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44;
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = NSBundle.mainBundle().loadNibNamed("UIFindInfoFooterView", owner: nil, options: nil).first as! UIFindInfoFooterView;
        footerView.originPriceLabel.text = "现价\n￥2239.00";
        footerView.originPriceBtn.addTarget(self, action: "originalPricePayFunction:", forControlEvents: UIControlEvents.TouchUpInside);
        
        footerView.prePayLabel.text = "我要预订\n￥22.00";
        footerView.prePayBtn.addTarget(self, action: "prePricePayFunction:", forControlEvents: UIControlEvents.TouchUpInside);
        return footerView;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            //商品详情
        }
    }
    
    func inviteNeighbor(sender:UIButton) {
        let listVC:UIFriendsListViewController = UIFriendsListViewController(nibName:"UIFriendsListViewController", bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(listVC, animated: true);
    }
    
    
    func originalPricePayFunction(sender:UIButton){
        
    }
    func prePricePayFunction(sender:UIButton){
        let payVC = UIPaymentViewController(nibName:"UIPaymentViewController", bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(payVC, animated: true);
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
