//
//  UIFindViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFindViewController: UIBaseViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var rangeBtn: UIButton!
    
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoryBtn.makeBackGroundColor_White();
        rangeBtn.makeBackGroundColor_White();
        
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.registerNib(UINib(nibName: "UIFindTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFindTableViewCellIdentifier")
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIFindTableViewCellIdentifier", forIndexPath: indexPath);
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if iphone6Plus {
            return 325;
        } else if iphone6 {
            return 300;
        } else {
            return 265;
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let infoVC:UIFindInfoViewController = UIFindInfoViewController(nibName:"UIFindInfoViewController", bundle: NSBundle.mainBundle())
        infoVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(infoVC, animated: true);
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
