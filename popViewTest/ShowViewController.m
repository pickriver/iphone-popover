//
//  ShowViewController.m
//  popViewTest
//
//  Created by GaoYong on 15/4/22.
//  Copyright (c) 2015年 GaoYong. All rights reserved.
//

#import "ShowViewController.h"
#import "SecViewController.h"

@interface ShowViewController ()
{
    NSArray *dataArr;
    UITableView *contentView;
    BOOL isTop;
}
@end

@implementation ShowViewController

-(void) dealloc
{
    [dataArr release];
    self.delegate = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
    dataArr = [NSArray arrayWithObjects:@"noditdy",@"jerry",@"noditdy",@"noditdy",@"noditdy",
               @"noditdy",@"noditdy",@"noditdy",@"noditdy",@"noditdy" ,@"noditdy" ,@"noditdy" ,@"noditdy" , @"noditdy", @"noditdy",@"noditdy",@"noditdy",@"noditdy",@"noditdy", nil];
    [dataArr retain];
    
    contentView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    contentView.delegate = self;
    contentView.dataSource = self;
    contentView.scrollEnabled = YES;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    contentView.showsVerticalScrollIndicator = NO;
    //    contentView.panGestureRecognizer.delegate = self;
    //    contentView.bounces = NO;
    [self.view addSubview:contentView];
    
    //    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn1.frame = CGRectMake(50 ,20 ,100, 45);
    //    btn1.titleLabel.textAlignment = NSTextAlignmentLeft;
    //    btn1.backgroundColor = [UIColor yellowColor];
    //    btn1.layer.borderWidth = 0.5;
    //    btn1.layer.borderColor =[UIColor blueColor].CGColor;
    //    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    //    [btn1 setTitle:@"click" forState:UIControlStateNormal];
    //    [btn1 addTarget:self action:@selector(openClick) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:btn1];
    
    
}

-(void) openClick
{
    SecViewController *vc = [SecViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    //回传外层控件
    if ([_delegate respondsToSelector:@selector(affectDidScrollView:)]) {
        [_delegate affectDidScrollView:scrollView];
    }
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identfider = @"temCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfider];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfider];
    }
    
    cell.textLabel.text = [dataArr objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    else
        cell.contentView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SecViewController *vc = [SecViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
