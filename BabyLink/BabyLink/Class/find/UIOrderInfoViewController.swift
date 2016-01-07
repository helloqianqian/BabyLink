//
//  UIOrderInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/9.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIOrderInfoViewController: UIBaseViewController ,UIAlertViewDelegate{

    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var centerNameLabel: UILabel!
    @IBOutlet weak var preMoneyLabel: UILabel!
    @IBOutlet weak var tipImage: UIImageView!
    @IBOutlet weak var dingjiaLabel: UILabel!
    
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var continuePayBtn: UIButton!
    @IBOutlet weak var payBackBtn: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var heightOfMiddle: NSLayoutConstraint!
    
    
    @IBOutlet weak var info: UIButton!
    @IBOutlet weak var arrowImage: UIImageView!
    
    var type = 0;
    
    var order:NSOrder! = NSOrder();
    var superVC:UIBaseViewController!;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        topView.layer.borderColor = hexRGB(0xACACB4).CGColor;
        topView.layer.borderWidth = 0.5;
        
        nextView.layer.borderColor = hexRGB(0xACACB4).CGColor;
        nextView.layer.borderWidth = 0.5;
        
        thirdView.layer.borderColor = hexRGB(0xACACB4).CGColor;
        thirdView.layer.borderWidth = 0.5;
        
        continuePayBtn.makeBackGroundColor_Purple()
        payBackBtn.makeBackGroundColor_Gray();
        
        info.layer.borderWidth = 0.5;
        info.layer.borderColor = hexRGB(0xACACB4).CGColor;
        
        self.setUI();
    }

    func setUI(){
        /*0-未付定金，
        已付定金
        2,4(免费)--已付全款
        3—已退款
        4：免费，
        5：已取消,
        6:退款申请中，
        7：已消费
        ，8：已结算
*/
        contentImage.sd_setImageWithURL(NSURL(string: self.order.good.image_url), placeholderImage: nil);
        centerNameLabel.text = self.order.good.goods_name;
        switch order.order_status {
        case 1:
            self.title = "已付订金"
            preMoneyLabel.text = "￥\(self.order.good.goods_dingjin)"
            tipImage.image = UIImage(named: "diafuweikuan")
            heightOfMiddle.constant = 0;
            
            orderNumber.text = "订单编号：\(self.order.order_no)";
            timeLabel.text = "下单时间：\(self.order.add_time)";
            
            if self.order.good.end_status == 0 {
                self.payBackBtn.addTarget(self, action: "tuikuan", forControlEvents: UIControlEvents.TouchUpInside);
                self.continuePayBtn.enabled = false;
            } else {
                self.payBackBtn.hidden = true;
                self.continuePayBtn.addTarget(self, action: "zhifuweikuan", forControlEvents: UIControlEvents.TouchUpInside);
            }
            break;
        case 2,4,7,8:
            self.title = "已付全款"
            preMoneyLabel.text = "￥\(self.order.good.goods_price)"
            
            let tipStr = "消费码 \(self.order.order_code)" as NSString;
            tipLabel.attributedText = tipStr.switchContentWithFonts([UIFont.systemFontOfSize(15)], withRanges: [NSStringFromRange(NSMakeRange(0, 3))], withColors: [SGrayBorderColor]);
            
            orderNumber.text = "订单编号：\(self.order.order_no)";
            timeLabel.text = "下单时间：\(self.order.add_time)";
            
            if order.order_status == 7 || order.order_status == 8 {
                tipImage.image = UIImage(named: "已消费")
                bottomView.hidden = true;
            } else {
                tipImage.image = UIImage(named: "未消费")
                self.payBackBtn.hidden = true;
                continuePayBtn.makeBackGroundColor_Gray();
                continuePayBtn.setTitle("退款", forState: UIControlState.Normal)
                self.continuePayBtn.addTarget(self, action: "tuikuan", forControlEvents: UIControlEvents.TouchUpInside);
            }
            break;
        case 3,6:
            bottomView.hidden = true;
            tipLabel.textColor = SPurpleBtnColor;
            if self.order.refund_status == 0{
                tipLabel.text = "实退金额： \(self.order.good.goods_dingjin)";
            } else {
                tipLabel.text = "实退金额： \(self.order.good.goods_weikuan)";
            }
            
            orderNumber.text = "订单编号：\(self.order.order_no)";
            timeLabel.text = "下单时间：\(self.order.add_time)";
            
            dingjiaLabel.font = UIFont.systemFontOfSize(14);
            preMoneyLabel.font = UIFont.systemFontOfSize(14);
            dingjiaLabel.hidden = false;
            dingjiaLabel.text = "定价：\(self.order.good.goods_price)"
            preMoneyLabel.text = "订金：\(self.order.good.goods_dingjin)"
            
            if self.order.order_status == 3 {
                self.title = "已退款"
                tipImage.image = UIImage(named: "已退款")
            } else {
                self.title = "退款中"
                tipImage.image = UIImage(named: "退款申请中")
            }
            break;
        default:break;
        }
        if type == 1 {
            info.hidden = false;
            arrowImage.hidden = false;
        }
    }
    
    @IBAction func checkInfo(sender: UIButton) {
        let infoVC:UIFindInfoViewController = UIFindInfoViewController(nibName:"UIFindInfoViewController", bundle: NSBundle.mainBundle())
        let findModel = NSFind();
        findModel.goods_id = self.order.goods_id;
        infoVC.listModel = findModel;
        self.navigationController?.pushViewController(infoVC, animated: true);
    }
    
    func tuikuan(){
        if self.order.order_status == 1 {
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear)
            let dicParam = NSDictionary(objects: ["1",order.order_id,NSUserInfo.shareInstance().member_id] , forKeys: ["type","order_id","member_id"]);
            NSHttpHelp.httpHelpWithUrl(NSHttpModel.getOrderRefundUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
                let dic = result as! NSDictionary;
                let code = dic["code"] as! NSInteger;
                if code == 0 {
                    SVProgressHUD.showSuccessWithStatus("退款申请成功");
                    self.navigationController?.popViewControllerAnimated(true);
                } else {
                    let datas = dic["datas"] as! String;
                    SVProgressHUD.showErrorWithStatus(datas);
                }
                }) { (error:AnyObject!) -> Void in
            }
        } else {
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear)
            let dicParam = NSDictionary(objects: ["2",order.order_id,NSUserInfo.shareInstance().member_id] , forKeys: ["type","order_id","member_id"]);
            NSHttpHelp.httpHelpWithUrl(NSHttpModel.getOrderRefundUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
                let dic = result as! NSDictionary;
                let code = dic["code"] as! NSInteger;
                if code == 0 {
                    SVProgressHUD.showSuccessWithStatus("退款申请成功");
                    self.navigationController?.popViewControllerAnimated(true);
                } else {
                    let datas = dic["datas"] as! String;
                    SVProgressHUD.showErrorWithStatus(datas);
                }
                }) { (error:AnyObject!) -> Void in
            }
        }
    }
    
    func zhifuweikuan(){
        if order.good.goods_weikuan == "0" {
            let dicParam = NSDictionary(objects: ["0",self.order.goods_id,NSUserInfo.shareInstance().member_id] , forKeys: ["pay_type","goods_id",MEMBER_ID])
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
        } else {
            let payVC = UIPaymentViewController(nibName:"UIPaymentViewController", bundle: NSBundle.mainBundle());
            payVC.goodsPrice = order.good.goods_weikuan;
            payVC.goods_id = order.goods_id;
            payVC.payType = 1;
            payVC.order_id = order.order_id;
            self.navigationController?.pushViewController(payVC, animated: true);
        }
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.navigationController?.popToRootViewControllerAnimated(true);
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
