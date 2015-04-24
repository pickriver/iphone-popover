//
//  RectContentView.m
//  watteNN
//
//  Created by GaoYong on 15/4/20.
//  Copyright (c) 2015年 gaoyong. All rights reserved.
//

#import "RectContentView.h"

@implementation RectContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id) initWithFrame:(CGRect)frame bgCornerRadius:(CGFloat) bgCornerRadius triangleWidth:(CGFloat) triangleWidth triangleOffSet:(CGFloat) triangleOffSet
{
    if (self = [super initWithFrame:frame])
    {
//        CGFloat triangleHeight = sqrt(triangleWidth * triangleWidth - (triangleWidth/2) *(triangleWidth/2));
        
        self.backgroundColor = [UIColor clearColor];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        CGPoint startPoint = CGPointMake(bgCornerRadius, 0);
        [path moveToPoint:startPoint];
        
        CGPoint controlPoint = CGPointMake(self.bounds.size.width, 0);
        
        [path addLineToPoint:CGPointMake(controlPoint.x - bgCornerRadius, controlPoint.y)];
        [path addQuadCurveToPoint:CGPointMake(controlPoint.x, controlPoint.y + bgCornerRadius) controlPoint:controlPoint];
        
        controlPoint = CGPointMake(self.bounds.size.width, self.bounds.size.height);
        [path addLineToPoint:CGPointMake(controlPoint.x, controlPoint.y - bgCornerRadius)];
        [path addQuadCurveToPoint:CGPointMake(controlPoint.x - bgCornerRadius, controlPoint.y) controlPoint:controlPoint];
        
        controlPoint = CGPointMake(0, self.bounds.size.height);
        [path addLineToPoint:CGPointMake(controlPoint.x + bgCornerRadius, controlPoint.y)];
        [path addQuadCurveToPoint:CGPointMake(controlPoint.x, controlPoint.y - bgCornerRadius) controlPoint:controlPoint];
        
        controlPoint = CGPointMake(0, 0);
        [path addLineToPoint:CGPointMake(controlPoint.x, controlPoint.y + bgCornerRadius)];
        [path addQuadCurveToPoint:CGPointMake(controlPoint.x +bgCornerRadius, controlPoint.y) controlPoint:controlPoint];
        
        [path closePath];
        
        
        CAShapeLayer *shapeLayer=[CAShapeLayer layer];
        shapeLayer.fillColor=[UIColor whiteColor].CGColor;
        //        shapeLayer.strokeColor = [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1].CGColor;
        shapeLayer.path = path.CGPath;
        [self.layer addSublayer:shapeLayer];
    }
    
    return self;
}

@end
