//
//  UIActivityView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

protocol UIActivityViewDelegate:NSObjectProtocol {
    func joinInTheActivity(index:Int);
    func checkTheInfoOfActivity(index:Int);
}


class UIActivityView: UIView ,UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var listTableView: UITableView!
    var headView:FindListHeadView!;
    
    weak var delegate:UIActivityViewDelegate!;
    
    override func awakeFromNib() {
        headView = NSBundle.mainBundle().loadNibNamed("FindListHeadView", owner: nil, options: nil).first as! FindListHeadView;
        headView.scrollWidth = MainScreenWidth;
        if iphone6Plus {
            headView.scrollHeight = 184;
        } else if iphone6 {
            headView.scrollHeight = 170;
        } else {
            headView.scrollHeight = 140;
        }
        
        
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerNib(UINib(nibName: "UIActivityTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIActivityTableViewCellIndentifier")
    }
    
    
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityTableViewCellIndentifier", forIndexPath: indexPath) as! UIActivityTableViewCell;
        cell.signInBtn.tag = indexPath.row;
        cell.signInBtn.addTarget(self, action: "joinTheActivity:", forControlEvents: UIControlEvents.TouchUpInside);
        return cell;
    }
    //MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if iphone6Plus {
            return 360;
        } else if iphone6 {
            return 338;
        } else {
            return 310;
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if iphone6Plus {
            return 184;
        }
        if iphone6 {
            return 170;
        }
        return 140;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate.checkTheInfoOfActivity(indexPath.row);
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headView;
    }
    
    
    //MARK - cell Function
    func joinTheActivity(sender:UIButton){
        delegate.joinInTheActivity(sender.tag);
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    
    

}
