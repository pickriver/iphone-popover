//
//  ViewController.m
//  popViewTest
//
//  Created by GaoYong on 15/4/20.
//  Copyright (c) 2015年 GaoYong. All rights reserved.
//

#import "ViewController.h"
#import "DDPopoverView.h"
#import "ShowViewController.h"

@interface ViewController ()
{
    UIButton *btn1;
    DDPopoverView *popView;
}
@end

@implementation ViewController

-(void) dealloc
{
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(self.view.bounds.size.width - 110 ,20 ,100, 45);
    btn1.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn1.backgroundColor = [UIColor greenColor];
    btn1.layer.borderWidth = 0.5;
    btn1.layer.borderColor =[UIColor blueColor].CGColor;
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn1 setTitle:@"click" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(openClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    popView = [[DDPopoverView alloc] initWithFrame:CGRectMake(0, 68, self.view.bounds.size.width, self.view.bounds.size.height - 68) bgCornerRadius:10 triangleOffSet:self.view.bounds.size.width - 60 triangleWidth:15 invokeCloseBlock:nil];
    popView.maxDropDownHeight = 500;
    [self.view addSubview:popView];
    [popView release];
    
    //1.单层 没有navigation 栈
//    [self setPopViewContentView];
    
    //2.嵌入vc的navigation 栈
    ShowViewController *showVC = [[ShowViewController alloc] init];
    [popView setVCInNavigationController:showVC contentInSet:5];
    showVC.delegate = popView;
    [showVC release];
    
    
}

-(void) setPopViewContentView
{
    UIView *greenView = [UIView new];
    greenView.frame = CGRectMake(10, 20, 200, 100);
    greenView.backgroundColor = [UIColor greenColor];
    [popView.contentView addSubview:greenView];
    [greenView release];
}

-(void) openClick
{
    if (popView.isPop)
    {
        [popView close];
    }
    else
    {
        [popView pop];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
