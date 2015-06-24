//
//  DetailViewController.m
//  爱悦台
//
//  Created by qianfeng on 15/6/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailViewController.h"
#import "DownLoadData.h"
#import "DetailModel.h"
#import "QFVideoManager.h"
#import "SVProgressHUD.h"
#import"VLCMediaPlayer.h"
#import "RightCell.h"
#import "RightModel.h"
@interface DetailViewController ()<MBProgressHUDDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

{
//MV播放视图
    UIView *_showView;
    //开启定时器
    NSTimer *_timer;
    //播放
    VLCMediaPlayer *_player;
    UISegmentedControl *_seg;
    //hud
    MBProgressHUD *HUD;
    UIView * _downView;
    //开始、暂停按键
    UIButton *button;
    //播放按钮
    UIButton *_playBtn;
    //进度条
    UIProgressView *_progress;
    UILabel *_progressLabel;
    //slider
    UISlider *_slider;
    
    //全屏按钮
    UIButton *_fullScreenBtn;
    //总时间换算成float

    CGFloat totalTime;
    UIView *leftView;
    UIView *rightView;
    UITextView *textView;
    UILabel *lable1;
    UILabel *lable2;
    UITableView *_tableView;
    BOOL hiddenStatus;
}


@property(nonatomic,retain)DetailModel*detailModel;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundView"]];
    
    [DownLoadData getDetailDataWithBlock:^(DetailModel *detailModel, NSError *error) {
        
        self.detailModel = detailModel;
        textView.text =self.detailModel.des;
lable1.text = [NSString stringWithFormat:@"播放次数: %@",self.detailModel.totalViews];
        lable2.text = [NSString stringWithFormat:@"更新时间: %@",self.detailModel.regdate];
        
        [_tableView reloadData];
        
    } andid:self.uid];
    
    [self showView];
    [self downView];
    [self segValueChanged:_seg];
    [self createDownView];
    [self addGesture];
    
}
//添加手势
-(void)addGesture{

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickone:)];
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [_showView addGestureRecognizer:tap];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickedTwo:)];
    tap2.numberOfTapsRequired = 2;
    tap2.delegate = self;
    [_showView addGestureRecognizer:tap2];
    [tap requireGestureRecognizerToFail:tap2];

}
//单机时的方法
-(void)tapClickone:(UIGestureRecognizer*)tap{
    static int i=1;
    if (i) {
        [UIView animateWithDuration:1 animations:^{
            _downView.hidden = YES;
            
        }];
        i=0;
    }else{
    
    
        [UIView animateWithDuration:1 animations:^{
            _downView.hidden = NO;
        }];
        i=1;
    }


}
//双击时的方法

-(void)tapClickedTwo:(UIGestureRecognizer*)tap{
    UIButton *but =(UIButton*)[_downView viewWithTag:300];

    [self fullScreenClick:but];

}
//创建播放视图
-(void)showView{
   
    _showView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 180)];
    HUD = [[MBProgressHUD alloc] initWithView:_showView];
    [_showView addSubview:HUD];
    HUD.delegate = self;
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    

    _showView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundView"]];
//    _showView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_showView];
    _player = [[VLCMediaPlayer alloc] init];
    _player.media = [VLCMedia mediaWithURL:[NSURL URLWithString:self.url]];
    _player.drawable = _showView;
    [_player play];
    [self customView];

}
-(void)myTask
{
    sleep(3);
}
- (void)customView
{
    //下边条
    _downView = [[UIView alloc]initWithFrame:CGRectMake(0, _showView.frame.size.height - 36 + 64, SCREEN_WIDTH, 36)];
    //    _downView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"player_bottomGradientBackColor"]];
//      _downView.backgroundColor = [UIColor redColor];
    _downView.userInteractionEnabled = YES;
    [self.view addSubview:_downView];
    
    //添加开始、暂停按键
    button = [[UIButton alloc] initWithFrame:CGRectMake(10, 1, 30, 30)];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"player_video_a_btu"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"player_video_b_btu"] forState:UIControlStateSelected];
    button.selected = YES;
   button.layer.cornerRadius = 15.0f;
    button.layer.masksToBounds = YES;
    button.alpha = 0.5;
    [_downView addSubview:button];
    
//    //进度条
//    _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(45, 18, SCREEN_WIDTH - 90, 36)];
//    _progress.trackTintColor = [UIColor redColor];
//    _progress.progressTintColor = [UIColor greenColor];
//    //原始状态
//    _progress.progressImage = [UIImage imageNamed:@"player_slideThumbImage1"];
//    _progress.progress = 0.01;
    //slider
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(45, 5, SCREEN_WIDTH - 90, 25)];
//    UIImage *thumb1 = [self image:[UIImage imageNamed:@"setting_bg2"] byScalingToSize:CGSizeMake(25, 25)];
    UIImage *thumb2 = [self image:[UIImage imageNamed:@"New_guideIphone5_2"] byScalingToSize:CGSizeMake(25, 25)];
//    [_slider setThumbImage:thumb1 forState:UIControlStateNormal];
    [_slider setThumbImage:thumb2 forState:UIControlStateHighlighted];
    _slider.minimumValue = 0;
    _slider.maximumValue = 0.99;
    
    _slider.minimumTrackTintColor = [UIColor whiteColor];
    _slider.maximumTrackTintColor = [UIColor grayColor];
    
    [_slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    [_downView addSubview:_slider];
    
    //全屏的按键
    _fullScreenBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-45 , 0, 30, 30)];
    _fullScreenBtn.tag = 300;
    [_fullScreenBtn setBackgroundImage:[UIImage imageNamed:@"player_fullScreen"] forState:UIControlStateNormal];
    [_fullScreenBtn setBackgroundImage:[UIImage imageNamed:@"player_smallScreen"] forState:UIControlStateSelected];
    [_fullScreenBtn addTarget:self action:@selector(fullScreenClick:) forControlEvents:UIControlEventTouchDown];
    [_downView addSubview:_fullScreenBtn];
    
    //进度的时间
    _progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 45 - 50, 24, 60, 10)];
    _progressLabel.textColor = [UIColor whiteColor];
    _progressLabel.backgroundColor = [UIColor clearColor];
    _progressLabel.font = [UIFont systemFontOfSize:8];
    _progressLabel.text = @"00:00/00:00";
    [_downView addSubview:_progressLabel];
    
    //创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshMovieInfo) userInfo:nil repeats:YES];
    [_timer fire];

    //结束HUD
//    [SVProgressHUD dismiss];
}
- (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}

//定时器方法
-(void)refreshMovieInfo{

    static NSString *total;
    if ([_player.time.stringValue isEqualToString:@"00:00"]&&totalTime==0) {
        
        total = [NSString stringWithFormat:@"%@",_player.remainingTime.stringValue];
        total = [total substringFromIndex:1];
        NSArray *array = [ total componentsSeparatedByString:@":"];
        totalTime = [array[0] floatValue]*60+[array[1] floatValue];
        
    
    }if (total!=nil) {
        _progressLabel.text = [NSString stringWithFormat:@"%@/%@",_player.time,total];
        
        //进度条的刷新
        //计算时间
        NSArray *array = [_player.time.stringValue componentsSeparatedByString:@":"];
        CGFloat currentTime = [array[0] floatValue] * 60 + [array[1] floatValue];
        
        _slider.value = currentTime / totalTime ;
        //        NSLog(@"%f",_slider.value);
        if (_slider.value >= 0.99) {
            
            _slider.value = 0.01;
            
            [self sliderChange:_slider];
            
            [_player pause];

        }
    }
}
-(void)sliderChange:(UISlider*)slider{
    [_player setTime:[[VLCTime alloc] initWithNumber:[NSNumber numberWithFloat:slider.value *totalTime * 1000]]];
    
    
    
}

//暂停、播放按钮
-(void)btnClick:(UIButton*)bnt
{
    button.selected = !button.selected;
    if (bnt.selected == YES) {
        [_player play];

         
    }
    else{
    
    
        [_player pause];
    }
}
//全屏播放按钮
-(void)fullScreenClick:(UIButton *)bnt{
    
    bnt.selected = !bnt.selected;
    hiddenStatus = !hiddenStatus;
    [self.navigationController setNavigationBarHidden:hiddenStatus animated:YES];
    static int i=0;
    if (i==0) {
        //横屏
        _showView.transform = CGAffineTransformMakeScale(SCREEN_WIDTH / _showView.frame.size.height ,  SCREEN_HEIGHT / _showView.frame.size.width);
        _showView.transform = CGAffineTransformRotate(_showView.transform,M_PI_2);
        _showView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        _showView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        //隐藏相关视图
        leftView.hidden = YES;
        rightView.hidden = YES;
        _seg.hidden = YES;
        //调整_downView
        _downView.transform =CGAffineTransformRotate(_downView.transform, M_PI_2);
        _downView.frame = CGRectMake(0, SCREEN_HEIGHT-_downView.frame.size.height, 36, SCREEN_WIDTH);
        i++;
    }else{
    //退出全屏
        _showView.transform = CGAffineTransformRotate(_showView.transform, -M_PI_2);
        _showView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 180);
    //显示相关视图
        leftView.hidden = NO;
        rightView.hidden = NO;
        _seg.hidden = NO;
        //调整_downView的位置
        _downView.transform = CGAffineTransformRotate(_downView.transform, -M_PI_2);
        _downView.frame = CGRectMake(0, _showView.frame.size.height - 36 + 64, SCREEN_WIDTH, 36);
        i--;
        
    
    }
    
    
    
    
    
    
    
   
}
-(void)downView{
    NSArray *array = @[@"MV相关描述",@"相关MV"];
    _seg = [[UISegmentedControl alloc] initWithItems:array];

    _seg.frame = CGRectMake(20, 244, SCREEN_WIDTH-40, 25);
    [_seg setSelectedSegmentIndex:0];
    [_seg addTarget:self action:@selector(segValueChanged:) forControlEvents:UIControlEventValueChanged];
    _seg.tintColor = [UIColor colorWithRed:41/0x100 green:156/(CGFloat)0x100 blue:119/(CGFloat)0x100 alpha:1];
    [self.view addSubview:_seg];
    
}

-(void)segValueChanged:(UISegmentedControl*)seg{
//    NSLog(@"%d",seg.selectedSegmentIndex);
    if (seg.selectedSegmentIndex == 1) {
        
        leftView.hidden = YES;
        rightView.hidden = NO;
        [self creatTableView];
        
        
    }else if( seg.selectedSegmentIndex==0)
    {
        rightView.hidden = YES;
        leftView.hidden = NO;
    }
    

}
-(void)createDownView{
    //左边视图
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 275, SCREEN_WIDTH, SCREEN_HEIGHT-270)];
    leftView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundView"]];
//    leftView.backgroundColor = [UIColor greenColor];
    //详情
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-270-15)];
    [textView resignFirstResponder];
    //    textView.isEditable = NO;
    textView.font = [UIFont systemFontOfSize:15];
    textView.editable = NO;
    textView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundView"]];
    textView.textColor = [UIColor whiteColor];
//    textView.backgroundColor = [UIColor redColor];
    lable1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, (SCREEN_WIDTH-10)/2, 20)];
    lable1.textColor = [UIColor whiteColor];
    lable2 = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-10)/2+5, 0,(SCREEN_WIDTH-10)/2 , 20)];
    lable2.textColor = [UIColor whiteColor];
    lable2.font = [UIFont systemFontOfSize:13];
    lable1.font = [UIFont systemFontOfSize:13];

    [leftView addSubview:lable2];
    [leftView addSubview:lable1];
    [self.view addSubview:leftView];
    [leftView addSubview:textView];
    //创建右侧视图uiview
    
    
    rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 275, SCREEN_WIDTH, SCREEN_HEIGHT-270)];
    [self.view addSubview:rightView];
    [rightView isHidden];
    
}
-(void)creatTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-270) style:UITableViewStylePlain];
//    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundView"]];
//    _tableView.backgroundColor= [UIColor redColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [rightView addSubview:_tableView];
    UINib *nibname = [UINib nibWithNibName:@"RightCell" bundle:nil];
    [_tableView registerNib:nibname forCellReuseIdentifier:@"rightCell"];

   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.detailModel.mutableArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    RightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell"];
    
    RightModel *rightModel = self.detailModel.mutableArray[indexPath.row];
    
    [cell refreshCell:rightModel];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96.0*SCREEN_WIDTH/320.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RightModel *right =self.detailModel.mutableArray[indexPath.row];
    if ([self.navigationItem.title isEqualToString:right.title]) {
        
        return;
    }

    else {
        [_player stop];
        self.navigationItem.title = right.title;
        self.url = right.hdUrl;
        textView.text = right.des;
        lable1.text = [NSString stringWithFormat:@"播放次数 :%@",right.totalViews];
        lable2.text = [NSString stringWithFormat:@"更新时间 :%@",right.regdate];
        [self showView];
    
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{

}
-(void)viewWillDisappear:(BOOL)animated{


    [_player stop];

}

- (void)dismissSelf {
  
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
