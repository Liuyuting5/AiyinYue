//
//  LiveViewController.m
//  爱悦台
//
//  Created by qianfeng on 15/6/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LiveViewController.h"
#import "OfficeModel.h"
#import "AreaModel.h"
#import "LiveCell.h"
#import "LiveModel.h"
#import "DetailViewController.h"
@interface LiveViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>
{   MBProgressHUD *_HUD;

    NSString *code;
    NSArray *areaModels;
    UISegmentedControl *_seg;
    NSMutableArray *_liveModel;
    UITableView *_tableView;
    NSInteger _offset;
}
@property(nonatomic,retain)NSString*name;

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _liveModel = [[NSMutableArray alloc] init];
    _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_HUD];
    

    _HUD.delegate = self;
    _HUD.labelText = @"Loading";
    [_HUD show:YES];

    [DownLoadData getLiveAreaDataWithBlock:^(NSArray *areaModel, NSError *error) {
        areaModels = [NSArray arrayWithArray:areaModel];
        [_HUD hide:YES];
         [self createSegement];
       
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createTableView];
    [_tableView setTableFooterView:[[UIView alloc ] init]];
    
}

#pragma mark-创建tableView
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-64-50-44) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bg"]];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UINib *nibname = [UINib nibWithNibName:@"LiveCell" bundle:nil];
    [_tableView registerNib:nibname forCellReuseIdentifier:@"LiveCell"];
    [self setupRefresh];

    [self.view addSubview:_tableView];

}
#pragma mark-代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 243*SCREEN_WIDTH/320;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _liveModel.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveCell"];
    LiveModel *liveModel = _liveModel[indexPath.row];
    [cell refreshCell:liveModel];
    return cell;
}

#pragma mark-创建上边选择条
-(void)createSegement{

    NSArray *array =@[@"全部",@"内地",@"港台",@"欧美",@"韩国",@"日本"];
    
    _seg = [[UISegmentedControl alloc] initWithItems:array];
      NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor,[UIFont fontWithName:@"AppleGothic"size:15],UITextAttributeFont ,nil];
    [_seg setTitleTextAttributes:dic forState:UIControlStateNormal];
    [_seg setFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    [_seg setSelectedSegmentIndex:0];
    [_seg addTarget:self action:@selector(segValueChange:) forControlEvents:UIControlEventValueChanged];
        _seg.tintColor = [UIColor colorWithRed:41/0x100 green:156/(CGFloat)0x100 blue:119/(CGFloat)0x100 alpha:1];
    [self.view addSubview:_seg];
    [self segValueChange:_seg];

}
//选择
-(void)segValueChange:(UISegmentedControl *)seg{
    NSInteger index = seg.selectedSegmentIndex;
    if (_liveModel) {
        [_liveModel removeAllObjects];
    }
     AreaModel *areaModel= areaModels[index];
    code = areaModel.code;
    NSLog(@"%@",areaModel.code);;
    [DownLoadData getHotDataWithBlock:^(NSArray* liveModels, NSError *error) {
        
        [_liveModel addObjectsFromArray:liveModels];
    
     [_tableView reloadData];
        
        
    } withcode:code];

}
#pragma mark-点中cell时触发的方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    LiveModel *liveModel = _liveModel[indexPath.row];
    detailVC.url=liveModel.hdUrl;
    detailVC.title = liveModel.title;
    detailVC.uid = liveModel.uid;
    [self.navigationController pushViewController:detailVC animated:NO];
    
    

}
#pragma mark-添加刷新与加载

-(void)setupRefresh{
    [_tableView.header setTitle:nil forState:MJRefreshHeaderStateIdle];
    [_tableView.header setTitle:nil forState:MJRefreshHeaderStateRefreshing];
    [_tableView.header setTitle:nil forState:MJRefreshHeaderStatePulling];
    [_tableView.footer setTitle:@"下拉刷新" forState:MJRefreshFooterStateIdle];
    [_tableView.footer setTitle:@"正在刷新" forState:MJRefreshFooterStateRefreshing];
    [_tableView.footer setTitle:@"没有数据了" forState:MJRefreshFooterStateNoMoreData];
    _tableView.header.textColor = [UIColor grayColor];
    _tableView.header.font = [UIFont systemFontOfSize:13];
    
    _tableView.footer.textColor = [UIColor grayColor];
    _tableView.footer.font = [UIFont systemFontOfSize:13];
    [_tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    
}
#pragma mark-上拉刷新
-(void)footerRefreshing{
    _offset+=20;
    [DownLoadData getNewDataWithBlock:^(NSArray* models, NSError *error) {
        
        [_liveModel addObjectsFromArray:models];
        
        
        [_tableView reloadData];
        [_tableView.footer endRefreshing];
        
        
        
    } andCode:code andoffset:_offset];
    
    
    
}


#pragma mark-下拉刷新

-(void)headerRefreshing{
    
    _offset =0;
    //下载刷新的数据
    [DownLoadData getHotDataWithBlock:^(NSArray* liveModels, NSError *error) {
        
        //        _liveModel= [NSArray arrayWithArray:liveModels];
        if (_liveModel) {
            [_liveModel removeAllObjects];
        }
        [_liveModel addObjectsFromArray:liveModels];
        
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        
    } withcode:code];
    
    
}

-(void)viewWillAppear:(BOOL)animated{

    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
