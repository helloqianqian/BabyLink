//
//  UIFindInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/8.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFindInfoViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource,didClickImgDelegate,UIAlertViewDelegate,UMSocialUIDelegate{

    @IBOutlet weak var listTableView: UITableView!
    var listModel:NSFind!;
    var infoModel:NSInfoFind! = NSInfoFind();
//    var spread = false;
    var headView:FindListHeadView!;
    
    var left:Double!=0;
    var timer:NSTimer?;
    
    var remove = false;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "详情"
        
        headView = NSBundle.mainBundle().loadNibNamed("FindListHeadView", owner: nil, options: nil).first as! FindListHeadView;
        headView.scrollWidth = MainScreenWidth;
        headView.scrollHeight = MainScreenWidth*0.6;
        headView.delegate = self;
        
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerNib(UINib(nibName: "UIFindInfoFirstTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFindInfoFirstTableViewCellIdentifier")
        self.listTableView.registerNib(UINib(nibName: "UIFindInfoSecondTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFindInfoSecondTableViewCellIdentifier")
        self.listTableView.registerNib(UINib(nibName: "UIFindInfoThirdTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFindInfoThirdTableViewCellIdentifier")
        self.listTableView.registerNib(UINib(nibName: "UIFindInfoForthTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFindInfoForthTableViewCellIdentifier")
        self.listTableView.registerNib(UINib(nibName: "UIFindInfoFifithTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFindInfoFifthTableViewCellIdentifier")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        self.getInfoData()
    }
    
    func getInfoData(){
        let dicParam:NSDictionary = NSDictionary(objects: [listModel.goods_id,locationParam.latitude.description,locationParam.longitude.description] , forKeys: ["goods_id","latitude","longitude"]);
        NSHttpHelp.httpHelpWithUrl(NSHttpModel.getGoodsInfoUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                let datas = dic["datas"] as! NSDictionary
                self.infoModel.setValuesForKeysWithDictionary(datas as! [String : AnyObject])
                let images = datas["images"] as! NSArray;
                if images.count > 0 {
                    for url in images {
                        let ad = ADModel()
                        ad.cover = url as! String
                        self.infoModel.imagesAD.addObject(ad);
                    }
                    self.headView.setupSubviews(self.infoModel.imagesAD,tag: false);
                }
                let  font:UIFont = UIFont.systemFontOfSize(14);
                let content = self.infoModel.mark as NSString;
                let size = content.sizeWithConstrainedToWidth(Float(MainScreenWidth-50), fromFont: font, lineSpace: 3.0)
                self.infoModel.heightLabel = size.height;
                self.listTableView.reloadData()
                self.left = (self.infoModel.end_time as NSString).doubleValue - (self.infoModel.begin_time as NSString).doubleValue;
                self.startTimer();
            } else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIFindInfoFirstTableViewCellIdentifier", forIndexPath: indexPath) as! UIFindInfoFirstTableViewCell;
            cell.setContentData(infoModel)
            return cell;
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIFindInfoSecondTableViewCellIdentifier", forIndexPath: indexPath) as! UIFindInfoSecondTableViewCell;
//            cell.spreadBtn.addTarget(self, action: "spreadInviteCell:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.inviteBtn.addTarget(self, action: "inviteNeighbor:", forControlEvents: UIControlEvents.TouchUpInside);
    
            cell.qqFriends.tag = 1;
            cell.weixinFriends.tag = 2;
            cell.sinaWeibo.tag = 3;
            cell.weixinCircle.tag = 4;
            
            cell.qqFriends.addTarget(self, action: "shareActivityData:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.weixinFriends.addTarget(self, action: "shareActivityData:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.sinaWeibo.addTarget(self, action: "shareActivityData:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.weixinCircle.addTarget(self, action: "shareActivityData:", forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell;
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIFindInfoThirdTableViewCellIdentifier", forIndexPath: indexPath) as! UIFindInfoThirdTableViewCell;
            return cell;
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIFindInfoForthTableViewCellIdentifier", forIndexPath: indexPath) as! UIFindInfoForthTableViewCell;
            cell.setContentData(infoModel);
            return cell;
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIFindInfoFifthTableViewCellIdentifier", forIndexPath: indexPath) as! UIFindInfoFifithTableViewCell;
            cell.setContentData(infoModel)
            return cell;
        default:
            var cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCellIdentifer")
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "UITableViewCellIdentifer")
            }
            return cell!;
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        switch indexPath.row {
        case 0:
            return 188;
        case 1:
//            if self.spread {
                return 130;
//            } else {
//                return 50;
//            }
        case 2:
            return 44;
        case 3:
            return 100+self.infoModel.heightLabel;
        case 4:
            return 138;
        default:
            return 44;
        }
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44;
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MainScreenWidth*0.6;
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = NSBundle.mainBundle().loadNibNamed("UIFindInfoFooterView", owner: nil, options: nil).first as! UIFindInfoFooterView;
        footerView.originPriceBtn.addTarget(self, action: "originalPricePayFunction:", forControlEvents: UIControlEvents.TouchUpInside);
        footerView.prePayBtn.addTarget(self, action: "prePricePayFunction:", forControlEvents: UIControlEvents.TouchUpInside);
        footerView.setContent(infoModel);
        return footerView;
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headView;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            //商品详情
            let info:UIInfoViewController = UIInfoViewController(nibName:"UIInfoViewController" ,bundle: NSBundle.mainBundle());
            info.type = 1;
            info.contentStr = self.infoModel.info;
            self.navigationController?.pushViewController(info, animated: true);
        }
    }
    
    func inviteNeighbor(sender:UIButton) {
        let listVC:UIFriendsListViewController = UIFriendsListViewController(nibName:"UIFriendsListViewController", bundle: NSBundle.mainBundle());
        listVC.listModel = self.infoModel;
        self.navigationController?.pushViewController(listVC, animated: true);
    }
    
    func spreadInviteCell(sender:UIButton) {
//        self.spread = !self.spread;
//        self.listTableView.reloadData();
    }
    
    func originalPricePayFunction(sender:UIButton){
        
    }
    func prePricePayFunction(sender:UIButton){
        if  infoModel.goods_dingjin == "0" {
           let dicParam = NSDictionary(objects: ["0",self.infoModel.goods_id,NSUserInfo.shareInstance().member_id] , forKeys: ["pay_type","goods_id",MEMBER_ID])
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
            NSHttpHelp.httpHelpWithUrl(NSHttpModel.getOrderPayUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
                let dic = result as! NSDictionary;
                let code = dic["code"] as! NSInteger;
                if code == 0 {
                    SVProgressHUD.dismiss();
                    let alert = UIAlertView(title:nil, message: "支付结果：成功！\n请到我的订单中查看", delegate: self, cancelButtonTitle: "确定");
                    alert.show();
                } else {
                    let datas = dic["datas"] as! String;
                    SVProgressHUD.showErrorWithStatus(datas);
                }
                }) { (error:AnyObject!) -> Void in
            }
            return;
        }
        let payVC = UIPaymentViewController(nibName:"UIPaymentViewController", bundle: NSBundle.mainBundle());
        payVC.goodsPrice = self.infoModel.goods_dingjin;
        payVC.goods_id = self.infoModel.goods_id;
        self.navigationController?.pushViewController(payVC, animated: true);
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func didClickImgAction(adModel: ADModel) {
        
    }
    
    func shareActivityData(sender:UIButton){
        var fenxiang = "http://www.baidu.com";
        if self.infoModel.fenxiang_url != "" {
            fenxiang = self.infoModel.fenxiang_url;
        }
        
        let ad = self.infoModel.imagesAD[0] as! ADModel
        let imageData = NSHelper.getImageData(ad.cover)
        
//        UMSocialData.defaultData().urlResource.setResourceType(UMSocialUrlResourceTypeImage, url: fenxiang);
        if sender.tag == 1 {
            UMSocialData.defaultData().extConfig.qqData.url = fenxiang;
            UMSocialData.defaultData().extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
            UMSocialData.defaultData().extConfig.qqData.title = "发现分享"
            
            UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToQQ], content: self.infoModel.goods_name, image: imageData, location: nil, urlResource: nil, presentedController: self, completion: { (response) -> Void in
                if (response.responseCode == UMSResponseCodeSuccess) {
                    SVProgressHUD.showSuccessWithStatus("分享成功");
                } else {
                    SVProgressHUD.showErrorWithStatus("分享失败")
                }
            })
        } else if sender.tag == 2 {
            UMSocialData.defaultData().extConfig.wechatSessionData.url = fenxiang;
            UMSocialData.defaultData().extConfig.wechatSessionData.title = "发现分享"
            UMSocialData.defaultData().extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
            
            UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatSession], content: self.infoModel.goods_name, image: imageData, location: nil, urlResource: nil, presentedController: self, completion: { (response) -> Void in
                if (response.responseCode == UMSResponseCodeSuccess) {
                    SVProgressHUD.showSuccessWithStatus("分享成功");
                } else {
                    SVProgressHUD.showErrorWithStatus("分享失败")
                }
            })
        } else if sender.tag == 3 {
//            let message = WBMessageObject.message() as! WBMessageObject;
//            message.text = "发现分享:\n\(self.infoModel.goods_name)\(fenxiang)"
//            let image = WBImageObject.object() as! WBImageObject;
//            image.imageData = imageData;
//            message.imageObject = image;
//            
//            let authRequest = WBAuthorizeRequest.request() as! WBAuthorizeRequest;
//            authRequest.redirectURI = "https://api.weibo.com/oauth2/default.html";
//            authRequest.scope = "all";
//            
//            let request = WBSendMessageToWeiboRequest.requestWithMessage(message, authInfo: authRequest, access_token: "") as! WBSendMessageToWeiboRequest;
//            WeiboSDK.sendRequest(request);
            
            UMSocialData.defaultData().urlResource.url = fenxiang;
            UMSocialData.defaultData().extConfig.sinaData.shareImage = imageData;
            UMSocialData.defaultData().extConfig.sinaData.shareText = "发现分享:\n\(self.infoModel.goods_name)\(fenxiang)";
            UMSocialControllerService.defaultControllerService().setShareText("发现分享:\n\(self.infoModel.goods_name)\(fenxiang)", shareImage: imageData, socialUIDelegate: self);
            let vc = UMSocialControllerService.defaultControllerService().getSocialShareEditController(UMShareToSina)
            self.presentViewController(vc, animated: true, completion: { () -> Void in
                
            });
        } else {
            UMSocialData.defaultData().extConfig.wechatTimelineData.url = fenxiang;
            UMSocialData.defaultData().extConfig.wechatTimelineData.title = "发现分享:\(self.infoModel.goods_name)"
            UMSocialData.defaultData().extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
            
            UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatTimeline], content: self.infoModel.goods_name, image: imageData, location: nil, urlResource: nil, presentedController: self, completion: { (response) -> Void in
                if (response.responseCode == UMSResponseCodeSuccess) {
                    SVProgressHUD.showSuccessWithStatus("分享成功");
                } else {
                    SVProgressHUD.showErrorWithStatus("分享失败")
                }
            })
        }
    }
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        if response.responseCode == UMSResponseCodeSuccess {
            SVProgressHUD.showSuccessWithStatus("分享成功");
        } else {
            SVProgressHUD.showErrorWithStatus("分享失败")
        }
    }
    
    
    func startTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil;
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerFunction:", userInfo: nil, repeats: true);
        timer!.fire();
    }
    
    func timerFunction(timer:NSTimer){
        
        let cell = self.listTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        if cell != nil {
            let firstCell = cell as! UIFindInfoFirstTableViewCell;
            let array = NSHelper.leftTimeFromStamp(self.left) as NSArray;
            
            let font  = UIFont.systemFontOfSize(13);
            let dayStr = "\(array.objectAtIndex(0).description)天" as NSString;
            firstCell.dayLabel.attributedText = dayStr.switchContentWithFonts([font], withRanges: [NSStringFromRange(NSMakeRange(dayStr.length-1, 1))], withColors: [UIColor.blackColor()]);
            
            let hourStr = "\(array.objectAtIndex(1).description)时" as NSString;
            firstCell.hourLabel.attributedText = hourStr.switchContentWithFonts([font], withRanges: [NSStringFromRange(NSMakeRange(hourStr.length-1, 1))], withColors: [UIColor.blackColor()]);
            
            let minuteStr = "\(array.objectAtIndex(2).description)分" as NSString;
            firstCell.minuteLabel.attributedText = minuteStr.switchContentWithFonts([font], withRanges: [NSStringFromRange(NSMakeRange(minuteStr.length-1, 1))], withColors: [UIColor.blackColor()]);
            
            let second = "\(array.objectAtIndex(3).description)秒" as NSString;
            firstCell.secondLabel.attributedText =  second.switchContentWithFonts([font], withRanges: [NSStringFromRange(NSMakeRange(second.length-1, 1))], withColors: [UIColor.blackColor()]);
        }
        self.left = self.left-1;
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if timer != nil {
            timer?.invalidate()
            timer = nil;
        }
    }
    deinit {
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
