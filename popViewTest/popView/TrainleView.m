//
//  TrainleView.m
//  watteNN
//
//  Created by GaoYong on 15/4/20.
//  Copyright (c) 2015年 gaoyong. All rights reserved.
//

#import "TrainleView.h"

@interface TrainleView ()
{
    CAShapeLayer *triangleShapeLayer;
}

@end

@implementation TrainleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id) initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        UIBezierPath *trianglePath = [UIBezierPath bezierPath];
        [trianglePath moveToPoint:CGPointMake(0, self.bounds.size.height)];
        [trianglePath addLineToPoint:CGPointMake(self.bounds.size.width/2, 0)];
        [trianglePath addLineToPoint:CGPointMake(self.bounds.size.width,self.bounds.size.height)];

        triangleShapeLayer=[CAShapeLayer layer];
        triangleShapeLayer.fillColor=[UIColor whiteColor].CGColor;
        triangleShapeLayer.path = trianglePath.CGPath;
        [self.layer addSublayer:triangleShapeLayer];
    }
    
    return self;
}


- (void) layoutSubviews{
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(0, self.bounds.size.height)];
    [trianglePath addLineToPoint:CGPointMake(self.bounds.size.width/2, 0)];
    [trianglePath addLineToPoint:CGPointMake(self.bounds.size.width,self.bounds.size.height)];
    
    triangleShapeLayer.path = trianglePath.CGPath;
}
@end
