//
//  UIFindTypeView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/12/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit
protocol UIFindTypeViewDelegate:NSObjectProtocol {
    func didSelectedRow(row:Int ,withContent title:String , withType type:Int);
}
class UIFindTypeView: UIView ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var listTableView: UITableView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var dataArray = ["免费","亲子活动","早教","被邀请"];
    var otherArray = ["距离最近","价格最低","参与人数最多"];
    var type = 0
    var num = 0
    weak var delegate:UIFindTypeViewDelegate!;
    override func awakeFromNib() {
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.registerNib(UINib(nibName: "UIFindTypeTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFindTypeTableViewCellID");
        
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = true;
        self.layer.borderColor = SGrayBorderColor.CGColor;
        self.layer.borderWidth = 0.5;
    }
    
    func reloadData(type:Int){
        self.type = type;
        listTableView.reloadData();
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == 0 {
            return dataArray.count
        }
        return otherArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIFindTypeTableViewCellID", forIndexPath: indexPath) as! UIFindTypeTableViewCell;
        if type == 0 {
            cell.titleLabel.text = dataArray[indexPath.row];
            if indexPath.row == 3 && num != 0 {
                cell.numLabel.text = "\(num)"
                cell.numLabel.hidden = false;
            } else {
                cell.numLabel.hidden = true;
            }
        } else {
            cell.titleLabel.text = otherArray[indexPath.row];
            cell.numLabel.hidden = true;
        }
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        if delegate != nil {
            delegate.didSelectedRow(indexPath.row, withContent: dataArray[indexPath.row], withType: self.type)
        }
        self.removeFromSuperview();
    }
    func hideMenu(){
    }
    func showMenu(){
    }
}
