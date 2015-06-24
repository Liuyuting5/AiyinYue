//
//  TabBarController.m
//  爱悦台
//
//  Created by qianfeng on 15/6/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TabBarController.h"
#import "officeViewController.h"
#import "LiveViewController.h"
#import "HotViewController.h"
#import "PopViewController.h"
#import "RDVTabBarItem.h"
#import "RDVTabBar.h"
#import "favoriteViewController.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:24/255.0 green:80/255.0 blue:120/255.0 alpha:1.000]];
    OfficeViewController*officeVC = [[OfficeViewController alloc] init];
    officeVC.navigationItem.title = @"首页";
    
    UINavigationController *officeNAV = [[UINavigationController alloc] initWithRootViewController:officeVC];
    //officeVC.navigationController.navigationBar.backgroundColor=[UIColor redColor];
    LiveViewController *liveVC = [[LiveViewController alloc]init];
    liveVC.navigationItem.title = @"首页";
    
    UINavigationController *liveNAV = [[UINavigationController alloc] initWithRootViewController:liveVC];
    
    HotViewController *hotVC = [[HotViewController alloc]init];
    hotVC.navigationItem.title = @"首页";
    UINavigationController *hotNAV = [[UINavigationController alloc] initWithRootViewController:hotVC];
    PopViewController *popVC = [[PopViewController alloc]init];
    popVC.navigationItem.title = @"首页";
    UINavigationController *popNAV = [[UINavigationController alloc] initWithRootViewController:popVC];
    
    favoriteViewController *favoiteVC = [[favoriteViewController alloc]init];
    favoiteVC.navigationItem.title = @"首页";
    UINavigationController *favoriteNAV = [[UINavigationController alloc] initWithRootViewController:favoiteVC];
    [self setViewControllers:@[officeNAV,liveNAV,hotNAV,popNAV,favoriteNAV]];
    [self customizeTabBarForController:self];
}

- (void)customizeTabBarForController:(RDVTabBarController*)rdvVC{
    
    
//    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
//    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
//    
    //NSArray *titles = @[@"官方推荐",@"MV首播",@"今日热播",@"正在流行",@"猜你喜欢"];
    NSArray *imagearray = @[@"tabbar_Official",@"tabbar_mv",@"tabbar_hot",@"tabbar_pop",@"tabbar_favorite"];
    NSArray *array = @[@"tabbar_Official_press",@"tabbar_mv_press",@"tabbar_hot_press",@"tabbar_pop_press",@"tabbar_favorite_press"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[rdvVC tabBar] items]) {
        
                UIImage *selectedimage = [UIImage imageNamed:array[index]];
        UIImage *unselectedimage = [UIImage imageNamed:imagearray[index]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        
        index++;
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
