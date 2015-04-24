//
//  ShowViewController.h
//  popViewTest
//
//  Created by GaoYong on 15/4/22.
//  Copyright (c) 2015年 GaoYong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPopoverViewDelegate.h"

@interface ShowViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,assign) id<DDPopoverViewDelegate> delegate;

@end
