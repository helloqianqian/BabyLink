//
//  MyFriendsViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/13.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class MyFriendsViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var neighborBtn: UIButton!
    @IBOutlet weak var friendsBtn: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的好友"
        neighborBtn.makeBackGroundColor_PurpleSelected();
        friendsBtn.makeBackGroundColor_PurpleSelected();
        
        listTableView.dataSource = self;
        listTableView.delegate = self;
        self.listTableView.registerNib(UINib(nibName: "UIFriendsTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFriendsTableViewCellIdentifier");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIFriendsTableViewCellIdentifier", forIndexPath: indexPath);
        return cell
    }
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5;
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5;
    }
    
    
    
    @IBAction func neighborlist(sender: UIButton) {
        if !sender.selected {
            sender.selected = true
            friendsBtn.selected = false;
        }
    }
    @IBAction func friendslist(sender: UIButton) {
        if !sender.selected {
            sender.selected = true
            neighborBtn.selected = false;
        }
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
