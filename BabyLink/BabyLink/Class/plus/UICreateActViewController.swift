//
//  UICreateActViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UICreateActViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIOptionViewDelegate{

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    var paramArray:NSMutableArray! = NSMutableArray(array: ["","","","","","","","","","",NSUserInfo.shareInstance().mobile]);
    let titleArray = ["活动主题:","活动地点:","报名截止:","集合时间:","集合地点:","上限人数:","活动费用:","支付方式:","交通工具:","联系人:","联系电话:"];
    var draging = false;
    var jiheTime = "";
    var jiezhiTime = "";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "发布活动"
        nextBtn.makeBackGroundColor_Red();
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerNib(UINib(nibName: "UICreateActTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "createActCellID")
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("createActCellID", forIndexPath: indexPath) as! UICreateActTableViewCell;
        cell.titleLabel.text = titleArray[indexPath.row];
        cell.contentField.tag = indexPath.row+1000;
        cell.contentField.delegate = self;
        if indexPath.row == 2 || indexPath.row == 3 {
            cell.contentField.enabled = false;
        } else {
            cell.contentField.enabled = true;
            if indexPath.row == 5 {
                cell.contentField.keyboardType = UIKeyboardType.NumberPad;
            } else if indexPath.row == 10 {
                cell.contentField.keyboardType = UIKeyboardType.PhonePad;
            } else {
                cell.contentField.keyboardType = UIKeyboardType.Default;
            }
        }
        let content = paramArray[indexPath.row] as! String;
        cell.contentField.text = content;
        return cell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2{
            self.selectActTime()
        } else if indexPath.row == 3  {
            self.selectJiheTime()
        } else {
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! UICreateActTableViewCell;
            cell.contentField.becomeFirstResponder();
        }
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true);
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 300
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1;
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        draging = true;
        self.unloadKeyboard();
    }
    
    
    @IBAction func nextStep(sender: UIButton) {
        for var i=0 ; i<11 ; i++ {
            let content = paramArray[i] as? String;
            if content == nil || content == "" {
                switch i {
                case 0:
                    SVProgressHUD.showImage(nil, status: "请填写活动主题");
                    break;
                case 1:
                    SVProgressHUD.showImage(nil, status: "请填写活动地点");
                    break;
                case 2:
                    SVProgressHUD.showImage(nil, status: "请填写报名截止时间");
                    break;
                case 3:
                    SVProgressHUD.showImage(nil, status: "请填写集合时间");
                    break;
                case 4:
                    SVProgressHUD.showImage(nil, status: "请填写集合地点");
                    break;
                case 5:
                    SVProgressHUD.showImage(nil, status: "请填写上限人数");
                    break;
                case 6:
                    SVProgressHUD.showImage(nil, status: "请填写活动费用");
                    break;
                case 7:
                    SVProgressHUD.showImage(nil, status: "请填写支付方式");
                    break;
                case 8:
                    SVProgressHUD.showImage(nil, status: "请填写交通工具");
                    break;
                case 9:
                    SVProgressHUD.showImage(nil, status: "请填写联系人");
                    break;
                case 10:
                    SVProgressHUD.showImage(nil, status: "请填写联系电话");
                    break;
                default:break;
                }
                return;
            }
        }
        if (jiheTime as NSString).intValue < (jiezhiTime as NSString).intValue {
            SVProgressHUD.showImage(nil, status: "集合时间不能小于活动截止日期");
            return;
        }
        let content = paramArray[10] as? String;
        if !NSHelper.checkUserPhoneValidateWith(content) {
            NSHelper.showAlertViewWithTip("请输入正确的手机号");
            return;
        }
        
        let nextVC = UICreateANViewController(nibName:"UICreateANViewController" ,bundle: NSBundle.mainBundle())
        nextVC.paramArray = self.paramArray;
        self.navigationController?.pushViewController(nextVC, animated: true);
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        var row = textField.tag-1000;
        if iphone6Plus {
            if row > 4 {
                row = 4;
            }
        } else if iphone6 {
            if row > 5 {
                row = 5;
            }
        } else if iphone5 {
            if row > 6 {
                row = 6;
            }
        } else {
            if row > 7 {
                row = 7;
            }
        }
        let indexPath = NSIndexPath(forRow: row, inSection: 0);
        self.listTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true);
    }
    func textFieldDidEndEditing(textField: UITextField) {
        let index = textField.tag - 1000;
        if textField.text != nil && textField.text != "" {
            paramArray[index] = textField.text!;
        } else {
            paramArray[index] = "";
        }
        if !draging {
            let indexPath = NSIndexPath(forRow: 0, inSection: 0);
            self.listTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true);
        }
        draging = false;
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    func selectActTime(){
        self.unloadKeyboard()
        let optionView = NSBundle.mainBundle().loadNibNamed("UIOptionView", owner: nil, options: nil).first as! UIOptionView;
        optionView.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, MainScreenHeight);
        optionView.delegate = self;
        optionView.changeDataSource(DataType.activityTime);
        self.navigationController?.view.addSubview(optionView);
        optionView.showPickerView()
    }
    func selectJiheTime(){
        self.unloadKeyboard()
        let optionView = NSBundle.mainBundle().loadNibNamed("UIOptionView", owner: nil, options: nil).first as! UIOptionView;
        optionView.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, MainScreenHeight);
        optionView.delegate = self;
        optionView.changeDataSource(DataType.jiheTime);
        self.navigationController?.view.addSubview(optionView);
        optionView.showPickerView()
    }
    func unloadKeyboard(){
        for var i=0 ; i<11 ; i++ {
            let indexPath = NSIndexPath(forRow: i, inSection: 0);
            let cell = self.listTableView.cellForRowAtIndexPath(indexPath) as? UICreateActTableViewCell;
            if cell != nil && cell!.contentField.isFirstResponder(){
                cell!.contentField.resignFirstResponder();
                break;
            }
        }
    }
    
    func didRemoveFromSuperView(object:AnyObject ,dataType type:DataType){
        let array = object as! NSArray;
        if DataType.activityTime == type {
            let indexPath = NSIndexPath(forRow: 2, inSection: 0);
            let cell = self.listTableView.cellForRowAtIndexPath(indexPath) as! UICreateActTableViewCell;
            cell.contentField.text = "\(array[0])-\(array[1])-\(array[2])";
            let month = array[1] as! NSNumber;
            let day = array[2] as! NSNumber;
            var monthStr = "\(array[1])";
            var dayStr = "\(array[2])";
            if month.intValue < 10 {
                monthStr = "0\(array[1])"
            }
            
            if day.intValue < 10 {
                dayStr = "0\(array[2])";
            }
            jiezhiTime = "\(array[0])\(monthStr)\(dayStr)"
            paramArray[2] = "\(array[0])-\(array[1])-\(array[2])";
        } else {
            let indexPath = NSIndexPath(forRow: 3, inSection: 0);
            let cell = self.listTableView.cellForRowAtIndexPath(indexPath) as! UICreateActTableViewCell;
            cell.contentField.text = "\(array[0])-\(array[1])-\(array[2]) \(array[3]):\(array[4])";
            
            let month = array[1] as! NSNumber;
            let day = array[2] as! NSNumber;
            var monthStr = "\(array[1])";
            var dayStr = "\(array[2])";
            if month.intValue < 10 {
                monthStr = "0\(array[1])"
            }
            
            if day.intValue < 10 {
                dayStr = "0\(array[2])";
            }
            jiheTime = "\(array[0])\(monthStr)\(dayStr)"
            paramArray[3] = "\(array[0])-\(array[1])-\(array[2]) \(array[3]):\(array[4])";
        }
    }
    func didSelectedRow(row:Int, forComponent component: Int){
        
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
