//
//  UICreateShowViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UICreateShowViewController: UIBaseViewController ,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZLPhotoPickerViewControllerDelegate{

    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var buttonItem1: UIButton!
    @IBOutlet weak var buttonItem2: UIButton!
    @IBOutlet weak var buttonItem3: UIButton!
    @IBOutlet weak var buttonItem4: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var tipLabel: UILabel!
    
    var imageArray:NSMutableArray = NSMutableArray();
    var imageIndex = 0;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "发布话题"
        
        contentTextView.layer.cornerRadius = 4;
        contentTextView.layer.borderColor = SGrayBorderColor.CGColor;
        contentTextView.layer.borderWidth = 0.5;
        contentTextView.layer.masksToBounds = true;
        
        contentTextView.delegate = self;
        if iphone4 {
            contentTextView.returnKeyType = UIReturnKeyType.Done;
        }
        
        createBtn.makeBackGroundColor_Red();
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    @IBAction func imageBtnFunction(sender: UIButton) {
        self.imageIndex = sender.tag-1000;
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
            let btn = self.view.viewWithTag(self.imageIndex+1000) as! UIButton;
            if btn.selected {
                self.imageArray.removeObjectAtIndex(self.imageIndex);
                for var i = 0 ; i<4 ; i++ {
                    let btn = self.view.viewWithTag(i+1000) as! UIButton;
                    if i<self.imageArray.count {
                        btn.hidden = false;
                        btn.selected = true;
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
                        btn.selected = false;
                        btn.setBackgroundImage(UIImage(named: "加"), forState: UIControlState.Normal)
                    } else {
                        btn.selected = false;
                        btn.hidden = true
                    }
                    
                }
            } else {
                self.openLocalPhoto()
            }
        } else if buttonIndex == 2 {
            self.openCamera()
        }
    }
    
    func openLocalPhoto(){
        let pickerVC = ZLPhotoPickerViewController()
        pickerVC.status = PickerViewShowStatus.CameraRoll;
        pickerVC.selectPickers = self.imageArray as [AnyObject];
        pickerVC.maxCount = 4;
        pickerVC.delegate = self;
        pickerVC.showPickerVc(self);
    }
    func pickerViewControllerDoneAsstes(assets: [AnyObject]!) {
        self.imageArray = NSMutableArray(array: assets);
        for var i = 0 ; i<4 ; i++ {
            let btn = self.view.viewWithTag(i+1000) as! UIButton;
            if i<self.imageArray.count {
                btn.hidden = false;
                btn.selected = true;
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
                btn.selected = false;
                btn.setBackgroundImage(UIImage(named: "加"), forState: UIControlState.Normal)
            } else {
                btn.selected = false;
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
            btn.selected = true;
            if self.imageArray.count<self.imageIndex+1{
                self.imageArray.addObject(image);
                if self.imageIndex<3{
                    let btn = self.view.viewWithTag(self.imageIndex+1001) as! UIButton;
                    btn.hidden = false;
                    btn.selected = false;
                }
            } else {
                self.imageArray.replaceObjectAtIndex(self.imageIndex, withObject: image);
            }
        })
    }
    
    
    @IBAction func sendFunction(sender: UIButton) {
        if contentTextView.text == "" {
            NSHelper.showAlertViewWithTip("请输入话题内容")
            return;
        }
        if self.imageArray.count>0 {
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
            self.uploadImageworks(images);
        } else {
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
            self.createTalk("")
        }
    }
    
    func createTalk(images:String){
        let dicParam:NSDictionary = NSDictionary(objects: [self.contentTextView.text!,images,NSUserInfo.shareInstance().member_id] , forKeys: ["info","images",MEMBER_ID]);
        NSLog("发话题:\(dicParam)")
        NSHttpHelp.httpHelpWithUrlTpye(addTalkType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
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
                self.createTalk(datas);
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
    
    
    
    func textViewDidChange(textView: UITextView) {
        if textView.text == "" {
            tipLabel.hidden = false;
        } else {
            tipLabel.hidden = true;
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
