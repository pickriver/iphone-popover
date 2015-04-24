//
//  testView.m
//  watteNN
//
//  Created by GaoYong on 15/4/18.
//  Copyright (c) 2015年 gaoyong. All rights reserved.
//

#import "DDPopoverView.h"
#import "TrainleView.h"
#import "RectContentView.h"
#import "ShowViewController.h"
#import "DDPanGesRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface DDPopoverView ()<UIGestureRecognizerDelegate>
{
    CGFloat triangleHeight;    //三角形的高
    CGRect basicSelfViewRect;  //self的初始位置，用于做动画
    DDPanGesRecognizer *panGes;
    CGFloat bgCornerRadius;
}

@property (nonatomic,copy) closeBlock invokeCloseBlock;  //回调
@property (nonatomic,retain) UIScrollView *innerScrollView;

@end

@implementation DDPopoverView

-(void) dealloc
{
    self.invokeCloseBlock = nil;
    panGes.delegate = nil;
    
    [_rootNavigationController release];
    _rootNavigationController = nil;
    
    self.innerScrollView.delegate = nil;
    self.innerScrollView = nil;
    
    [super dealloc];
}

/*
 frame:控件展开的大小，包含小三角
 bgCornerRadius：背景矩形顶点的弧度
 triangleOffSet：小三角左顶点开始的位移
 triangleWidth：小三角的边长
 invokeCloseBlock：关闭弹出框的回调
 */
-(id) initWithFrame:(CGRect)frame bgCornerRadius:(CGFloat) bgCornerRadius_ triangleOffSet:(CGFloat) triangleOffSet triangleWidth:(CGFloat) triangleWidth invokeCloseBlock:(closeBlock) closeBlcok
{
    if (self = [super initWithFrame:frame])
    {
        triangleHeight = sqrt(triangleWidth * triangleWidth - (triangleWidth/2) *(triangleWidth/2));
        bgCornerRadius = bgCornerRadius_;
        
        _traileView = [[TrainleView alloc] initWithFrame:CGRectMake(triangleOffSet, 0, triangleWidth, triangleHeight)];
        [self addSubview:_traileView];
        [_traileView release];
        
        _contentView = [[[RectContentView alloc] initWithFrame:CGRectMake(frame.origin.x, CGRectGetMaxY(_traileView.frame), frame.size.width - frame.origin.x * 2, frame.size.height - _traileView.bounds.size.height) bgCornerRadius:bgCornerRadius triangleWidth:triangleWidth triangleOffSet:triangleOffSet] autorelease];
        [self addSubview:_contentView];
        [_contentView release];
        
        panGes = [[DDPanGesRecognizer alloc] initWithTarget:self action:@selector(HandlePaningGesture:)];
        panGes.delegate = self;
        [self.contentView addGestureRecognizer:panGes];
        [panGes release];
        
        basicSelfViewRect = self.frame;
        self.invokeCloseBlock = closeBlcok;
        
        self.maxDragConnectHeight = 50;
        self.maxDropDownHeight = 100;
        self.layer.anchorPoint = CGPointMake((triangleOffSet + triangleWidth/2)/self.bounds.size.width, 0);
        self.frame = basicSelfViewRect;
        self.alpha = 0;
        self.clipsToBounds = NO;
    }
    
    return self;
}

//以ViewController.view显示 此时会创建一个UINavigationController showVC引用计数会增加1
-(void) setVCInNavigationController:(UIViewController *) showVC contentInSet:(CGFloat) inSet
{
    if (_rootNavigationController)
    {
        [_rootNavigationController release];
        _rootNavigationController = nil;
    }
    
    _rootNavigationController = [[UINavigationController alloc] initWithRootViewController:showVC];
    _rootNavigationController.navigationBarHidden = YES;
    _rootNavigationController.view.frame = CGRectMake(inSet, inSet, _contentView.bounds.size.width - 2 * inSet, _contentView.bounds.size.height - 2 * inSet);
    [_contentView addSubview:self.rootNavigationController.view];
    
    for (UIView *temUv in showVC.view.subviews) {
        if ([temUv isKindOfClass:[UIScrollView class]]) {
            self.innerScrollView = (UIScrollView *)temUv;
            break;
        }
    }
}

-(void) affectDidScrollView:(UIScrollView *)scrollView
{
    static CGFloat lastPointY = 0.0;
    if (scrollView.contentOffset.y < 0)
    {
        panGes.enabled = YES;
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
    }
    else
    {
        if (self.frame.origin.y > basicSelfViewRect.origin.y)
        {
            [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, lastPointY)];
        }
    }
    
    lastPointY = scrollView.contentOffset.y;
}

#pragma mark -- UIGestureRecognizerDelegate

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)HandlePaningGesture:(UIPanGestureRecognizer *)recognizer
{
    if(self.innerScrollView.contentOffset.y > 0)
    {
        return;
    }
    
    CGPoint touchPoint = [recognizer locationInView:self.superview];
    
    static CGFloat orignalY = 0.0;
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        orignalY = touchPoint.y;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGFloat amountValue = touchPoint.y - orignalY;
        
        orignalY = touchPoint.y;
        
        //        NSLog(@"amountValue:%f",amountValue);
        
        CGFloat newY = self.frame.origin.y + amountValue;
        
        if (newY <= basicSelfViewRect.origin.y) {
            newY = basicSelfViewRect.origin.y;

            self.innerScrollView.panGestureRecognizer.enabled = YES;
        }
        
        if (newY >= basicSelfViewRect.origin.y + self.maxDropDownHeight) {
            newY = basicSelfViewRect.origin.y + self.maxDropDownHeight;
        }
        
        self.frame = CGRectMake(self.frame.origin.x, newY, self.bounds.size.width, self.bounds.size.height);
        
        //断开
        if (newY > basicSelfViewRect.origin.y + self.maxDragConnectHeight)
        {
            _traileView.frame = CGRectMake(_traileView.frame.origin.x, 0, _traileView.frame.size.width, triangleHeight);
        }
        //连在一起
        else
        {
            CGFloat offsetHeight = self.frame.origin.y - basicSelfViewRect.origin.y;
            _traileView.frame = CGRectMake(_traileView.frame.origin.x, -offsetHeight, _traileView.frame.size.width, triangleHeight + offsetHeight);
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        _traileView.frame = CGRectMake(_traileView.frame.origin.x, 0, _traileView.frame.size.width, triangleHeight);
        
        //拉回原来位置
        if (self.frame.origin.y < basicSelfViewRect.origin.y + self.maxDragConnectHeight)
        {
            [UIView animateWithDuration:0.1 animations:^{
                self.frame = basicSelfViewRect;
            }completion:^(BOOL finished) {
                self.innerScrollView.panGestureRecognizer.enabled = YES;
            }];
        }
        else
        {
            //收起
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.alpha = 0;
                self.frame = basicSelfViewRect;
                self.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:^(BOOL finished) {
                self.isPop = NO;
            }];
        }
    }
}

//弹起
-(void) pop
{
    [self.superview bringSubviewToFront:self];
    
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    [UIView animateWithDuration:0.2 delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.alpha = 1;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.transform = CGAffineTransformIdentity;
            self.isPop = YES;
        }];
    }];
}

//关闭
-(void) close
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.isPop = NO;
    }];
}

@end
