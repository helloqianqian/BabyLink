//
//  UIFinalPayViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/10.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFinalPayViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "支付尾款"
        
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerNib(UINib(nibName: "UIFinalPayTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFinalPayTableViewCellIdentifier");
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIFinalPayTableViewCellIdentifier", forIndexPath: indexPath) as! UIFinalPayTableViewCell;
        cell.payBtn.addTarget(self, action: "payTheLeftMoney:", forControlEvents: UIControlEvents.TouchUpInside);
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150;
    }
    
    
    func payTheLeftMoney(sender:UIButton) {
        let paymentVC = UIPaymentViewController(nibName:"UIPaymentViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(paymentVC, animated: true);
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
