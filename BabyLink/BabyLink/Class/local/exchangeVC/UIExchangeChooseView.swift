//
//  UIExchangeChooseView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/26.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

protocol UIChooseGoodsDelegate:NSObjectProtocol{
    func didSelectItem(object:NSExchange);
}

class UIExchangeChooseView: UIView ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var bottomTable: NSLayoutConstraint!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var chooseBtn: UIButton!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var listTableView: UITableView!
    var dataArray:NSArray = NSArray();
    var selectRow = -1;
    weak var delegate:UIChooseGoodsDelegate!;
    override func awakeFromNib() {
        chooseBtn.makeBackGroundColor_White()
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "goodsListCellID")
        
    }
    
    @IBAction func closeView(sender: UIButton) {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, MainScreenHeight)
        }) { (finish:Bool) -> Void in
            self.removeFromSuperview()
        }
    }
    func showView(){
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)
            }) { (finish:Bool) -> Void in
        }
    }
    @IBAction func finishView(sender: UIButton) {
        if self.selectRow == -1 {
            SVProgressHUD.showImage(nil, status: "请至少选择一件商品")
            return;
        }
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, MainScreenHeight)
            }) { (finish:Bool) -> Void in
                self.delegate.didSelectItem(self.dataArray[self.selectRow] as! NSExchange);
                self.removeFromSuperview()
        }
    }
    
    @IBAction func chooseList(sender: UIButton) {
        sender.selected = !sender.selected;
        sender.enabled = false;
        if sender.selected {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                var frame = self.listTableView.frame;
                frame.origin.y = frame.origin.y-132;
                self.listTableView.frame = frame;
                }, completion: { (finish:Bool) -> Void in
                    self.bottomTable.constant = 88;
                    sender.enabled = true;
            })
        } else {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                var frame = self.listTableView.frame;
                frame.origin.y = frame.origin.y+132;
                self.listTableView.frame = frame;
                }, completion: { (finish:Bool) -> Void in
                    self.bottomTable.constant = -44;
                    sender.enabled = true;
            })
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectRow = indexPath.row;
        let exchange = self.dataArray[indexPath.row] as! NSExchange;
        contentLabel.text = exchange.from_gname;
        self.chooseBtn.enabled = false;
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            var frame = self.listTableView.frame;
            frame.origin.y = frame.origin.y+132;
            self.listTableView.frame = frame;
            }, completion: { (finish:Bool) -> Void in
                self.bottomTable.constant = -44;
                self.chooseBtn.enabled = true;
                self.chooseBtn.selected = false;
        })
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("goodsListCellID")
        let exchange = self.dataArray[indexPath.row] as! NSExchange;
        cell?.textLabel?.text = exchange.from_gname;
        return cell!;
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
