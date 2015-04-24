//
//  testView.h
//  watteNN
//
//  Created by GaoYong on 15/4/18.
//  Copyright (c) 2015年 gaoyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPopoverViewDelegate.h"

typedef void(^closeBlock)(id data);

@interface DDPopoverView : UIView<UIScrollViewDelegate,DDPopoverViewDelegate>

@property (nonatomic) BOOL isPop;                        //是否弹起
@property (nonatomic,readonly) UIView *traileView;        //三角形
@property (nonatomic,readonly) UIView *contentView;        //内容
@property (nonatomic,readonly) UINavigationController *rootNavigationController; //UINavigationController，公布出来，可以自定转场动画
@property (nonatomic,assign) CGFloat maxDropDownHeight;     //最大下拉高度 ,default:100
@property (nonatomic,assign) CGFloat maxDragConnectHeight;  //三角形和上部分连在一起的最大高度 default:50

-(id) initWithFrame:(CGRect)frame bgCornerRadius:(CGFloat) bgCornerRadius_ triangleOffSet:(CGFloat) triangleOffSet triangleWidth:(CGFloat) triangleWidth invokeCloseBlock:(closeBlock) closeBlcok;

-(void) setVCInNavigationController:(UIViewController *) showVC contentInSet:(CGFloat) inSet;

-(void) pop;

-(void) close;

@end
