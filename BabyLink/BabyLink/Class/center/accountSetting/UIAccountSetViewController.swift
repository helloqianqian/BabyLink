//
//  UIAccountSetViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/11.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit


class UIAccountSetViewController: UIBaseViewController ,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var headIconBtn: UIButton!
    @IBOutlet weak var bigHeadIconBtn: UIButton!
    @IBOutlet weak var nickNameBtn: UIButton!
    @IBOutlet weak var nikeName: UILabel!
    @IBOutlet weak var phoneNumBtn: UIButton!
    @IBOutlet weak var passwordBtn: UIButton!
    @IBOutlet weak var quiteBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "账号设置"
        self.setUI();
        self.setContentData();
    }
    
    func setUI() {
        bigHeadIconBtn.layer.cornerRadius = 30;
        bigHeadIconBtn.layer.masksToBounds = true;
        
        headIconBtn.makeBackGroundColor_White();
        nickNameBtn.makeBackGroundColor_White();
        phoneNumBtn.makeBackGroundColor_White();
        passwordBtn.makeBackGroundColor_White();
        quiteBtn.makeBackGroundColor_Red();
    }
    
    func setContentData() {
        nikeName.text = "昵称:\(NSUserInfo.shareInstance().member_name)";
        if NSUserInfo.shareInstance().member_avar != "" {
            bigHeadIconBtn.sd_setBackgroundImageWithURL(NSURL(string: NSUserInfo.shareInstance().member_avar), forState: UIControlState.Normal, placeholderImage: nil);
        }
    }
    func resetNickname(){
        nikeName.text = "昵称:\(NSUserInfo.shareInstance().member_name)";
    }
    @IBAction func exchangeHeadIcon(sender: UIButton) {
        let actionSheet:UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "相册", "相机")
        actionSheet.showInView(self.view);
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                let imagePickerAlbum = UIImagePickerController()
                imagePickerAlbum.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                imagePickerAlbum.delegate = self
                imagePickerAlbum.allowsEditing = true
                self.presentViewController(imagePickerAlbum, animated: true, completion: { () -> Void in
                })
            } else {
                
            }
        } else if buttonIndex == 2 {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                let imagePickerCamera = UIImagePickerController()
                imagePickerCamera.sourceType = UIImagePickerControllerSourceType.Camera
                imagePickerCamera.delegate = self
                imagePickerCamera.allowsEditing = true
                self.presentViewController(imagePickerCamera, animated: true, completion: { () -> Void in
                })
            } else {
                
            }
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            let  dic:NSDictionary = info as NSDictionary;
            let  image:UIImage = dic.objectForKey(UIImagePickerControllerEditedImage) as! UIImage;
            let  imageData:NSData = NSHelper.fileOfPressedImage(image);
            NSLog("\(imageData.length)")
            self.uploadImageworks(imageData);
        })
        
    }
    
    
    func  uploadImageworks(imageData:NSData)
    {
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
        let dicParam:NSDictionary = NSDictionary(objects: [imageData,"file","head.jpg"] , forKeys: ["imageData","imageName","fileName"]);
        NSHttpHelp.uploadUserIconWithImageData(dicParam as [NSObject : AnyObject], withResult: { (result:AnyObject!) -> Void in
            let code = result["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                SVProgressHUD.showSuccessWithStatus("上传成功")
                let datas = result["datas"] as! String;
                NSUserInfo.shareInstance().member_avar = datas;
                appDelegate.recordLastUserIcon()
                self.bigHeadIconBtn.sd_setBackgroundImageWithURL(NSURL(string: NSUserInfo.shareInstance().member_avar), forState: UIControlState.Normal, placeholderImage: nil);
            } else {
                let datas = result["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            
            }, withFailure: { (error:AnyObject!) -> Void in
                SVProgressHUD.showErrorWithStatus("上传失败");
            }) { (progress:Float) -> Void in
                NSLog("progress:\(progress)")
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    
    
    
    @IBAction func changeNikeName(sender: UIButton) {
        let nicknameVC = UINikenameViewController(nibName:"UINikenameViewController" ,bundle: NSBundle.mainBundle());
        nicknameVC.lastVC = self;
        self.navigationController?.pushViewController(nicknameVC, animated: true);
    }
    @IBAction func changePhoneNum(sender: UIButton) {
        let nicknameVC = UIChangePhoneViewController(nibName:"UIChangePhoneViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(nicknameVC, animated: true);
    }
    @IBAction func changePassword(sender: UIButton) {
        let nicknameVC = UIChangePSWViewController(nibName:"UIChangePSWViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(nicknameVC, animated: true);
    }
    @IBAction func quite(sender: UIButton) {
        appDelegate.exchangeRootViewController(false)
    }
    
    @IBAction func checkBigHeadImage(sender: UIButton) {
        
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
