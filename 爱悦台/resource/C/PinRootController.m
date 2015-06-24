//
//  PinRootController.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PinRootController.h"
#import "SearchViewController.h"
#import "SliderViewController.h"
@interface RootViewController ()

@end

@implementation PinRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customUpView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ==定制左侧菜单按钮和右侧搜索按钮
-(void)customUpView{
    
    UIView *view = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];

    view.backgroundColor = [UIColor colorWithRed:24/255.0 green:80/255.0 blue:120/255.0 alpha:1.000];
    self.UpView = view;
        [self.view addSubview:self.UpView];
    //label
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(view.bounds.size.width/2-20, 24, 40, 40);
    
//    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.label = label;
    [view addSubview:self.label];
    
    
    //左侧按钮
    UIButton *button= [[UIButton alloc] initWithFrame:CGRectMake(10, 24, 40, 40)];
    [button setImage:[UIImage imageNamed:@"nav_left"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"nav_left_sel"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(showList:) forControlEvents:UIControlEventTouchUpInside];
    [self.UpView addSubview:button];
    //右侧按钮
    UIButton *rightbnt= [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 24, 40, 40)];
    [rightbnt setImage:[UIImage imageNamed:@"Search"] forState:UIControlStateNormal];
    [rightbnt setImage:[UIImage imageNamed:@"Search_Sel"] forState:UIControlStateHighlighted];
    [rightbnt addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [self.UpView addSubview:rightbnt];
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