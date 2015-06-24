//
//  VBangViewController.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "VBangViewController.h"
#import "AreaModel.h"
#import "VbangModel.h"
#import "VbangCell.h"
#import "DetailViewController.h"
@interface VBangViewController ()<UITableViewDelegate,UITableViewDataSource>
{DetailViewController *_detail;
    UISegmentedControl *_seg;
    NSArray *areaModels;
    NSString *code;
    NSMutableArray *VbangModels;
    NSInteger _offset;
    NSString * date;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@end
@implementation VBangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    VbangModels = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
    self.label.text = @"V榜";
//    self.view.backgroundColor = [UIColor blackColor];
    
    [DownLoadData getVbangAreDataWithBlock:^(NSArray* models, NSError *error) {
        areaModels =[NSArray arrayWithArray:models];
        [self createSegement];
        
    }];
    
    [_tableView setTableFooterView:[[UIView alloc] init]];
    
    [_tableView registerNib:[UINib nibWithNibName:@"VbangCell" bundle:nil] forCellReuseIdentifier:@"VbangCell"];
    [self setUprefresh];
    
}
-(void)createSegement{
    
    NSArray *array =@[@"内地",@"韩国",@"港台",@"日本",@"欧美"];
    
    _seg = [[UISegmentedControl alloc] initWithItems:array];
    [_seg setFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    [_seg setSelectedSegmentIndex:0];
    [_seg addTarget:self action:@selector(segValueChange:) forControlEvents:UIControlEventValueChanged];
    _seg.tintColor = [UIColor colorWithRed:41/0x100 green:156/(CGFloat)0x100 blue:119/(CGFloat)0x100 alpha:1];
    [self.view addSubview:_seg];
    [self segValueChange:_seg];
    
}
-(void)segValueChange:(UISegmentedControl *)seg{
    NSInteger index = seg.selectedSegmentIndex;
    _offset = 0;
    AreaModel *areaModel= areaModels[index];
    code = areaModel.code;
    
    if (VbangModels) {
        [VbangModels removeAllObjects];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    NSString  *str =[NSString stringWithFormat:VBANG_URL@"&%@",code,_offset,DEVICE_URL];
    [manager GET:str parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* dic) {
        date = dic[@"no"];
        
        _dateLable.text = [NSString stringWithFormat:@"第%@期",date];
//        _dateLable.textColor = [UIColor whiteColor];
        NSArray *array = [[NSArray alloc] init];
        array = dic[@"videos"];
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            VbangModel *model = [VbangModel vbangModelinitWithDic:dic];
            [VbangModels addObject:model];
            
            
            
            
        }];
        [_tableView reloadData];
    } failure:
     ^(NSURLSessionDataTask *task, NSError *error) {
         
        
         
     }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  VbangModels.count;
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VbangCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VbangCell"];
    
    
    [cell refreshCell:VbangModels[indexPath.row]];
    cell.rankLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    _detail = detailVC;
    _detail.url = [VbangModels[indexPath.row] hdUrl];
    
    _detail.title = [VbangModels[indexPath.row] title];
    _detail.uid = [VbangModels[indexPath.row] uid];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_detail];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor whiteColor];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    _detail.navigationItem.leftBarButtonItem = leftButton;
    [button addTarget:self action:@selector(dismissDetailVC) forControlEvents:UIControlEventTouchUpInside];
    [self presentViewController:nav animated:YES completion:nil];
    

}
- (void)dismissDetailVC {
    [_detail dismissSelf];
}
-(void)setUprefresh{
    [_tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    
}

//下拉刷新
-(void)headerRefreshing{
    _offset = 0;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    NSString  *str =[NSString stringWithFormat:VBANG_URL@"&%@",code,_offset,DEVICE_URL];
    [manager GET:str parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* dic) {
        date = dic[@"no"];
        
        _dateLable.text = [NSString stringWithFormat:@"第%@期",date];
        //        _dateLable.textColor = [UIColor whiteColor];
        NSArray *array = [[NSArray alloc] init];
        array = dic[@"videos"];
        if (VbangModels) {
            [VbangModels removeAllObjects];
        }
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            VbangModel *model = [VbangModel vbangModelinitWithDic:dic];
            [VbangModels addObject:model];
            
            
            
            
        }];
        [_tableView.header endRefreshing];
        [_tableView reloadData];
    } failure:
     ^(NSURLSessionDataTask *task, NSError *error) {
         
         
         
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
    
    NSString  *str =[NSString stringWithFormat:VBANG_URL@"&%@",code,_offset,DEVICE_URL];
    [manager GET:str parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* dic) {
        date = dic[@"no"];
        
        _dateLable.text = [NSString stringWithFormat:@"第%@期",date];
        //        _dateLable.textColor = [UIColor whiteColor];
        NSArray *array = [[NSArray alloc] init];
        array = dic[@"videos"];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            VbangModel *model = [VbangModel vbangModelinitWithDic:dic];
            [VbangModels addObject:model];
            
            
            
            
        }];
        [_tableView.footer endRefreshing];
        [_tableView reloadData];
    } failure:
     ^(NSURLSessionDataTask *task, NSError *error) {
         
         
         
     }];
    
    
}



@end
