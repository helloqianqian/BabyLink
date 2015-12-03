//
//  UICreateANViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/28.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UICreateANViewController: UIBaseViewController ,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var introLabel: UITextView!
    @IBOutlet weak var introTip: UILabel!
    @IBOutlet weak var needBtn: UIButton!
    @IBOutlet weak var needTipLabel: UILabel!
    @IBOutlet weak var needTextView: UITextView!
    @IBOutlet weak var confirmBtn: UIButton!
    
    
    @IBOutlet weak var heightOfNeed: NSLayoutConstraint!
    @IBOutlet weak var heightOfIntro: NSLayoutConstraint!
    var paramArray:NSMutableArray!=NSMutableArray();
    var loadPic = false;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "发布活动"
        self.setUI();
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
    }

    func setUI(){
        introLabel.layer.borderColor = SGrayBorderColor.CGColor;
        introLabel.layer.borderWidth = 0.5;
        introLabel.layer.cornerRadius = 4;
        
        needTextView.layer.borderWidth = 0.5;
        needTextView.layer.borderColor = SGrayBorderColor.CGColor;
        needTextView.layer.cornerRadius = 4;
        
        confirmBtn.makeBackGroundColor_Red();
        
        introLabel.delegate = self;
        needTextView.delegate = self;
        if iphone4 {
            heightOfIntro.constant = 110;
            heightOfNeed.constant = 70;
        }
    }
    
    @IBAction func commitData(sender: UIButton) {
        if introLabel.text == "" {
            NSHelper.showAlertViewWithTip("请输入活动介绍")
            return;
        }
        if needBtn.selected && needTextView.text == "" {
            NSHelper.showAlertViewWithTip("请输入需要提供的支持")
            return;
        }
        let image  = self.addImage.currentBackgroundImage;
        if self.loadPic {
            let  imageData:NSData = NSHelper.fileOfPressedImage(image, withType: rectangleType);
            self.uploadImageworks([imageData]);
        } else {
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
            self.createActivity("")
        }
        
        
        
    }
    //["活动主题:","活动地点:","报名截止:","集合时间:","集合地点:","上限人数:","活动费用:","支付方式:","交通工具:","联系人:","联系电话:"];
    func createActivity(image:String){
        let is_help = self.needBtn.selected ? "1" : "0"
        let array:NSMutableArray = NSMutableArray(array: self.paramArray);
        array.addObjectsFromArray([is_help,self.needTextView.text,introLabel.text,image,NSUserInfo.shareInstance().member_id]);
        let dicParam:NSDictionary = NSDictionary(objects: array as [AnyObject] , forKeys: ["title","activity_address","end_time","jihe_time","jihe_address","max_man","price","pay_way","utils","link_name","link_mobile","is_help","help","info","images",MEMBER_ID]);
        NSLog("______\(dicParam)")
        NSHttpHelp.httpHelpWithUrlTpye(addActType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                SVProgressHUD.showSuccessWithStatus("发布成功")
                createSuccess = true;
                self.navigationController?.popToRootViewControllerAnimated(true);
            } else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
        };
    }
    func  uploadImageworks(imageDatas:NSArray)
    {
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
        NSHttpHelp.uploadUserIconWithImageData(imageDatas as [AnyObject], withUrl: NSHttpModel.getUploadImageUrl(), withResult: { (result:AnyObject!) -> Void in
            let code = result["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                let datas = result["datas"] as! String;
                NSLog("图片上传成功：：：：\(datas)")
                self.createActivity(datas);
            } else {
                let datas = result["datas"] as! String;
                NSLog("图片上传失败：：：：\(datas)")
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }, withFailure: { (error:AnyObject!) -> Void in
                SVProgressHUD.showErrorWithStatus("上传失败");
            }) { (progress:Float) -> Void in
                NSLog("progress:\(progress)")
        }
    }
    
    
    @IBAction func addActivityImage(sender: UIButton) {
        self.introLabel.resignFirstResponder();
        self.needTextView.resignFirstResponder();
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
            self.loadPic = true
            let  dic:NSDictionary = info as NSDictionary;
            let  image:UIImage = dic.objectForKey(UIImagePickerControllerEditedImage) as! UIImage;
            self.addImage.setBackgroundImage(image, forState: UIControlState.Normal);
        })
    }
    
    
    
    
    
    @IBAction func needSupport(sender: UIButton) {
        sender.selected = !sender.selected;
        needTextView.editable = sender.selected;
        if !sender.selected {
            needTextView.text = "";
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        var hide = true;
        if textView.text == "" {
            hide = false;
        }
        if textView == introLabel {
            introTip.hidden = hide;
        } else {
            needTipLabel.hidden = hide;
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        var frame = self.view.frame;
        if iphone6Plus {
            if textView == needTextView {
                frame.origin.y = 24;
            }
        } else if iphone6 {
            if textView ==  needTextView{
                frame.origin.y = -20;
            }
        } else if iphone5 {
            if textView ==  needTextView{
                frame.origin.y = -106;
            } else {
                frame.origin.y = 4;
            }
        } else if iphone4 {
            if textView == introLabel{
                frame.origin.y = 14;
            } else {
                frame.origin.y = -90;
            }
        }
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.view.frame = frame;
            }) { (finish:Bool) -> Void in
                
        }
    }
    func textViewDidEndEditing(textView: UITextView) {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            var frame = self.view.frame;
            frame.origin.y = 64;
            self.view.frame = frame;
            }) { (finish:Bool) -> Void in
                
        }
    }
    func keyboardWillShow(notification:NSNotification){
        self.addGesture();
    }
    func keyboardWillHide(notification:NSNotification){
        self.removeGesture();
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
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
