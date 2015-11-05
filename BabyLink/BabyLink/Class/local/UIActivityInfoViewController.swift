//
//  UIActivityInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIActivityInfoViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listTableView.registerNib(UINib(nibName: "UIActivityInfoFirstTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIActivityInfoFirstTableViewCellIndentifier");
        listTableView.registerNib(UINib(nibName: "UIActivityInfoSecondTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIActivityInfoSecondTableViewCellIndentifier");
        listTableView.registerNib(UINib(nibName: "UIActivityInfoThirdTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIActivityInfoThirdTableViewCellIndentifier");
        listTableView.registerNib(UINib(nibName: "UIActivityInfoForthTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIActivityInfoForthTableViewCellIndentifier");
        listTableView.registerNib(UINib(nibName: "UIActivityInfoFifthTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIActivityInfoFifthTableViewCellIndentifier");
        
        let footerView = NSBundle.mainBundle().loadNibNamed("UIActivityInfoFooterView", owner: nil, options: nil).first as! UIActivityInfoFooterView;
        footerView.frame = CGRectMake(0, 0, MainScreenWidth, 57);
        footerView.enrollBtn.addTarget(self, action: "enrollInTheActivity:", forControlEvents: UIControlEvents.TouchUpInside);
        listTableView.tableFooterView = footerView;
    }

    
    //MARK - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 6;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityInfoFirstTableViewCellIndentifier", forIndexPath: indexPath);
            return cell;
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityInfoSecondTableViewCellIndentifier", forIndexPath: indexPath);
            return cell;
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityInfoSecondTableViewCellIndentifier", forIndexPath: indexPath);
            return cell;
        }
        else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityInfoThirdTableViewCellIndentifier", forIndexPath: indexPath);
            return cell;
        }
        else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityInfoForthTableViewCellIndentifier", forIndexPath: indexPath);
            return cell;
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityInfoFifthTableViewCellIndentifier", forIndexPath: indexPath);
            return cell;
        }
    }
    
    
    //MARK - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 416;
        }
        else if indexPath.row == 1 {
            return 200;
        }
        else if indexPath.row == 2 {
            return 84;
        }
        else if indexPath.row == 3 {
            return 172;
        }
        else if indexPath.row == 4 {
            return 166;
        }
        else {
            return 128;
        }
    }
    
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        
//        return footerView;
//    }
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 57;
//    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    //MARK - tableview function
    func enrollInTheActivity(sender:UIButton){
        let joinVC:UIJoinViewController = UIJoinViewController.init(nibName:"UIJoinViewController",bundle:NSBundle.mainBundle())
        self.navigationController?.pushViewController(joinVC, animated: true);
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
