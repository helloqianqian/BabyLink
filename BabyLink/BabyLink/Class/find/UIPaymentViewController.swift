//
//  UIPaymentViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/9.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIPaymentViewController: UIBaseViewController,UIAlertViewDelegate{

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var payTypeLabel: UILabel!
    @IBOutlet weak var payMoneyLabel: UILabel!
    @IBOutlet weak var nextView: UIView!
    
    @IBOutlet weak var weixinPay: UIButton!
    @IBOutlet weak var aliPay: UIButton!
    @IBOutlet weak var payBtn: UIButton!
    
//    var listModel:NSInfoFind!=NSInfoFind();
    var goodsPrice = "";
    var payType=0;
    var goods_id = ""
    var order_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "支付"
        
        topView.layer.borderColor = hexRGB(0xACACB4).CGColor;
        topView.layer.borderWidth = 0.5;
        
        nextView.layer.borderColor = hexRGB(0xACACB4).CGColor;
        nextView.layer.borderWidth = 0.5;
        
        payBtn.makeBackGroundColor_Red();
        
        self.payMoneyLabel.text = "￥\(self.goodsPrice)"
        if self.payType == 1 {
            payTypeLabel.text = "支付尾款："
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "paySuccess:", name: "UIPaymentSuccessNotification", object: nil);
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    func paySuccess(notification:NSNotification){
        self.navigationController?.popToRootViewControllerAnimated(true);
    }
    @IBAction func weixinPaySelect(sender: UIButton) {
        sender.selected = true;
        aliPay.selected = false;
    }
    @IBAction func aliPaySelect(sender: UIButton) {
        sender.selected = true;
        weixinPay.selected = false;
    }
    @IBAction func payNowFunction(sender: UIButton) {
        if !aliPay.selected && !weixinPay.selected {
            NSHelper.showAlertViewWithTip("请选择付款方式");
            return;
        }
        var payway = "1";
        if weixinPay.selected{
            payway = "2";
        }
        
        var dicParam:NSDictionary!;
        if self.payType == 0 {
            dicParam = NSDictionary(objects: [payway,"1",self.goods_id,NSUserInfo.shareInstance().member_id] , forKeys: ["pay_way","pay_type","goods_id",MEMBER_ID])
        } else {
            dicParam = NSDictionary(objects: [payway,"2",order_id,self.goods_id,NSUserInfo.shareInstance().member_id] , forKeys: ["pay_way","pay_type","order_id","goods_id",MEMBER_ID])
        }
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
        NSHttpHelp.httpHelpWithUrl(NSHttpModel.getOrderPayUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                SVProgressHUD.dismiss();
                if self.weixinPay.selected{
                    let datas = dic["datas"] as! NSDictionary
                    let req:PayReq = PayReq();
                    req.partnerId = datas["partnerid"] as! String;
                    req.prepayId = datas["prepayid"] as! String;
                    req.nonceStr = datas["noncestr"] as! String;
                    req.timeStamp = (datas["timestamp"] as! NSNumber).unsignedIntValue;
                    req.package = "Sign=WXPay";
                    req.sign = datas["sign"] as! String;
                    WXApi.sendReq(req);
                } else {
                    let datas = dic["datas"] as! NSDictionary
                    let body = datas["body"] as! String;
                    let out_trade_no = datas["out_trade_no"] as! String;
                    let subject = datas["subject"] as! String;
                    let total_fee = datas["total_fee"] as! String;
                    var notify_url:String;
                    if self.payType == 0 {
                        notify_url = NSHttpModel.getAliDJUrl();
                    } else {
                        notify_url = NSHttpModel.getAliWKUrl();
                    }
                    
                    let partner = "2088512842343400";
                    let seller_id = "koukou0226@sina.com";
                    let privateKey = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAOQ6XhqQY6Kh2Di6VN6EOaKMV/uLfWMRUJcFMeEOfkQRKqvD47tM0NnEFR+BMRWkcItPqGXqECWHXBW3TiSB9TtwuePT2fAXvXjlQrrmXDd35ItcuPdqyejChxvQiZtcyfJEwQgHyxFoP29P1tmaqDhcqaJhbhdBjaj7tr5QGcbtAgMBAAECgYEArfUzPyopV4/nAC4+fDDqwVQZx9jlpLpQ5BuIjlN+uKEhFjVEgsIlOqcztoTBhg6F3hnEcJH85q4K6V6DyF3qLYime/hRQhcnB/gmCaEpkZdKyZYCod9bFyR0ZijARfi09Fm1eGsYzeoF88dAlDqJ2qd2b5T8xnDs0jqLUtnV+f0CQQD6K6VeN6a4dWArYryicj5oWtm/cgggc1t+DCNfQfJz6jGbXPrrdYmCYsu2XIEmdEFtXaZ0t8f3OpDz2zV59rNrAkEA6YvTtzhdYztz+kdM6OLMplVr2exNjRwKCzPe6O6Tlyyw8MKMDKvo2u5rBo7NI+l8EM1qjppxo22uPgoXacddBwJBAJ/MHVdvaNlOcF2GNkP1gZOa5Jf7OOGxjfGXw0hnkX0lTQaWf9jDPVDB1qnnsL9lZx16woavldV/3XNGxIPhZ30CQBh7VehA+lkqpE+6Ja/MBpPxJGslwENoiwz9lQJp8ALK5ol2e2PgqXo5v/JiCdMX6K+COQdV3U+6caeDO00VXwUCQGU1CAFX2YTaj3jKbyyEf2TRjW2uYHTQc6ky4+/s8Z3I+jh/iOKTt6BfmlWaci7M3waWfU2cUSDCuO7JYdSGOrg=";
                    
                    let orderSpec = "partner=\""+partner+"\"&seller_id=\""+seller_id+"\"&out_trade_no=\""+out_trade_no+"\"&subject=\""+subject+"\"&body=\""+body+"\"&total_fee=\""+total_fee+"\"&notify_url=\""+notify_url+"\"&service=\"mobile.securitypay.pay\""+"&payment_type=\"1\""+"&_input_charset=\"utf-8\""+"&it_b_pay=\"30m\""+"&show_url=\"m.alipay.com\""
                    NSLog("orderSpec:%@",orderSpec);
                    
                    let signer:DataSigner = CreateRSADataSigner(privateKey);
                    let signedStr = signer.signString(orderSpec);
                    let orderStr = "\(orderSpec)&sign=\"\(signedStr)\"&sign_type=\"RSA\""
                    AlipaySDK.defaultService().payOrder(orderStr, fromScheme: "openBabyLink", callback: { (result) -> Void in
                        NSLog("reslut = %@",result);
                        let resultStatus = result["resultStatus"] as! String
                        if resultStatus == "9000" {
                            let alert = UIAlertView(title:nil, message: "支付结果：成功！\n请到我的订单中查看", delegate: self, cancelButtonTitle: "确定");
                            alert.show();
                        } else {
                            NSHelper.showAlertViewWithTip("支付结果：失败!")
                        }
                    })
                }
            } else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
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
