//
//  YueDanViewController.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "YueDanViewController.h"
#import "YueDanModel.h"
#import "YueDanCell.h"
#import "YueDanDetailController.h"

@interface YueDanViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UISegmentedControl *_seg;
    NSArray *array;
    NSInteger _offset;
    MBProgressHUD *_HUD;
    NSMutableArray *models;
    NSString *code;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation YueDanViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    models = [[NSMutableArray alloc] init];
    [_tableView registerNib:[UINib nibWithNibName:@"YueDanCell" bundle:nil] forCellReuseIdentifier:@"yuedanCell"];
self.label.text = @"悦单";
    array = @[@"CHOISE",@"HOT",@"NEW"];
    NSArray *ItemsArray = @[@"精选",@"热门",@"最新"];
    _seg = [[UISegmentedControl alloc] initWithItems:ItemsArray];
    [_seg setFrame:CGRectMake(0, 64, SCREEN_WIDTH, 25)];
_seg.tintColor = [UIColor colorWithRed:41/0x100 green:156/(CGFloat)0x100 blue:119/(CGFloat)0x100 alpha:1];
    [self.view addSubview:_seg];
//    [_seg setSelectedSegmentIndex:0];
    _seg.selectedSegmentIndex = 0;
    [_seg addTarget:self action:@selector(segValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self segValueChanged:_seg];
    [self setupRefresh];
    
}
-(void)segValueChanged:(UISegmentedControl*)seg{
    
    NSInteger index = seg.selectedSegmentIndex;
    code = array[index];

    _HUD = [[MBProgressHUD alloc] init];
    [self.view addSubview:_HUD];
    [_HUD show:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    NSString *url = [NSString stringWithFormat:YUE_DAN_URL@"&%@",array[index],_offset,DEVICE_URL];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * dic) {
        if (models) {
            [models removeAllObjects];
        }
        NSArray *array1 = dic[@"playLists"];
                [array1 enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            
                    YueDanModel *model = [[YueDanModel alloc] init];
                    model.title = dic[@"title"];
                    model.nickName = dic[@"creator"][@"nickName"];
                    model.videoCount = dic[@"videoCount"];
                    model.weekIntegral = dic[@"weekIntegral"];
                    model.playListBigPic = dic[@"playListBigPic"];
                    model.largeAvatar = dic[@"creator"][@"largeAvatar"];
                    model.uid = dic[@"id"];
                    
                    
                    
                    [models addObject:model];
                    

            
        }];
        [_tableView reloadData];
        
        [_HUD hide:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
}];


}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YueDanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yuedanCell"];
    [cell refresh:models[indexPath.row]];
    

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  243*SCREEN_WIDTH/320;


}

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
//下拉刷新
-(void)headerRefreshing{
    _offset = 0;
    [_tableView.header beginRefreshing];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    NSString *url = [NSString stringWithFormat:YUE_DAN_URL@"&%@",code,_offset,DEVICE_URL];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * dic) {
        if (models) {
            [models removeAllObjects];
        }
        NSArray *array1 = dic[@"playLists"];
        [array1 enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            
            YueDanModel *model = [[YueDanModel alloc] init];
            model.title = dic[@"title"];
            model.nickName = dic[@"creator"][@"nickName"];
            model.videoCount = dic[@"videoCount"];
            model.weekIntegral = dic[@"weekIntegral"];
            model.playListBigPic = dic[@"playListBigPic"];
            model.largeAvatar = dic[@"creator"][@"largeAvatar"];
            model.uid = dic[@"id"];
            
            
            
            [models addObject:model];
            
            
            
        }];
        [_tableView reloadData];
        
        [_tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}


//上拉刷新
-(void)footerRefreshing{
    

    _offset += 21;
    [_tableView.footer beginRefreshing];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    NSString *url = [NSString stringWithFormat:YUE_DAN_URL@"&%@",code,_offset,DEVICE_URL];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * dic) {
        
        NSArray *array1 = dic[@"playLists"];
        [array1 enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            
            YueDanModel *model = [[YueDanModel alloc] init];
            model.title = dic[@"title"];
            model.nickName = dic[@"creator"][@"nickName"];
            model.videoCount = dic[@"videoCount"];
            model.weekIntegral = dic[@"weekIntegral"];
            model.playListBigPic = dic[@"playListBigPic"];
            model.largeAvatar = dic[@"creator"][@"largeAvatar"];
            model.uid = dic[@"id"];
            
            
            
            [models addObject:model];
            
            
            
        }];
        [_tableView.footer endRefreshing];
        [_tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  YueDanDetailController *DVC = [[YueDanDetailController alloc] init];
    YueDanModel *model =models[indexPath.row];
    
    DVC.title = model.title;
    DVC.idid = model.uid;
[self presentViewController:DVC animated:YES completion:nil];
    

}



@end
