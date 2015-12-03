//
//  YFInputBar.m
//  test
//
//  Created by 杨峰 on 13-11-10.
//  Copyright (c) 2013年 杨峰. All rights reserved.
//

#import "YFInputBar.h"
//#import "AppDelegate.h"


@interface YFInputBar ()

//@property(nonatomic,strong) UIBaseViewController *currentVC;

@end

@implementation YFInputBar


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.frame = CGRectMake(0, CGRectGetMinY(frame), CGRectGetMinY(frame), CGRectGetHeight(frame));
        self.shouldShow =YES;
        self.textField.tag = 10000;
        self.sendBtn.tag = 10001;
        UIView  *view = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0.5)];
        view.backgroundColor = RGBCOLOR(0Xc0c0ce);
        [self addSubview:view];
        
        //注册键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _originalFrame = frame;
}
//_originalFrame的set方法  因为会调用setFrame  所以就不在此做赋值；
-(void)setOriginalFrame:(CGRect)originalFrame
{
    self.frame = CGRectMake(0, CGRectGetMinY(originalFrame), MainScreenWidth, CGRectGetHeight(originalFrame));
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark get方法实例化输入框／btn
-(UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, MainScreenWidth-90, self.bounds.size.height)];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14.5];
        _textField.textColor = RGBCOLOR(0x696975);
        _textField.placeholder = @"输入评论";
        [self addSubview:_textField];
    }
    return _textField;
}
-(UIButton *)sendBtn
{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setBackgroundColor:PurpleBtnColor];
         _sendBtn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:14];
        
        [_sendBtn setFrame:CGRectMake(MainScreenWidth-80, 5, 70, self.bounds.size.height-10)];
        _sendBtn.layer.cornerRadius = 5;
        [_sendBtn addTarget:self action:@selector(sendBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendBtn];
    }
    return _sendBtn;
}
#pragma mark selfDelegate method

-(void)sendBtnPress:(UIButton*)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(inputBar:sendBtnPress:withInputString:)]) {
        [self.delegate inputBar:self sendBtnPress:sender withInputString:self.textField.text];
    }
    if (self.clearInputWhenSend) {
        self.textField.text = @"";
    }
    if (self.resignFirstResponderWhenSend) {
        [self resignFirstResponder];
    }
    [self hideInputView];
}

#pragma mark keyboardNotification

- (void)keyboardWillShow:(NSNotification*)notification{
    if (self.shouldShow) {
        CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        //如果self在键盘之下 才做偏移
        if ([self convertYToWindow:CGRectGetMaxY(self.originalFrame)]>=_keyboardRect.origin.y)
        {
            //没有偏移 就说明键盘没出来，使用动画
            if (self.frame.origin.y== self.originalFrame.origin.y) {
                [UIView animateWithDuration:0.3
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     float height = self.showNavigationBar?64:0;
                                     self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame)-CGRectGetHeight(self.originalFrame)-18+height);
//                                     self.frame = CGRectMake(0, MainScreenHeight-_keyboardRect.size.height-45, MainScreenWidth, 45);
                                     self.isShow = true;
                                 } completion:nil];
            }
            else
            {
                float height = self.showNavigationBar?64:0;
                self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame) - CGRectGetHeight(self.originalFrame) -18+height);
            }
            
        }
    }
}

- (void)keyboardWillHide:(NSNotification*)notification{
    if (self.shouldShow) {
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.transform = CGAffineTransformMakeTranslation(0, 0);
                             self.isShow = false;
                         } completion:nil];
    }
}
#pragma  mark ConvertPoint
//将坐标点y 在window和superview转化  方便和键盘的坐标比对
-(float)convertYFromWindow:(float)Y
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint o = [appDelegate.window convertPoint:CGPointMake(0, Y) toView:self.superview];
    return o.y;
    
}
-(float)convertYToWindow:(float)Y
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint o = [self.superview convertPoint:CGPointMake(0, Y) toView:appDelegate.window];
    return o.y;
    
}
-(float)getHeighOfWindow
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return appDelegate.window.frame.size.height;
}

-(BOOL)resignFirstResponder
{
    [self.textField resignFirstResponder];
    return [super resignFirstResponder];
}


-(void)showInputViewWith:(UIViewController*)vc
{
//    _currentVC =(UIBaseViewController*) vc;
    [vc.view addSubview:self];
    [UIView animateWithDuration:0.45 animations:^{
      
      self.frame = CGRectMake(0,MainScreenHeight-45, MainScreenWidth, 45);
        
    }];
}
-(void)hideInputView
{
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        self.frame = CGRectMake(0,MainScreenHeight, MainScreenWidth, 45);
//        
//    }];
    
     [self resignFirstResponder];
}

@end
