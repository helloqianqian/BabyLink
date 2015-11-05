//
//  UIExchangeView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

protocol UIExchangeViewDelegate:NSObjectProtocol {
//    func joinInTheActivity(index:Int);
    func checkTheInfoOfExchange(index:Int);
}


class UIExchangeView: UIView ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var listTableView: UITableView!
    weak var delegate:UIExchangeViewDelegate!;
    
    override func awakeFromNib() {
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerNib(UINib(nibName: "UIExchangeTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIExchangeTableViewCellIdentifier")
        
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIExchangeTableViewCellIdentifier", forIndexPath: indexPath) as! UIExchangeTableViewCell;
        return cell;
    }
    //MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if iphone6Plus {
            return 270;
        } else if iphone6 {
            return 254;
        } else {
            return 230;
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate.checkTheInfoOfExchange(indexPath.row);
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
