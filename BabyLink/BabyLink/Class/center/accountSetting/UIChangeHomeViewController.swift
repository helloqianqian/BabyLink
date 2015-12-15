//
//  UIChangeHomeViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/12/13.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIChangeHomeViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{

    @IBOutlet weak var topOfTable: NSLayoutConstraint!
    var type=0;
    var lastVC : UIBaseViewController!;
    @IBOutlet weak var homeLabel: UITextField!
    @IBOutlet weak var listTableView: UITableView!
    var dataArray:NSMutableArray! = NSMutableArray();
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if type == 0{
            self.title = "修改小区"
        } else if type == 1{
            self.title = "修改附属小区"
        } else {
            self.title = "选择城市"
            topOfTable.constant = 64;
        }
        
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "homeCellID")
        
        homeLabel.delegate = self;
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle
            .Plain, target: self, action: "confirmHome");
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidChanged:", name: UITextFieldTextDidChangeNotification, object: self.homeLabel);
        
        
        self.getData();
    }
    func confirmHome(){
        if type == 2 {
            if homeLabel.text == "" {
                NSHelper.showAlertViewWithTip("请选择城市");
                return;
            }
            (self.lastVC as! UIFullInfoViewController).cityField.text  = homeLabel.text;
            self.navigationController?.popViewControllerAnimated(true);
        } else {
            if homeLabel.text == "" {
                NSHelper.showAlertViewWithTip("请选择或者输入小区名称");
                return;
            }
            
            var paramDic:NSDictionary!;
            if type == 0{
                paramDic = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,NSUserInfo.shareInstance().city,self.homeLabel.text!] , forKeys: [MEMBER_ID,"city","home"]);
            } else {
                paramDic = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,NSUserInfo.shareInstance().city,self.homeLabel.text!] , forKeys: [MEMBER_ID,"city","home2"]);
            }
            
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
            NSHttpHelp.httpHelpWithUrl(NSHttpModel.getUpdateNicknameUrl(), withParam: paramDic, withResult: { (returnObject:AnyObject!) -> Void in
                
                let dic = returnObject as! NSDictionary;
                let code = dic["code"] as! NSInteger;
                if code == 0 {
                    //发送成功
                    SVProgressHUD.showSuccessWithStatus("修改成功")
                    if self.type == 0 {
                        NSUserInfo.shareInstance().home = self.homeLabel.text;
                        appDelegate.recordLastUserHome()
                        (self.lastVC as! UIAccountSetViewController).homeLabel.text = "小区:\(NSUserInfo.shareInstance().home)"
                    } else {
                        NSUserInfo.shareInstance().home2 = self.homeLabel.text;
                        appDelegate.recordLastUserHome2()
                        (self.lastVC as! UIAccountSetViewController).otherHomeLabel.text = "附属小区:\(NSUserInfo.shareInstance().home2)"
                    }
                    self.navigationController?.popViewControllerAnimated(true);
                }else {
                    let datas = dic["datas"] as! String;
                    SVProgressHUD.showErrorWithStatus(datas);
                }
                }) { (error:AnyObject!) -> Void in
            }
        }
    }
    
    func getData(){
        if self.type == 2 {
            NSHttpHelp.httpHelpWithUrl(NSHttpModel.getCityList(), withParam: nil, withResult: { (returnObject:AnyObject!) -> Void in
                let dic = returnObject as! NSDictionary;
                let code = dic["code"] as! NSInteger;
                if code == 0 {
                    self.dataArray.removeAllObjects();
                    let datas = dic["datas"] as! NSArray;
                    for data in datas {
                        let valueStr = data["value"] as! String;
                        self.dataArray.addObject(valueStr);
                    }
                    self.listTableView.reloadData();
                } else {
                    //请求失败
                    let datas = dic["datas"] as! String;
                    SVProgressHUD.showErrorWithStatus(datas);
                }
                
                }) { (error:AnyObject!) -> Void in
            }
        } else {
            let dicParam:NSDictionary = NSDictionary(objects: [self.homeLabel.text!,NSUserInfo.shareInstance().city] , forKeys: ["key","city"]);
            NSHttpHelp.httpHelpWithUrlTpye(indexSearchType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
                let dic = returnObject as! NSDictionary;
                let code = dic["code"] as! NSInteger;
                if code == 0 {
                    //请求成功
                    self.dataArray.removeAllObjects();
                    let datas = dic["datas"] as! NSArray;
                    for data in datas {
                        let residence = NSResidence()
                        residence.setValuesForKeysWithDictionary(data as! [String : AnyObject])
                        self.dataArray.addObject(residence);
                    }
                    self.listTableView.reloadData();
                } else {
                    //请求失败
                    let datas = dic["datas"] as! String;
                    SVProgressHUD.showErrorWithStatus(datas);
                }
                }) { (error:AnyObject!) -> Void in
            };
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCellID");
        if type == 2 {
            let valueStr = dataArray[indexPath.row] as! String;
            cell?.textLabel?.text = valueStr;
        } else {
            let residence =  dataArray.objectAtIndex(indexPath.row) as! NSResidence;
            cell?.textLabel?.text = residence.name;
        }
        return cell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if type == 2 {
            let valueStr = dataArray[indexPath.row] as! String;
            homeLabel.text = valueStr;
        } else {
            let residence =  dataArray.objectAtIndex(indexPath.row) as! NSResidence;
            homeLabel.text = residence.name;
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.homeLabel.resignFirstResponder();
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    func textFieldDidChanged(notification:NSNotification) {
        self.getData()
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
