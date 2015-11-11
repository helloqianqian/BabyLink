//
//  UIConvertViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/10.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIConvertViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var unCostBtn: UIButton!
    @IBOutlet weak var costBtn: UIButton!
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "兑换码"
        
        unCostBtn.makeBackGroundColor_PurpleSelected();
        costBtn.makeBackGroundColor_PurpleSelected();
        
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.registerNib(UINib(nibName: "UIConverCodeTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIConverCodeTableViewCellIdentifier")
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIConverCodeTableViewCellIdentifier", forIndexPath: indexPath);
        return cell;
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 97;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let infoVC = UIConverInfoViewController(nibName:"UIConverInfoViewController",bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(infoVC, animated: true);
    }
    
    
    
    @IBAction func getUncostListFunction(sender: UIButton) {
        sender.selected = true;
        costBtn.selected = false;
        
    }
    @IBAction func getCostListFunction(sender: UIButton) {
        sender.selected = true;
        unCostBtn.selected = false;
        
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
