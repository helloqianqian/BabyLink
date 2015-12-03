//
//  UIExchangeInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/6.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIExchangeInfoViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource,UIChooseDelegate ,UIChooseGoodsDelegate,UITipViewDelegate,ZLPhotoPickerBrowserViewControllerDataSource,ZLPhotoPickerBrowserViewControllerDelegate,UIAlertViewDelegate{

    @IBOutlet weak var heightOfBackView1: NSLayoutConstraint!
    @IBOutlet weak var backView1: UIView!
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contentImage1: UIButton!
    @IBOutlet weak var contentImage2: UIButton!
    @IBOutlet weak var contentImage3: UIButton!
    @IBOutlet weak var fname: UILabel!
    @IBOutlet weak var toname: UILabel!
    @IBOutlet weak var zanBtn: UIButton!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var checkInfoBtn: UIButton!
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var backView2: UIView!
    @IBOutlet weak var contactLabel: UILabel!
    
    @IBOutlet weak var exchangeBtn: UIButton!
    @IBOutlet weak var topOfBtn: NSLayoutConstraint!
    
    
    var exchangeList:NSExchange! = NSExchange();
    var to_exchange:NSExchange! = NSExchange();
    var from_exchange:NSExchange! = NSExchange();
    
    var myExchanges:NSMutableArray!=NSMutableArray();
    var fromType=0;
    var myList = 0;
    
    
    var selected=false;
    //0是没置换 ，1是置换中，2是置换完成
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if myList == 0 {
            self.title = "置换详情";
        } else {
            self.title = "我的置换"
        }
        
        self.setUI();
        self.getInfoData();
    }
    func setUI(){
        backView1.layer.masksToBounds = true;
        backView1.layer.cornerRadius = 4;
        
        headIcon.layer.cornerRadius = 3;
        headIcon.layer.masksToBounds = true;
        
        backView.layer.borderWidth = 0.5;
        backView.layer.borderColor = hexRGB(0xD3D4D5).CGColor;
        backView2.layer.borderColor = hexRGB(0xD3D4D5).CGColor;
        backView2.layer.borderWidth = 0.5;
        
        exchangeBtn.makeBackGroundColor_Red();
        
        if iphone6Plus {
            heightOfBackView1.constant = 242;
        } else if iphone6 {
            heightOfBackView1.constant = 230;
        }
        if self.fromType == 1 {
            self.listTableView.hidden = true;
            self.backView2.hidden = true;
            exchangeBtn.hidden = true;
        } else {
            if self.exchangeList.status == "0" {
                //未置换
                self.listTableView.hidden = true;
                self.backView2.hidden = true;
                if self.exchangeList.member_id == NSUserInfo.shareInstance().member_id{
                    exchangeBtn.hidden = true;
                }
                exchangeBtn.makeBackGroundColor_Red();
            } else if self.exchangeList.status == "1" {
                topOfBtn.constant = 186;
                self.backView2.hidden = false;
                self.listTableView.hidden = false;
                
                infoTitle.text = "参与置换的物品"
                arrowImage.hidden = true;
                checkInfoBtn.enabled = false;
                
                exchangeBtn.setTitle("完成置换", forState: UIControlState.Normal);
                exchangeBtn.makeBackGroundColor_Red();
                
                self.setListTable()
            } else {
                //完成置换
                topOfBtn.constant = 96;
                self.backView2.hidden = true;
                infoTitle.text = "参与置换的物品"
                arrowImage.hidden = true;
                checkInfoBtn.enabled = false;
                exchangeBtn.setTitle("完成置换", forState: UIControlState.Normal);
                exchangeBtn.enabled = false;
                exchangeBtn.makeBackGroundColor_DarkGray()
                self.setListTable();
            }
        }
        headIcon.sd_setImageWithURL(NSURL(string: self.exchangeList.member_avar), placeholderImage: UIImage(named: "morentoux"))
        nameLabel.text = self.exchangeList.member_name;
        addressLabel.text = self.exchangeList.home;
        fname.text = self.exchangeList.from_gname;
        toname.text = self.exchangeList.to_gname;
    }
    func setListTable(){
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerNib(UINib(nibName: "UIExchangeInfoTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "exchangeInfoIdentifier")
    }
    
    func setInfoContent(){
        let imageArray:NSArray = self.from_exchange.images as! NSArray
        if imageArray.count>0 {
            self.contentImage1.sd_setImageWithURL(NSURL(string: imageArray[0] as! String), forState: UIControlState.Normal)
        }
        if imageArray.count>1 {
            self.contentImage2.sd_setImageWithURL(NSURL(string: imageArray[1] as! String), forState: UIControlState.Normal)
        }
        if imageArray.count>2 {
            self.contentImage3.sd_setImageWithURL(NSURL(string: imageArray[2] as! String), forState: UIControlState.Normal)
        }
        
        if self.exchangeList.status == "1" {
            contactLabel.text = "\(to_exchange.link_mobile)  \(to_exchange.link_name)";
            self.listTableView.reloadData();
        } else if self.exchangeList.status == "2" {
            //完成置换
            self.listTableView.reloadData();
        }
    }
    
    func getInfoData(){
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,"\(self.exchangeList.exchange_id)"] , forKeys: [MEMBER_ID,"exchange_id"]);
        NSHttpHelp.httpHelpWithUrlTpye(exchangeInfoType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                let datas = dic["datas"] as! NSDictionary;
                self.from_exchange.setValuesForKeysWithDictionary(datas as! [String : AnyObject]);
                if self.exchangeList.status != "0" {
                    let to_ex = datas["to_exchange"] as! NSDictionary;
                    self.to_exchange.setValuesForKeysWithDictionary(to_ex as! [String : AnyObject]);
                }
                self.setInfoContent();
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
        }) { (error:AnyObject!) -> Void in
                
        };
    }
    
    
    @IBAction func checkGoodsInfo(sender: UIButton) {
        let info:UIInfoViewController = UIInfoViewController(nibName:"UIInfoViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(info, animated: true);
    }
    @IBAction func exchangeGoods(sender: UIButton) {
        
        if self.exchangeList.status == "0" {
            let paramDic = ["member_id":NSUserInfo.shareInstance().member_id]
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
            NSHttpHelp.httpHelpWithUrlTpye(myExchangeListType, withParam: paramDic, withResult: { (result:AnyObject!) -> Void in
                let dic = result as! NSDictionary;
                let code = dic["code"] as! NSInteger;
                if code == 0 {
                    SVProgressHUD.dismiss()
                    //我可以置换的商品列表
                    let datas = dic["datas"] as! NSArray;
                    for data in datas {
                        let exchange = NSExchange();
                        exchange.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
                        self.myExchanges.addObject(exchange);
                    }
                    self.exchangeCheckFunction()
                }else {
                    let datas = dic["datas"] as! String;
                    SVProgressHUD.showErrorWithStatus(datas);
                }
                }) { (error:AnyObject!) -> Void in
                    
            }
        } else if self.exchangeList.status == "1" {
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
            let paramDic = ["member_id":NSUserInfo.shareInstance().member_id,"me_exchange_id":self.from_exchange.exchange_id,"to_exchange_id":self.from_exchange.link_exchange_id]
            NSHttpHelp.httpHelpWithUrlTpye(finishExchangeType, withParam: paramDic, withResult: { (result:AnyObject!) -> Void in
                let dic = result as! NSDictionary;
                let code = dic["code"] as! NSInteger;
                if code == 0 {
                    SVProgressHUD.showImage(nil, status: "置换成功")
                    self.exchangeList.status = "2";
                    self.setUI();
                    reloadMyListOfExchange = true;
                }else {
                    let datas = dic["datas"] as! String;
                    SVProgressHUD.showErrorWithStatus(datas);
                }
                }) { (error:AnyObject!) -> Void in
            }
        }
    }
    func exchangeCheckFunction() {
        if self.myExchanges.count == 0 {
            let tipView = NSBundle.mainBundle().loadNibNamed("UIExchangeTipView", owner: nil, options: nil).first as! UIExchangeTipView;
            tipView.delegate = self;
            tipView.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, MainScreenHeight)
            self.navigationController?.view.addSubview(tipView);
            tipView.showView();
        } else {
            let tipView = NSBundle.mainBundle().loadNibNamed("UIExchangeChooseView", owner: nil, options: nil).first as! UIExchangeChooseView;
            tipView.delegate = self;
            tipView.dataArray = self.myExchanges;
            tipView.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, MainScreenHeight)
            self.navigationController?.view.addSubview(tipView);
            tipView.showView();
        }
    }
    
    
    func didSelectItem(object: NSExchange) {
        self.to_exchange = object;
        let paramDic = ["member_id":NSUserInfo.shareInstance().member_id,"exchange_id":self.from_exchange.exchange_id,"my_exchange_id":self.to_exchange.exchange_id]
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
        NSHttpHelp.httpHelpWithUrlTpye(exchangeType, withParam: paramDic, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                let alertView = UIAlertView(title: "提示", message: "请求已成功\n请到我-我的主页-我的置换中查看", delegate: self, cancelButtonTitle: "确定")
                alertView.show();
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
        }
    }
    
    func alertViewCancel(alertView: UIAlertView) {
        exchangeListLoad = true;
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    func createNewExchange() {
        mainTabBar.reloadListType = 2;
        let createActVC = UICreateExcViewController(nibName:"UICreateExcViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(createActVC, animated: true);
    }
    
    @IBAction func checkBigImage(sender: UIButton) {
        let indexPath = NSIndexPath(forRow: sender.tag-1000, inSection: 0)
        let pickerBrowser = ZLPhotoPickerBrowserViewController()
        pickerBrowser.delegate = self;
        pickerBrowser.dataSource = self;
        pickerBrowser.editing = false;
        pickerBrowser.currentIndexPath = indexPath;
        pickerBrowser.showPickerVc(self);
    }
    
    func numberOfSectionInPhotosInPickerBrowser(pickerBrowser: ZLPhotoPickerBrowserViewController!) -> Int {
        return 1;
    }
    func photoBrowser(photoBrowser: ZLPhotoPickerBrowserViewController!, numberOfItemsInSection section: UInt) -> Int {
        let imageArray:NSArray = self.from_exchange.images as! NSArray
        return imageArray.count;
    }
    func photoBrowser(pickerBrowser: ZLPhotoPickerBrowserViewController!, photoAtIndexPath indexPath: NSIndexPath!) -> ZLPhotoPickerBrowserPhoto! {
        let imageArray:NSArray = self.from_exchange.images as! NSArray
        let imageUrl = imageArray[indexPath.row] as! String
        let photo = ZLPhotoPickerBrowserPhoto(anyImageObjWith: imageUrl);
        let btn:UIButton = self.view.viewWithTag(indexPath.row+1000) as! UIButton;
        photo.toView = btn.imageView;
        photo.thumbImage = btn.imageView?.image;
        return photo;
    }
    //MARK: - UITableViewDelegate,UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("exchangeInfoIdentifier", forIndexPath: indexPath) as! UIExchangeInfoTableViewCell
//        if self.exchangeList.status == "2" {
//            cell.chooseBtn.selected = true;
//            cell.chooseBtn.enabled = false;
//        } else {
//            cell.delegate = self;
//        }
        cell.setContentData(to_exchange, inexRow: indexPath.row)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 86;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let infoVC:UIExchangeInfoViewController = UIExchangeInfoViewController(nibName:"UIExchangeInfoViewController", bundle:NSBundle.mainBundle());
        infoVC.exchangeList = self.to_exchange;
        infoVC.fromType = 1;
        self.navigationController?.pushViewController(infoVC, animated: true);
    }
    
    func didChooseAtIndexRow(row: Int) {
        self.selected = !self.selected;
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
