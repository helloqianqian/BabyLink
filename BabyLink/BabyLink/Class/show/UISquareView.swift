//
//  UISquareView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/8.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UISquareView: UIView ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var listTableView: UITableView!
    
    override func awakeFromNib() {
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.registerNib(UINib(nibName: "UIShowTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIShowTableViewCellIdentifier");
        
    }
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIShowTableViewCellIdentifier", forIndexPath: indexPath) as! UIShowTableViewCell;
        return cell;
    }
    //MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if iphone6Plus {
            return 550;
        } else if iphone6 {
            return 515;
        } else {
            return 465;
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
