//
//  UITopicView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UITopicView: UIView ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var listTableView: UITableView!

    override func awakeFromNib() {
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.registerNib(UINib(nibName: "UITopicTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UITopicTableViewCellIdentifier")
    }
    
    
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 430;
    }
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITopicTableViewCellIdentifier", forIndexPath: indexPath) as! UITopicTableViewCell;
        return cell;
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
