//
//  UICreateExcViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UICreateExcViewController: UIBaseViewController ,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZLPhotoPickerViewControllerDelegate{
    @IBOutlet weak var addImageBtn: UIButton!
    @IBOutlet weak var addImageBtn1: UIButton!
    @IBOutlet weak var addImageBtn2: UIButton!

    @IBOutlet weak var backView1: UIView!
    @IBOutlet weak var wupinField: UITextField!
    
    @IBOutlet weak var backView2: UIView!
    
    @IBOutlet weak var ewupinField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var fabuBtn: UIButton!
    @IBOutlet weak var contentText: UITextView!
    var imageArray:NSMutableArray!=NSMutableArray();
    var imageIndex = 0;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "发布置换"
        self.setUI();
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
    }
    func setUI(){
        backView1.layer.cornerRadius = 4;
        backView1.layer.masksToBounds = true;
        backView1.layer.borderWidth = 0.5;
        backView1.layer.borderColor = SGrayBorderColor.CGColor;
        
        backView2.layer.cornerRadius = 4;
        backView2.layer.masksToBounds = true;
        backView2.layer.borderWidth = 0.5;
        backView2.layer.borderColor = SGrayBorderColor.CGColor;
        
        contentText.layer.cornerRadius = 4;
        contentText.layer.masksToBounds = true;
        contentText.layer.borderWidth = 0.5;
        contentText.layer.borderColor = SGrayBorderColor.CGColor;
        
        fabuBtn.makeBackGroundColor_Red();
        
        contentText.delegate = self;
        wupinField.delegate = self;
        ewupinField.delegate = self;
        if iphone4 || iphone5 {
            contentText.returnKeyType = UIReturnKeyType.Done;
        }
        
    }
    
    
    @IBAction func fabuExchange(sender: UIButton) {
        if wupinField.text == "" {
            NSHelper.showAlertViewWithTip("请输入物品名称")
            return;
        }
        if ewupinField.text == "" {
            NSHelper.showAlertViewWithTip("请输入想要置换的物品名称")
            return;
        }
        if contentText.text == "" {
            NSHelper.showAlertViewWithTip("请输入物品描述")
            return;
        }
        if self.imageArray.count == 0 {
            NSHelper.showAlertViewWithTip("请至少选择一张图片")
            return;
        }
        
        let images:NSMutableArray = NSMutableArray()
        for var i = 0 ; i < self.imageArray.count ; i++ {
            let asset = self.imageArray[i];
            if asset.isKindOfClass(ZLPhotoAssets) {
                let  imageData:NSData = NSHelper.fileOfPressedImage((asset as! ZLPhotoAssets).originImage() ,withType: squareType);
                images.addObject(imageData)
            } else if asset.isKindOfClass(NSString) {
                
            } else if asset.isKindOfClass(UIImage) {
                let  imageData:NSData = NSHelper.fileOfPressedImage(asset as! UIImage ,withType: squareType);
                images.addObject(imageData)
            }
        }
        self.uploadImageworks(images)
    }
    
    func createExchange(images:String){
        let dicParam:NSDictionary = NSDictionary(objects: [self.wupinField.text!,self.ewupinField.text!,self.contentText.text,images,NSUserInfo.shareInstance().member_id] , forKeys: ["from_gname","to_gname","info","images",MEMBER_ID]);
        NSLog("发话题:\(dicParam)")
        NSHttpHelp.httpHelpWithUrlTpye(addExchangeType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                SVProgressHUD.showSuccessWithStatus("发布成功")
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
                self.createExchange(datas);
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

    
    @IBAction func addImage(sender: UIButton) {
        self.imageIndex = sender.tag-1000;
        wupinField.resignFirstResponder();
        ewupinField.resignFirstResponder();
        contentText.resignFirstResponder();
        let actionSheet:UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "相册", "相机")
        actionSheet.showInView(self.view);
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            self.openLocalPhoto()
        } else if buttonIndex == 2 {
            self.openCamera()
        }
    }
    
    func openLocalPhoto(){
        let pickerVC = ZLPhotoPickerViewController()
        pickerVC.status = PickerViewShowStatus.CameraRoll;
        pickerVC.selectPickers = self.imageArray as [AnyObject];
        pickerVC.maxCount = 3;
        pickerVC.delegate = self;
        pickerVC.showPickerVc(self);
    }
    func pickerViewControllerDoneAsstes(assets: [AnyObject]!) {
        self.imageArray = NSMutableArray(array: assets);
        for var i = 0 ; i<3 ; i++ {
            let btn = self.view.viewWithTag(i+1000) as! UIButton;
            if i<self.imageArray.count {
                btn.hidden = false;
                let asset = self.imageArray[i];
                if asset.isKindOfClass(ZLPhotoAssets) {
                    btn.setBackgroundImage((asset as! ZLPhotoAssets).thumbImage(), forState: UIControlState.Normal);
                } else if asset.isKindOfClass(NSString) {
                    btn.sd_setBackgroundImageWithURL(NSURL(string: (asset as! String)), forState: UIControlState.Normal);
                } else if asset.isKindOfClass(UIImage) {
                    btn.setBackgroundImage(asset as? UIImage, forState: UIControlState.Normal);
                }
                
            } else  if i == self.imageArray.count{
                btn.hidden = false;
                btn.setBackgroundImage(UIImage(named: "加"), forState: UIControlState.Normal)
            } else {
                btn.hidden = true
            }
            
        }
    }
    
    func openCamera(){
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            
            let  dic:NSDictionary = info as NSDictionary;
            let  image:UIImage = dic.objectForKey(UIImagePickerControllerEditedImage) as! UIImage;
            let btn = self.view.viewWithTag(self.imageIndex+1000) as! UIButton;
            btn.setBackgroundImage(image, forState: UIControlState.Normal);
            if self.imageArray.count<self.imageIndex+1{
                self.imageArray.addObject(image);
                if self.imageIndex<3{
                    let btn = self.view.viewWithTag(self.imageIndex+1001) as! UIButton;
                    btn.hidden = false;
                }
            } else {
                self.imageArray.replaceObjectAtIndex(self.imageIndex, withObject: image);
            }
        })
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if iphone4 || iphone5{
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                var frame = self.view.frame;
                frame.origin.y = frame.origin.y-100;
                self.view.frame = frame;
                }, completion: { (finish:Bool) -> Void in
                    
            })
        }
    }
    func textViewDidEndEditing(textView: UITextView) {
        if iphone4 || iphone5{
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                var frame = self.view.frame;
                frame.origin.y = 64;
                self.view.frame = frame;
                }, completion: { (finish:Bool) -> Void in
                    
            })
        }
    }
    func textViewDidChange(textView: UITextView) {
        if textView.text == "" {
            tipLabel.hidden = false;
        } else {
            tipLabel.hidden = true;
        }
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if iphone4 || iphone5{
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
