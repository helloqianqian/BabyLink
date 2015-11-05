//
//  FindListHeadView.swift
//  LeDoingHome
//  Created by JDragon on 15/9/25.
//  Copyright (c) 2015年 黄倩. All rights reserved.
//


protocol  didClickImgDelegate:NSObjectProtocol
    
{
    
    func  didClickImgAction(adModel:ADModel);
    
}

import UIKit


class FindListHeadView: UIView,TAPageControlDelegate,UIScrollViewDelegate {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    var  delegate:didClickImgDelegate!;
    
    @IBOutlet  var aScrollView: UIScrollView!
    //    var roundImgView: UIImageView!
    var leftImageView:UIImageView!;
    var centerImageView:UIImageView!;
    var rightImageView:UIImageView!;
    @IBOutlet var aPageView: TAPageControl!
    var  imgArr:NSArray!;
    var  timer:NSTimer!;
    var  scrollHeight:CGFloat!;
    var  scrollWidth:CGFloat!;
    var  currentImageIndex:Int!;
    
    
    var  tapGesture:UITapGestureRecognizer!;
    var  moveTime:NSTimer!;
    var  isTimeUp:Bool!;
    
    override func awakeFromNib() {
        
        
        scrollWidth = MainScreenWidth;
        scrollHeight = self.frame.size.height;
        aScrollView.delegate = self;
        aScrollView.pagingEnabled = true;
        leftImageView = UIImageView();
        centerImageView = UIImageView();
        rightImageView = UIImageView();
        aScrollView.showsHorizontalScrollIndicator = false;
        
        //        leftImageView = UIImageView(frame: CGRectMake(0, 0,scrollWidth ,scrollHeight ));
        //        centerImageView = UIImageView(frame: CGRectMake(scrollWidth, 0, scrollWidth, scrollHeight));
        //        rightImageView = UIImageView(frame: CGRectMake(scrollWidth*2, 0, scrollWidth, scrollHeight));
        
        aScrollView.addSubview(leftImageView);
        aScrollView.addSubview(centerImageView);
        aScrollView.addSubview(rightImageView);
        tapGesture = UITapGestureRecognizer(target: self, action: "didCenterImgCickAction:");
        centerImageView.userInteractionEnabled = true;
        centerImageView.addGestureRecognizer(tapGesture);
    }
    
    func setupPageView()
    {
        aPageView.numberOfPages = imgArr.count;
        self.aPageView.delegate = self;
        self.aPageView.dotImage = UIImage(named: "椭圆-1椭圆-1normal");
        self.aPageView.currentDotImage =  UIImage(named:"椭圆-1椭圆-1select");
        self.aPageView.currentPage = 0;
    }
    func setupSubviews(arr:NSArray)
    {
        
        self.imgArr = arr;
        scrollHeight = self.frame.size.height;
        scrollWidth = self.frame.size.width;
        
        aScrollView.contentSize = CGSizeMake(scrollWidth*3, scrollHeight);
        aScrollView.contentOffset = CGPointMake(scrollWidth, 0);
        
        leftImageView.frame =  CGRectMake(0, 0, scrollWidth, scrollHeight);
        centerImageView.frame = CGRectMake(scrollWidth, 0, scrollWidth, scrollHeight);
        rightImageView.frame =  CGRectMake(scrollWidth*2, 0, scrollWidth, scrollHeight);
        
        //隐藏滚动
        self.currentImageIndex = 0;
        self.setupPageView();
        
        if(imgArr.count>=3)
        {
            //            leftImageView.image = UIImage(named:imgArr[imgArr.count-1] as! String);
            //            centerImageView.image = UIImage(named:imgArr[0] as! String);
            //            rightImageView.image = UIImage(named:imgArr[1] as! String);
            
            var  imgStr:String = (imgArr[imgArr.count-1] as! ADModel ).media_url;
            leftImageView.sd_setImageWithURL(NSURL(string: imgStr));
            
            imgStr = (imgArr[0] as! ADModel ).media_url;
            centerImageView.sd_setImageWithURL(NSURL(string: imgStr));
            
            imgStr = (imgArr[1] as! ADModel ).media_url;
            rightImageView.sd_setImageWithURL(NSURL(string: imgStr));
            
        }
        else
            //        if(imgArr.count==2)
            //        {
            //            leftImageView.image = UIImage(named:imgArr[imgArr.count-1] as! String);
            //            centerImageView.image = UIImage(named:imgArr[0] as! String);
            //            rightImageView.image = UIImage(named:imgArr[1] as! String);
            //
            //        }
            //        else
            if(imgArr.count==1)
            {
                
                //            centerImageView.image = UIImage(named:imgArr[0] as! String);
                let  imgStr:String = (imgArr[0] as! ADModel ).media_url;
                centerImageView.sd_setImageWithURL(NSURL(string: imgStr));
                
                aScrollView.scrollEnabled = false;
                aPageView.hidden = true;
        }
        
        //          self.startimer();
        
    }
    func startimer()
    {
        //
        //        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "handleSetTimeScrollView", userInfo: nil, repeats: true);
        //
        //        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes);
        
        
        moveTime =  NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "animalMoveImage", userInfo: nil, repeats: true);
        
        //        isTimeUp = false;
        //        self.animalMoveImage();
    }
    func animalMoveImage()
    {
        aScrollView.setContentOffset(CGPointMake(scrollWidth*2, 0), animated: true);
        
        isTimeUp=true;
        //        NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "scrollViewDidEndDecelerating:", userInfo: nil, repeats: false);
        
    }
    //    func removeTimer()
    //    {
    //        timer.invalidate();
    //    }
    func handleSetTimeScrollView()
    {
        //        var page = aPageView.currentPage;
        //        if (page==self.imgArr.count-1) {
        //            page=0;
        //
        //        }else{
        //            page++;
        //        }
        //        //滚动偏移
        //        var offsetX : CGFloat = CGFloat(page) * CGFloat(MainScreenWidth);
        
        //        var transation:CATransition = CATransaction ;
        //
        //        transation.type=kCATransitionFromRight;//从右侧移除
        //
        //        aScrollView.layer .addAnimation(transation, forKey: "scroll");
        
        //设置scrollview移动
        //        aScrollView.setContentOffset(CGPointMake(offsetX, 0), animated: true);
        //        //设置pagecontrol移动
        //        aPageView.currentPage = page
        
        
        self.reloadImage();
        
        //        var   offset : CGPoint   = aScrollView.contentOffset;
        //        //算出是在第几页
        //        var   pageNumber  = Int(offset.x/aScrollView.bounds.size.width);
        //        aPageView.currentPage = pageNumber;
        //        self.currentImageIndex = pageNumber;
        //        NSLog("现在移动到 %d",pageNumber);
        
        
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        self.reloadImage();
        //
        //        var   offset : CGPoint   = scrollView.contentOffset;
        //            //算出是在第几页
        //         var   pageNumber  = Int(offset.x/scrollView.bounds.size.width);
        //        aPageView.currentPage = pageNumber;
        //        self.currentImageIndex = pageNumber;
        //        NSLog("现在移动到 %d",pageNumber);
    }
    func reloadImage()
    {
        //        var  leftImageIndex:Int!;
        //        var  rightImageIndex:Int!;
        let   offset : CGPoint   = aScrollView.contentOffset;
        
        if (offset.x == 0)
        {
            currentImageIndex = (currentImageIndex-1)<0 ? imgArr.count-1 : currentImageIndex-1;
        }
        else if(offset.x == 2 * scrollWidth)
        {
            currentImageIndex = (currentImageIndex+1)>=imgArr.count ? 0 : currentImageIndex+1
            
        }else
        {
            
            return;
        }
        
        let leftAdmodel = imgArr[currentImageIndex == 0 ? imgArr.count-1 : currentImageIndex-1] as! ADModel;
        leftImageView.sd_setImageWithURL(NSURL(string: leftAdmodel.media_url));
        
        let  centerAdmodel = imgArr[currentImageIndex] as! ADModel
        centerImageView.sd_setImageWithURL(NSURL(string: centerAdmodel.media_url));
        
        let rightAdmodel = imgArr[currentImageIndex==imgArr.count-1 ? 0 : currentImageIndex+1] as! ADModel
        rightImageView.sd_setImageWithURL(NSURL(string: rightAdmodel.media_url));
        
        aPageView.currentPage = currentImageIndex;
        aScrollView.contentOffset = CGPointMake(scrollWidth, 0);
        
        //        if(isTimeUp.boolValue==false)
        //        {
        //            moveTime.fire();
        //        }
        //        isTimeUp=false;
        
    }
    //    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    //
    //         startimer()
    //
    //    }
    //    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    //        
    //        self.removeTimer();
    //
    //    }
    func TAControl(pageControl: TAPageControl!, didSelectPageAtIndex index: Int) {
        
        NSLog("现在点击的是 %d",index);
        //根据当前pageControl的页数，设置scrollView的contentOffset 显示对应的页面
        let offsetX : CGFloat = aScrollView.bounds.size.width * CGFloat(index);
        
        aScrollView.setContentOffset(CGPointMake(offsetX, 0), animated: true);
        
        
    }
    
    func didCenterImgCickAction(tap:UITapGestureRecognizer)
    {
        let  adModel = imgArr[self.currentImageIndex] as! ADModel;
        self.delegate.didClickImgAction(adModel);
        
    }
}
