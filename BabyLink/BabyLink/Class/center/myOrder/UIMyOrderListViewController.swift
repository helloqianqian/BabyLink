//
//  UIMyOrderListViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/10.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIMyOrderListViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var itemBtn1: UIButton!
    @IBOutlet weak var itemBtn2: UIButton!
    @IBOutlet weak var itemBtn3: UIButton!
    @IBOutlet weak var itemBtn4: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    
    var tabType = 0;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的订单"
        itemBtn1.makeBackGroundColor_PurpleSelected();
        itemBtn2.makeBackGroundColor_PurpleSelected();
        itemBtn3.makeBackGroundColor_PurpleSelected();
        itemBtn4.makeBackGroundColor_PurpleSelected();
        
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerNib(UINib(nibName: "UIMyOrderTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIMyOrderTableViewCellIdentifier")
        self.listTableView.registerNib(UINib(nibName: "UIFinalPayTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFinalPayTableViewCellIdentifier")
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch tabType {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIMyOrderTableViewCellIdentifier", forIndexPath: indexPath)
            return cell;
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIMyOrderTableViewCellIdentifier", forIndexPath: indexPath)
            return cell;
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIMyOrderTableViewCellIdentifier", forIndexPath: indexPath)
            return cell;
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIFinalPayTableViewCellIdentifier", forIndexPath: indexPath)
            return cell;
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIMyOrderTableViewCellIdentifier", forIndexPath: indexPath)
            return cell;
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let orderVC = UIOrderInfoViewController(nibName:"UIOrderInfoViewController" ,bundle: NSBundle.mainBundle())
        self.navigationController?.pushViewController(orderVC, animated: true);
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func itemTabFunction1(sender: UIButton) {
        sender.selected = true;
        itemBtn2.selected = false;
        itemBtn3.selected = false;
        itemBtn4.selected = false;
        
        tabType = 0;
        self.listTableView.reloadData();
    }
    @IBAction func itemTabFunction2(sender: UIButton) {
        sender.selected = true;
        itemBtn1.selected = false;
        itemBtn3.selected = false;
        itemBtn4.selected = false;
        
        tabType = 1;
        self.listTableView.reloadData();
    }
    @IBAction func itemTabFunction3(sender: UIButton) {
        sender.selected = true;
        itemBtn1.selected = false;
        itemBtn2.selected = false;
        itemBtn4.selected = false;
        
        tabType = 3;
        self.listTableView.reloadData();
    }
    @IBAction func itemTabFunction4(sender: UIButton) {
        sender.selected = true;
        itemBtn1.selected = false;
        itemBtn2.selected = false;
        itemBtn3.selected = false;
        
        tabType = 2;
        self.listTableView.reloadData();
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
