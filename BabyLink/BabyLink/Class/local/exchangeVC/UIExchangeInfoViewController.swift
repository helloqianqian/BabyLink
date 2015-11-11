//
//  UIExchangeInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/6.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIExchangeInfoViewController: UIBaseViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var topOfLabel: NSLayoutConstraint!
    @IBOutlet weak var exchangeBtn: UIButton!
    
    @IBOutlet weak var backView2: UIView!
    
    @IBOutlet weak var contactLabel: UILabel!
    
    @IBOutlet weak var topOfBtn: NSLayoutConstraint!
    
    
    var cellContent:UIExchangeTableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var frame = CGRectMake(0, 0, MainScreenWidth, 0);
        if iphone6Plus {
            frame.size.height = 270;
            topOfLabel.constant =  278;
        } else if iphone6 {
            frame.size.height = 254;
            topOfLabel.constant =  262;
        } else {
            frame.size.height = 230;
            topOfLabel.constant =  238;
        }
        cellContent = NSBundle.mainBundle().loadNibNamed("UIExchangeTableViewCell", owner: nil, options: nil).first as! UIExchangeTableViewCell;
        cellContent.frame = frame;
        cellContent.checkBtn.hidden = true;
        cellContent.likeBtn.hidden = false;
        cellContent.numLabel.hidden = false;
        self.view.addSubview(cellContent)
        
        backView.layer.borderWidth = 0.5;
        backView.layer.borderColor = hexRGB(0xD3D4D5).CGColor;
        backView2.layer.borderColor = hexRGB(0xD3D4D5).CGColor;
        backView2.layer.borderWidth = 0.5;
        
        topOfBtn.constant = 96;

        exchangeBtn.makeBackGroundColor_Red();
    }
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated);
//        NSLog("%f,,,%f,,,%f,,,%f,,,,,%f,%f", cellContent.frame.origin.x,cellContent.frame.origin.y,cellContent.frame.width,cellContent.frame.height,MainScreenWidth,MainScreenHeight)
//        
//    }
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated);
//        NSLog("%f,,,%f,,,%f,,,%f,,,,,%f,%f", cellContent.frame.origin.x,cellContent.frame.origin.y,cellContent.frame.width,cellContent.frame.height,MainScreenWidth,MainScreenHeight)
//        
//    }
    
    @IBAction func checkGoodsInfo(sender: UIButton) {
        
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
