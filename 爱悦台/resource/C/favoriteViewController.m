//
//  favoriteViewController.m
//  爱悦台
//
//  Created by qianfeng on 15/6/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "favoriteViewController.h"
#import "AreaModel.h"
#import "LiveCell.h"
#import "LiveModel.h"
#import "DetailViewController.h"
@interface favoriteViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>
{
    NSInteger _offset;

    NSMutableArray *_liveModel;
    UITableView *_tableView;
}
@end

@implementation favoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    _liveModel = [[NSMutableArray alloc] init];

    [DownLoadData getFavoriteDataWithBlock:^(NSArray* models, NSError *error) {
        _offset=0;
        
        [_liveModel addObjectsFromArray:models];
        
        [_tableView reloadData];
    }  andoffset:_offset];
    
    [self createTableView];
    [_tableView setTableFooterView:[[UIView alloc ] init]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark-创建tableView
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-44) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bg"]];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UINib *nibname = [UINib nibWithNibName:@"LiveCell" bundle:nil];
    [_tableView registerNib:nibname forCellReuseIdentifier:@"LiveCell"];
    [self setupRefresh];
    [self.view addSubview:_tableView];
    
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
    

    
    
    [DownLoadData getFavoriteDataWithBlock:^(NSArray* models, NSError *error) {
        
        [_liveModel addObjectsFromArray:models];
        
        [_tableView.footer endRefreshing];
        [_tableView reloadData];
        
    } andoffset:_offset];
    
}


#pragma mark-下拉刷新

-(void)headerRefreshing{
    
    _offset =0;

    [DownLoadData getFavoriteDataWithBlock:^(NSArray* models, NSError *error) {
        if (_liveModel) {
            [_liveModel removeAllObjects];
        }
        [_liveModel addObjectsFromArray:models];
        
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        
    } andoffset:_offset];

    
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

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    DetailViewController *detailVC = [[DetailViewController alloc] init];
//    LiveModel *liveModel = _liveModel[indexPath.row];
//    detailVC.url=liveModel.hdUrl;
//    detailVC.title = liveModel.title;
//    detailVC.uid = liveModel.uid;
//    [self.navigationController pushViewController:detailVC animated:NO];
//    
//    
//    
//}
-(void)viewWillAppear:(BOOL)animated{
    
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}


@end
