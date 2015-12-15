//
//  UICreateTalkViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UICreateTalkViewController: UIBaseViewController ,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    @IBOutlet weak var addImageBtn3: UIButton!
    @IBOutlet weak var addImageBtn2: UIButton!
    @IBOutlet weak var addImageBtn1: UIButton!
    @IBOutlet weak var addImageBtn: UIButton!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var seeAllBtn: UIButton!
    @IBOutlet weak var seePartBtn: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var faceBtn: UIButton!
    @IBOutlet weak var weixinBtn: UIButton!
    @IBOutlet weak var weiboBtn: UIButton!
    
    
    @IBOutlet weak var tipLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "秀一下"
        self.setUI();
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
    }
    func setUI(){
        backView.layer.cornerRadius = 4;
        backView.layer.masksToBounds = true;
        backView.layer.borderColor = SGrayBorderColor.CGColor;
        backView.layer.borderWidth = 0.5;
        
        sendBtn.makeBackGroundColor_Red();
        contentTextView.delegate = self;
        
        if iphone4 {
            contentTextView.returnKeyType = UIReturnKeyType.Done;
        }
    }
    
    @IBAction func addImageFunction(sender: UIButton) {
        contentTextView.resignFirstResponder();
        if sender.selected {
            let actionSheet:UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "删除")
            actionSheet.showInView(self.view);
        } else {
            let actionSheet:UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "相册", "相机")
            actionSheet.showInView(self.view);
        }
        
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            
            if addImageBtn.selected {
                addImageBtn.selected = false;
                addImageBtn.setBackgroundImage(UIImage(named: "加"), forState: UIControlState.Normal)
            } else {
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                    let imagePickerAlbum = UIImagePickerController()
                    imagePickerAlbum.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                    imagePickerAlbum.delegate = self
                    imagePickerAlbum.allowsEditing = true
                    self.presentViewController(imagePickerAlbum, animated: true, completion: { () -> Void in
                    })
                } else {
                    
                }
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
            self.addImageBtn.setBackgroundImage(image, forState: UIControlState.Normal);
            self.addImageBtn.selected = true;
        })
    }
    
    func createAShow(imageUrl:String){
        let flag = self.seeAllBtn.selected ? "1" : "2"
        let dicParam:NSDictionary = NSDictionary(objects: [self.contentTextView.text!,imageUrl,NSUserInfo.shareInstance().member_id,flag] , forKeys: ["info","image",MEMBER_ID,"flag"]);
        NSHttpHelp.httpHelpWithUrlTpye(addXiuType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                SVProgressHUD.showSuccessWithStatus("发布成功")
                showLinkLoad = true;
                createSuccess = true;
                self.navigationController?.popViewControllerAnimated(true);
            }else {
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
                self.createAShow(datas);
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
    @IBAction func faceFunction(sender: UIButton) {
    }
    @IBAction func weiboFunction(sender: UIButton) {
    }
    @IBAction func weixinFunction(sender: UIButton) {
    }
    @IBAction func chooseRange(sender: UIButton) {
        sender.selected = true;
        if sender == seeAllBtn {
            seePartBtn.selected = false;
        } else {
            seeAllBtn.selected = false;
        }
    }
    @IBAction func sendFunction(sender: UIButton) {
        if !self.addImageBtn.selected {
            NSHelper.showAlertViewWithTip("请先选择图片");
            return;
        }
        if self.contentTextView.text == "" {
            NSHelper.showAlertViewWithTip("请输入内容");
            return;
        }
        if !self.seeAllBtn.selected && !self.seePartBtn.selected {
            NSHelper.showAlertViewWithTip("请选择可见范围");
            return;
        }
        let  imageData:NSData = NSHelper.fileOfPressedImage(self.addImageBtn.currentBackgroundImage, withType: squareType);
        self.uploadImageworks([imageData]);
    }
    
    func textViewDidChange(textView: UITextView) {
        if textView.text == "" {
            self.tipLabel.hidden = false;
        } else {
            self.tipLabel.hidden = true;
        }
    }
    func textViewDidBeginEditing(textView: UITextView) {
        var frame = self.view.frame;
        if iphone5 {
            frame.origin.y = 4;
        } else if iphone4 {
            frame.origin.y = -26;
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
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if iphone4 {
            if text == "\n" {
                textView.resignFirstResponder();
                return false;
            }
        }
        return true;
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
