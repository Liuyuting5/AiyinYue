//
//  RootViewController.m
//  爱悦台
//
//  Created by qianfeng on 15/6/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RootViewController.h"
#import "SearchViewController.h"
#import "SliderViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ==定制左侧菜单按钮和右侧搜索按钮
-(void)customButton{
    //左侧按钮
    UIButton *button= [[UIButton alloc] initWithFrame:CGRectMake(10, 24, 40, 40)];
    [button setImage:[UIImage imageNamed:@"nav_left"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"nav_left_sel"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(showList:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:button] ;
    self.navigationItem.leftBarButtonItem = leftButton;
    //右侧按钮
    UIButton *rightbnt= [[UIButton alloc] initWithFrame:CGRectMake(10, 24, 40, 40)];
    [rightbnt setImage:[UIImage imageNamed:@"Search"] forState:UIControlStateNormal];
    [rightbnt setImage:[UIImage imageNamed:@"Search_Sel"] forState:UIControlStateHighlighted];
    [rightbnt addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightbnt] ;
    self.navigationItem.rightBarButtonItem = rightButton;
}
#pragma mark-点击左侧按钮触发的事件
-(void)showList:(UIButton*)sender{
    
    
    
    SliderViewController *sliderVC = [SliderViewController sharedSliderController];
    [sliderVC showLeftViewController];


}
#pragma mark-点击右侧搜索按钮触发的事件
-(void)search:(UIButton*)sender{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    
    [self presentViewController:searchVC animated:YES completion:nil];
}
@end
