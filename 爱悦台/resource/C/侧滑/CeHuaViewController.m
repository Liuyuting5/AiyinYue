//
//  CeHuaViewController.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CeHuaViewController.h"
#import "MainSliderViewController.h"
#import "TabBarController.h"
#import "PinDaoViewController.h"
#import "VBangViewController.h"
#import "YueDanViewController.h"
//#import "AboutViewController.h"
//#import "DownLoadManagerViewController.h"
//left_download_back
@interface CeHuaViewController ()
{
    //头像
    UIImageView *myHeaderImageView;
    
    //存储上一个选中的按钮
    UIButton *oldBtn;
}
@property (nonatomic,strong) NSArray *imageNameArraySel;
@property (nonatomic,strong) NSArray *imageNameArrayNor;
@end

@implementation CeHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundView"]];
    //头像设置
  UIButton *artistButton = [ZCControl createButtonWithFrame:CGRectMake(40, 60, 80, 80) ImageName:@"artist_detail_image_bg" Target:self Action:@selector(artistClick) Title:nil];
    artistButton.layer.cornerRadius = 40;
    artistButton.layer.masksToBounds = YES;
    artistButton.userInteractionEnabled = YES;
    [self.view addSubview:artistButton];
    //下面左侧的登录按钮
    UIButton *messageButton = [ZCControl createButtonWithFrame:CGRectMake(10, SCREEN_HEIGHT-50, 40, 40) ImageName:@"left_massage_default" Target:self Action:@selector(messageClick) Title:nil];
    [messageButton setImage:[UIImage imageNamed:@"left_massage_selected"] forState:UIControlStateHighlighted];
    [self.view addSubview:messageButton];
    //设置按钮
    UIButton *settingutton = [[UIButton alloc] initWithFrame:CGRectMake(100, SCREEN_HEIGHT-50, 40, 40)];
    [settingutton setImage:[UIImage imageNamed:@"left_setting_default"] forState:UIControlStateNormal];
    [settingutton setImage:[UIImage imageNamed:@"left_setting_selected"] forState:UIControlStateHighlighted];
    [settingutton addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingutton];
    //对数组进行初始化
    [self initlizeArray];
    //创建选择按钮
    [self createButton];
    
}

-(void)artistClick
{
    NSLog(@"***artistHeader***");
}
-(void)messageClick
{
    NSLog(@"***message***");
}
-(void)settingClick
{
    NSLog(@"***setting***");
}

#pragma mark - alertView
-(void)createAlertView
{
    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"登陆注册功能暂未开启" message:@"需要登陆后，才能使用此功能" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)initlizeArray
{
    
    self.dataArray = [NSMutableArray arrayWithObjects:@"首页",@"频道",@"v榜",@"悦单",nil];
    self.imageNameArraySel = @[@"left_home_back",@"left_channel_back",@"left_Vlist_back",@"left_happyList_back"];
    self.imageNameArrayNor = @[@"left_home_default",@"left_channel_default",@"left_Vlist_default",@"left_happyList_default"];
}
-(void)createButton
{
    for (int i = 0; i < 4; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/4+60+i*61, SCREEN_WIDTH/2, 60)];
        button.backgroundColor = [UIColor blackColor];
        [button setImage:[UIImage imageNamed:self.imageNameArrayNor[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.imageNameArraySel[i]] forState:UIControlStateSelected];
        button.tag = 100+i;
        button.layer.cornerRadius = 10;
        button.layer.masksToBounds = YES;
        if (i == 0) {
            button.selected = YES;
            oldBtn = button;
        }
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
//    UIButton *weBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/4 + self.dataArray.count*50+90, SCREEN_WIDTH/2, 40)];
//    [weBtn setTitle:@"关于iMV" forState:UIControlStateNormal];
//    [weBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [weBtn setTitleColor:[UIColor colorWithRed:51/(CGFloat)0x100 green:112/(CGFloat)0x100 blue:90/(CGFloat)0x100 alpha:1] forState:UIControlStateSelected];
//    weBtn.backgroundColor = [UIColor blackColor];
//    weBtn.alpha = 0.8;
//    weBtn.alpha = 1;
//    weBtn.tag = 100+4;
//    weBtn.layer.cornerRadius = 10;
//    weBtn.layer.masksToBounds = YES;
//    [weBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:weBtn];
}
-(void)buttonClick:(UIButton *)btn
{
    if (btn == oldBtn) {
        //不进行状态改变
    } else {
        btn.selected = YES;
        if (oldBtn != nil) {
            oldBtn.selected = NO;
        }
    }
    oldBtn = btn;
    
    MainSliderViewController *vc = (MainSliderViewController *)[MainSliderViewController sharedSliderController];
    switch (btn.tag-100) {
        case 0:
        {
            TabBarController *TVC = [[TabBarController alloc] init];
            
            if ([vc.MainVC isKindOfClass:[TVC class]]) {
                [vc closeSideBar];
            } else {
                [vc closeSideBarWithAnimate:YES complete:^(BOOL finished) {
                    vc.MainVC = TVC;
                    [vc viewDidLoad];
                }];
            }
        }
            break;
        case 1:
        {
            PinDaoViewController *pindaoVC = [[PinDaoViewController alloc] init];
            
            
            if ([vc.MainVC isKindOfClass:[pindaoVC    class]]) {
                [vc closeSideBar];
            }
            else{
            
                [vc closeSideBarWithAnimate:YES complete:^(BOOL finished) {
            
                    vc.MainVC = pindaoVC;
                    [vc viewDidLoad];
                    
                    
                }];
            
            
            }
        
        }
            break;
        case 2:
        {
            VBangViewController *vvc = [[VBangViewController alloc] init];
            if ([vc.MainVC isKindOfClass:[vvc class]]) {
                [vc closeSideBar];
            } else {
                [vc closeSideBarWithAnimate:YES complete:^(BOOL finished) {
                    vc.MainVC = vvc;
                    [vc viewDidLoad];
                
                }];
            }
        }
            break;
        case 3:
        {
            YueDanViewController *hvc = [[YueDanViewController alloc] init];
            if ([vc.MainVC isKindOfClass:[hvc class]]) {
                [vc closeSideBar];
            } else {
                [vc closeSideBarWithAnimate:YES complete:^(BOOL finished) {
                    vc.MainVC = hvc;
                    [vc viewDidLoad];
                }];
            }
        }
            break;
            //        case 4:
            //        {
            //            DownLoadManagerViewController *dmvc=[DownLoadManagerViewController defaultDownloadManager];
            //            [self.navigationController pushViewController:dmvc animated:YES];
            //        }
            //            break;
            //        case 4:
            //        {
            ////            NSLog(@"***about iMV***");
            //            AboutViewController *vc= [[AboutViewController alloc] init];
            //            [self.navigationController pushViewController:vc animated:YES];
            //        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
