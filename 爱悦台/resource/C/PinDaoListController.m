//
//  PinDaoListController.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PinDaoListController.h"
#import "LiveModel.h"
#import "LiveCell.h"
#import "DetailViewController.h"
@interface PinDaoListController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _offset;
    DetailViewController *_detailVC;
    NSMutableArray *pinDaoModels;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PinDaoListController

- (void)viewDidLoad {
    [super viewDidLoad];
        UIView *view = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    pinDaoModels = [[NSMutableArray alloc] init];
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
    UIButton *button= [[UIButton alloc] initWithFrame:CGRectMake(10, 24, 40, 40)];
    [button setImage:[UIImage imageNamed:@"yyt_return"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"yyt_return_Sel"] forState:UIControlStateHighlighted];
[button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UINib *nibName = [UINib nibWithNibName:@"LiveCell" bundle:nil];
    [_tableView registerNib:nibName forCellReuseIdentifier:@"pindaoCell"];
    [self setupRefresh];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    NSString *url = [NSString stringWithFormat:PINDAO_LIST_URL@"&%@",self.type,self.type,self.uid,DEVICE_URL];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * dic) {
        NSArray *array = dic[@"videos"];
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            
            
            LiveModel *model = [LiveModel liveModelWithDic:dic];
            [pinDaoModels addObject:model];
            
        }];
        [_tableView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
        
    }];
    
}
-(void)back:(UIButton*)bnt{


    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return pinDaoModels.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pindaoCell"];
    
    [cell refreshCell:pinDaoModels[indexPath.row]];

    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
return 243*SCREEN_WIDTH/320;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _detailVC = [[DetailViewController alloc] init];
    //    LiveModel *liveModel =models[indexPath.row];
    //    detailVC.url=liveModel.hdUrl;
    //    detailVC.title = liveModel.title;
    //    detailVC.uid = liveModel.uid;
    LiveModel *Mldel = pinDaoModels[indexPath.row];
    _detailVC.url =Mldel.hdUrl;
    _detailVC.title = Mldel.title;
    _detailVC.uid = Mldel.uid;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_detailVC];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor whiteColor];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    _detailVC.navigationItem.leftBarButtonItem = leftButton;
    [button addTarget:self action:@selector(dismissDetailVC) forControlEvents:UIControlEventTouchUpInside];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)dismissDetailVC {
    [_detailVC dismissSelf];
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
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    NSString *url = [NSString stringWithFormat:PINDAO_LIST_URL@"&%@",self.type,self.type,self.uid,DEVICE_URL];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * dic) {
        NSArray *array = dic[@"videos"];
        if (pinDaoModels) {
            [pinDaoModels removeAllObjects];
        }

        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            
            
            LiveModel *model = [LiveModel liveModelWithDic:dic];
           [pinDaoModels addObject:model];
            
        }];
        [_tableView reloadData];
        
        [_tableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
        
    }];
}
//上拉刷新
-(void)footerRefreshing{
    _offset +=21;
//    if (pinDaoModels) {
//        [pinDaoModels removeAllObjects];
//    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];

    NSString *url = [NSString stringWithFormat:PINDAO_LIST_MORE_URL @"&%@",self.type,_offset,self.type,self.uid,DEVICE_URL];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * dic) {
        
        NSArray *array = dic[@"videos"];
        if (array.count == 0) {
//            [_tableView reloadData];
            [[_tableView footer] noticeNoMoreData];
        } else {
            [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
                
                
                LiveModel *model = [LiveModel liveModelWithDic:dic];
                
                
                [pinDaoModels addObject:model];
                
            }];
            [_tableView.footer endRefreshing];
            [_tableView reloadData];
//            [UIView animateWithDuration:3.0 animations:^{
//                [_tableView setContentOffset:CGPointMake(0, 0)];
//            }];
        
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@", error);
        
        
    }];
    

}

@end
