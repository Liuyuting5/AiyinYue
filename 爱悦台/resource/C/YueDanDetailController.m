//
//  YueDanDetailController.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "YueDanDetailController.h"
#import "SVProgressHUD.h"
#import "YueDanDetsilLeft.h"
#import "VLCMediaPlayer.h"
#import "RightCell.h"
#import "YueDanDetailRight.h"
@interface YueDanDetailController ()<MBProgressHUDDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
{    CGFloat totalTime;

    VLCMediaPlayer *_player;
    MBProgressHUD *_HUD;
    NSMutableArray *models;
    UITableView *_tableView;
  
    UIView *_showView;
    UIView *leftView;
    UIView *rightView;
    UIView *_downView;
    UIButton *button;
    UISlider *_slider;
    UIButton *_fullScreenBtn;
    UILabel *_progressLabel;
    NSTimer *_timer;
    BOOL hiddenStatus;
    UISegmentedControl *_seg;
    UITextView *textView;
    UILabel *lable1;
    UILabel *lable2;
    YueDanDetsilLeft *Leftmodel;
}
@property (nonatomic,copy) NSString *showUrl;
@property(nonatomic)UILabel *label;
@end

@implementation YueDanDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    view.backgroundColor = [UIColor colorWithRed:24/255.0 green:80/255.0 blue:120/255.0 alpha:1.000];
    
    [self.view addSubview:view];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(view.bounds.size.width/2-40, 24, 80, 40);
    
    //    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.label = label;
    label.text = self.title;
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:self.label];
    
    
    //左侧按钮
    UIButton *button1= [[UIButton alloc] initWithFrame:CGRectMake(10, 24, 40, 40)];
    [button1 setImage:[UIImage imageNamed:@"yyt_return"] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"yyt_return_Sel"] forState:UIControlStateHighlighted];
//    button1.back groundColor = [UIColor redColor];
    [button1 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button1];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundView"]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", nil];
    NSString *string = [NSString stringWithFormat:YUE_DAN_DETAIL_url@"&%@",self.idid,DEVICE_URL];
    NSLog(@"%@",string);
    [manager GET:string parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* dic) {
        
        YueDanDetsilLeft *model = [YueDanDetsilLeft yuedanDetsileLeftWithDic:dic];
        Leftmodel = model;
        textView.text =model.des;
        lable1.text = [NSString stringWithFormat:@"播放次数: %@",model.totalViews];
        lable2.text = [NSString stringWithFormat:@"更新时间: %@",model.updateTime];
        
        [_tableView reloadData];
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
    
    [self createdownView];
    
    [self show];
    [self downView];
    
    
    [self createtableView];
    
    [self addGesture];
    
}
-(void)createtableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-270) style:UITableViewStylePlain];
    //    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundView"]];
    //    _tableView.backgroundColor= [UIColor redColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UINib * DetailNib = [UINib nibWithNibName:@"RightCell" bundle:nil];
    [_tableView registerNib:DetailNib forCellReuseIdentifier:@"rightCell"];
    [rightView addSubview:_tableView];



}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return Leftmodel.rightModels.count;
    
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell"];
    
    
    YueDanDetailRight *rightMdeol = Leftmodel.rightModels[indexPath.row];
    cell.titleLabel.text =rightMdeol.title;
    
    cell.artistLabel.text = rightMdeol.artistName;
    
    [cell.iconView  sd_setImageWithURL:[NSURL URLWithString:rightMdeol.posterPic] placeholderImage:[UIImage imageNamed:@"HomecellofficBgg"]];
    return cell;
  
    
    

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96.0*SCREEN_WIDTH/320.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    YueDanDetailRight *right =Leftmodel.rightModels[indexPath.row];
    if([self.label.text isEqualToString:right.title]) {
        
        return;
    }
    
    else {
        [_player stop];
        self.label.text= right.artistName;
        self.showUrl = right.hdUrl;
        textView.text = right.des;
        lable1.text = [NSString stringWithFormat:@"播放次数 :%@",right.totalViews];
        lable2.text = [NSString stringWithFormat:@"更新时间 :%@",right.updateTime];
        [self show];
        
    }

 
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

-(void)back:(UIButton*)bnt{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)show{
    _showView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 180)];
    _showView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundView"]];
    [self.view addSubview:_showView];
    _player = [[VLCMediaPlayer alloc] init];

    if (self.showUrl) {
        _player.media = [VLCMedia mediaWithURL:[NSURL URLWithString:self.showUrl]];
        _player.drawable = _showView;
        [_player play];
    }
        _HUD = [[MBProgressHUD alloc] init];
    [_showView addSubview:_HUD];
    _HUD.delegate = self;
    
    [_HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
    [self customView];

}
-(void)myTask{

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
    NSArray *array = @[@"悦单相关描述",@"悦单相关MV"];
    _seg = [[UISegmentedControl alloc] initWithItems:array];
    
    _seg.frame = CGRectMake(20, 244, SCREEN_WIDTH-40, 25);
    [_seg setSelectedSegmentIndex:0];
    [self segValueChanged:_seg];
    [_seg addTarget:self action:@selector(segValueChanged:) forControlEvents:UIControlEventValueChanged];
    _seg.tintColor = [UIColor colorWithRed:41/0x100 green:156/(CGFloat)0x100 blue:119/(CGFloat)0x100 alpha:1];
    [self.view addSubview:_seg];
    
}
-(void)segValueChanged:(UISegmentedControl*)seg{
    //    NSLog(@"%d",seg.selectedSegmentIndex);
    if (seg.selectedSegmentIndex == 1) {
        
        leftView.hidden = YES;
        rightView.hidden = NO;
//        [self creatTableView];
        
        
    }else if( seg.selectedSegmentIndex==0)
    {
        rightView.hidden = YES;
        leftView.hidden = NO;
    }
    
    
}
-(void)createdownView{
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
-(void)viewWillDisappear:(BOOL)animated{
    
    [_player stop];
}

@end
