//
//  UIConverInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/10.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIConverInfoViewController: UIBaseViewController {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var centerNameLabel: UILabel!
    @IBOutlet weak var deadLineLabel: UILabel!
    @IBOutlet weak var codeImage: UIImageView!

    @IBOutlet weak var tipImage: UIImageView!
    @IBOutlet weak var keyLabel: UILabel!
    
    var order:NSOrder! = NSOrder();
    
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    var type = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "兑换码"
        backView.layer.borderColor = SGrayBorderColor.CGColor;
        backView.layer.borderWidth = 0.5;
        
        self.setUI()
    }

    func setUI(){
        centerNameLabel.text = order.good.goods_name;
        deadLineLabel.text = "有效期至\(order.good.use_time)";
        codeImage.sd_setImageWithURL(NSURL(string: order.qrcode), placeholderImage: nil);
        keyLabel.text = order.order_code;
        if type == 1 {
            tipImage.hidden = false;
        }
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
