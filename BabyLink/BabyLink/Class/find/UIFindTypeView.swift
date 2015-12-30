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
    func didRemove();
}
class UIFindTypeView: UIView ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var left: NSLayoutConstraint!
    @IBOutlet weak var right: NSLayoutConstraint!
    
    
    @IBOutlet weak var tapBtn: UIButton!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
//    var tapGesture: UITapGestureRecognizer!
    
    
    
    
    
    var dataArray:NSMutableArray! = NSMutableArray();
    var otherArray = ["距离最近","价格最低","参与人数最多"];
    var type = 0
    var num = 0
    weak var delegate:UIFindTypeViewDelegate!;
    override func awakeFromNib() {
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.registerNib(UINib(nibName: "UIFindTypeTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFindTypeTableViewCellID");
        
        listTableView.layer.cornerRadius = 4;
        listTableView.layer.masksToBounds = true;
        listTableView.layer.borderColor = SGrayBorderColor.CGColor;
        listTableView.layer.borderWidth = 0.5;
        
        listTableView.userInteractionEnabled = true;
        
        right.constant = MainScreenWidth/2-7;
        
//        tapGesture = UITapGestureRecognizer(target: self, action: "endCurrentViewEditing");
//        self.addGestureRecognizer(tapGesture);
    }
    
    
    @IBAction func endCurrentViewEditing() {
        self.removeFromSuperview()
        self.delegate.didRemove();
    }
    
    func addClassType(array:NSArray){
        dataArray.addObjectsFromArray(array as [AnyObject]);
//        NSLog("__________\(dataArray.count)")
    }
    
    func reloadData(type:Int){
        self.type = type;
        if type == 0 {
            height.constant = CGFloat(self.dataArray.count) * 30;
            left.constant = 5;
        } else {
            height.constant = CGFloat(self.otherArray.count) * 30;
            left.constant = MainScreenWidth/2+2;
        }
        
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
            cell.titleLabel.text = dataArray[indexPath.row] as? String;
            if indexPath.row == self.dataArray.count-1 && num != 0 {
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
            delegate.didSelectedRow(indexPath.row, withContent: dataArray[indexPath.row] as! String, withType: self.type)
        }
        self.removeFromSuperview();
    }
    

    
    func hideMenu(){
    }
    func showMenu(){
    }
}
