//
//  UIParticipateViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/12/2.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIParticipateViewController: UIBaseViewController ,UITableViewDataSource{

    @IBOutlet weak var listTableView:UITableView!;
    @IBOutlet weak var countLabel:UILabel!;
    var logs:NSMutableArray = NSMutableArray();
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "报名详情"
        
        self.countLabel.text = "共\(self.logs.count)人报名"
        
        listTableView.dataSource = self;
        listTableView.registerNib(UINib(nibName: "UIParticipateTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIParticipateCellIdentifier");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.logs.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIParticipateCellIdentifier", forIndexPath: indexPath) as! UIParticipateTableViewCell;
        let log = self.logs[indexPath.row] as! NSLogListObject;
        cell.setContentData(log);
        return cell;
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
