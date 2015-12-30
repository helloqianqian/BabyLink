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
    
    weak var  delegate:didClickImgDelegate!;
    
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
    var  moveTime:NSTimer?;
    var  isTimeUp:Bool = true;
    
    override func awakeFromNib() {
        
        
        scrollWidth = MainScreenWidth;
        scrollHeight = self.frame.size.height;
        aScrollView.delegate = self;
        aScrollView.pagingEnabled = true;
        leftImageView = UIImageView();
        centerImageView = UIImageView();
        rightImageView = UIImageView();
        aScrollView.showsHorizontalScrollIndicator = false;
        
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
    func setupSubviews(arr:NSArray,tag :Bool)
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
        
        if(imgArr.count>=3) {
            var  imgStr:String = (imgArr[imgArr.count-1] as! ADModel ).cover;
            leftImageView.sd_setImageWithURL(NSURL(string: imgStr));
            
            imgStr = (imgArr[0] as! ADModel ).cover;
            centerImageView.sd_setImageWithURL(NSURL(string: imgStr));
            
            imgStr = (imgArr[1] as! ADModel ).cover;
            rightImageView.sd_setImageWithURL(NSURL(string: imgStr));
            if tag {
                self.startimer()
            }
        } else if(imgArr.count==2) {
                
            var   imgStr:String = (imgArr[imgArr.count-1] as! ADModel ).cover;
            leftImageView.sd_setImageWithURL(NSURL(string: imgStr));
            
            imgStr = (imgArr[0] as! ADModel ).cover;
            centerImageView.sd_setImageWithURL(NSURL(string: imgStr));
            
            imgStr = (imgArr[1] as! ADModel ).cover;
            rightImageView.sd_setImageWithURL(NSURL(string: imgStr));
            
            if tag {
                self.startimer()
            }
        } else if(imgArr.count==1) {
            let  imgStr:String = (imgArr[0] as! ADModel ).cover;
            centerImageView.sd_setImageWithURL(NSURL(string: imgStr));
            
            aScrollView.scrollEnabled = false;
            aPageView.hidden = true;
        }
        
    }
    func startimer()
    {
        if moveTime == nil {
            moveTime =  NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "animalMoveImage", userInfo: nil, repeats: true);
        }
    }
    func animalMoveImage()
    {
        if isTimeUp {
            aScrollView.setContentOffset(CGPointMake(scrollWidth*2, 0), animated: true);
        } else {
            isTimeUp = true
        }
    }
    func removeTimer()
    {
        if moveTime != nil {
            moveTime!.invalidate();
            moveTime = nil;
        }
    }
    
    
    func handleSetTimeScrollView()
    {
        self.reloadImage();
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        isTimeUp = false;
    }
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.reloadImage();
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.reloadImage();
    }
    func reloadImage()
    {
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
        leftImageView.sd_setImageWithURL(NSURL(string: leftAdmodel.cover));
        
        let  centerAdmodel = imgArr[currentImageIndex] as! ADModel
        centerImageView.sd_setImageWithURL(NSURL(string: centerAdmodel.cover));
        
        let rightAdmodel = imgArr[currentImageIndex==imgArr.count-1 ? 0 : currentImageIndex+1] as! ADModel
        rightImageView.sd_setImageWithURL(NSURL(string: rightAdmodel.cover));
        
        aPageView.currentPage = currentImageIndex;
        aScrollView.contentOffset = CGPointMake(scrollWidth, 0);
        
    }
    
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
