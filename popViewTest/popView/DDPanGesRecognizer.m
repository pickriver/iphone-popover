//
//  DDPanGesRecognizer.m
//  popViewTest
//
//  Created by GaoYong on 15/4/23.
//  Copyright (c) 2015年 GaoYong. All rights reserved.
//

#import "DDPanGesRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface DDPanGesRecognizer ()

@property (retain, nonatomic) UIEvent *event;

@end

@implementation DDPanGesRecognizer

-(void) dealloc
{
    self.event = nil;
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.event = event;
    [super touchesBegan:touches withEvent:event];
}

@end
