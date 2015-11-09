//
//  UIShowViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIShowViewController: UIBaseViewController ,UIShowNavigationViewDelegate{

    var titleView:UIShowNavigationView!
    var linkView:UILinkView!;
    var squareView:UISquareView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleView = NSBundle.mainBundle().loadNibNamed("UIShowNavigationView", owner: nil, options: nil).first as! UIShowNavigationView;
        titleView.selectedIndex = 0;
        titleView.delegate = self;
        titleView.frame = CGRectMake(0, 0, MainScreenWidth, 44)
        self.navigationItem.titleView = titleView;
        
        
        let viewFrame = self.view.frame;
        
        squareView = NSBundle.mainBundle().loadNibNamed("UISquareView", owner: nil, options: nil).first as! UISquareView;
        squareView.frame = viewFrame;
//        squareView.delegate = self;
        self.view.addSubview(squareView);
        
        linkView = NSBundle.mainBundle().loadNibNamed("UILinkView", owner: nil, options: nil).first as! UILinkView;
        linkView.frame = viewFrame;
        //        linkView.delegate = self;
        self.view.addSubview(linkView);
    }

    func didSelectedAtIndex(index: Int) {
        switch index {
        case 0:
            self.view.bringSubviewToFront(linkView)
            break;
        case 1:
            self.view.bringSubviewToFront(squareView)
            break;
        default:
            break;
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
