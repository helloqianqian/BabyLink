//
//  UIChooseAddressViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/2.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIChooseAddressViewController: UIBaseViewController , UITableViewDelegate ,UITableViewDataSource ,UISearchBarDelegate{

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var location2D:CLLocationCoordinate2D!
    
    var locationArray:NSMutableArray = NSMutableArray();
    var searchArray:NSMutableArray = NSMutableArray();
    
    var lastVC : UIViewController!;
    
    var dataType = 0;
    
    var city:String!;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "选择小区";
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "userTapContent")
        
        self.searchBar.delegate = self;
        
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier");
        
//        self.getAutoPositionData();
        self.getIndexSearchData()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if self.dataType == 0{
            return locationArray.count;
        }
        return searchArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier");
        var residence:NSResidence!;
        if self.dataType == 0{
            residence =  locationArray.objectAtIndex(indexPath.row) as! NSResidence;
        } else {
            residence =  searchArray.objectAtIndex(indexPath.row) as! NSResidence;
        }
        cell?.textLabel?.text = residence.name;
        return cell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var residence:NSResidence!;
        if self.dataType == 0{
             residence =  locationArray.objectAtIndex(indexPath.row) as! NSResidence;
        } else {
            residence =  searchArray.objectAtIndex(indexPath.row) as! NSResidence;
        }
        
        if lastVC.isKindOfClass(UIFullInfoViewController){
            (lastVC as! UIFullInfoViewController).neighboorField.text = residence.name;
        } else {
            (lastVC as! UIFirstInfoViewController).neighboorField.text = residence.name;
        }
        self.navigationController?.popViewControllerAnimated(true);
        
    }
    
    func userTapContent(){
        if self.searchBar.text == "" {
            NSHelper.showAlertViewWithTip("请输入小区名称");
            return;
        }
        if lastVC.isKindOfClass(UIFullInfoViewController){
            (lastVC as! UIFullInfoViewController).neighboorField.text = self.searchBar.text;
        } else {
            (lastVC as! UIFirstInfoViewController).neighboorField.text = self.searchBar.text;
        }
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    func getAutoPositionData(){
        SVProgressHUD.showWithStatus("正在获取周围小区")
        let dicParam:NSDictionary = NSDictionary(objects: [self.location2D.longitude,self.location2D.latitude] , forKeys: ["lo","la"]);
        NSHttpHelp.httpHelpWithUrlTpye(autoPositionType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //请求成功
                let datas = dic["datas"] as! NSArray;
                for data in datas {
                    let residence = NSResidence()
                    residence.setValuesForKeysWithDictionary(data as! [String : AnyObject])
                    self.locationArray.addObject(residence);
                }
                self.listTableView.reloadData();
            } else {
                //请求失败
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            SVProgressHUD.dismiss();
            }) { (error:AnyObject!) -> Void in
                
        };
    }
    func getIndexSearchData(){
        self.dataType = 1;
        let dicParam:NSDictionary = NSDictionary(objects: [self.searchBar.text!,self.city] , forKeys: ["key","city"]);
        NSHttpHelp.httpHelpWithUrlTpye(indexSearchType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //请求成功
                self.searchArray.removeAllObjects();
                let datas = dic["datas"] as! NSArray;
                for data in datas {
                    let residence = NSResidence()
                    residence.setValuesForKeysWithDictionary(data as! [String : AnyObject])
                    self.searchArray.addObject(residence);
                }
                self.listTableView.reloadData();
            } else {
                //请求失败
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
        };
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.getIndexSearchData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.getIndexSearchData()
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
