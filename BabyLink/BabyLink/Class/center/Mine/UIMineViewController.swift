//
//  UIMineViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/12.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIMineViewController: UIBaseViewController {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var activityBtn: UIButton!
    @IBOutlet weak var topicBtn: UIButton!
    @IBOutlet weak var exchangeBtn: UIButton!
    @IBOutlet weak var showBtn: UIButton!
    @IBOutlet weak var friendsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的主页"
        headIcon.layer.cornerRadius = 32;
    }

    @IBAction func enterActivityPage(sender: UIButton) {
        let myAcVC = MyActivityViewController(nibName:"MyActivityViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(myAcVC, animated: true);
    }
    @IBAction func enterTopicPage(sender: UIButton) {
        let myAcVC = MyTopicViewController(nibName:"MyTopicViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(myAcVC, animated: true);
    }
    @IBAction func enterExchangeBtn(sender: UIButton) {
        let myAcVC = MyExchangeViewController(nibName:"MyExchangeViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(myAcVC, animated: true);
    }
    @IBAction func enterShowPage(sender: UIButton) {
        let myAcVC = MyShowViewController(nibName:"MyShowViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(myAcVC, animated: true);
    }
    @IBAction func enterFriendsPage(sender: UIButton) {
        let myAcVC = MyFriendsViewController(nibName:"MyFriendsViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(myAcVC, animated: true);
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
