//
//  officeViewController.m
//  爱悦台
//
//  Created by qianfeng on 15/6/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "OfficeViewController.h"
#import "DownLoadData.h"
#import "MBProgressHUD.h"
#import "OfficeModel.h"
#import "OfficeCell.h"
#import "DetailViewController.h"
@interface OfficeViewController ()<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>
{
   MBProgressHUD *_HUD;
   NSArray *_offices;
    NSMutableArray *_officemutable;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,copy)NSArray *offices;
@end

@implementation OfficeViewController
-(void)viewWillAppear:(BOOL)animated{

    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // self.navigationController.navigationBar.tintColor = [UIColor redColor];
    [_tableView setTableFooterView:[[UIView alloc ] init]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UINib *nibName = [UINib nibWithNibName:@"OfficeCell" bundle:nil];
    [_tableView registerNib:nibName forCellReuseIdentifier:@"officeCellID"];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _officemutable = [NSMutableArray array];
#pragma mark-下载数据
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_HUD];
    
    _HUD.delegate = self;
    _HUD.labelText = @"Loading";
    [_HUD show:YES];


    [DownLoadData getOfficeDatawithblock:^(NSArray*offices , NSError *error) {
        
         [_HUD hide:YES];
//        [_offices addObjectsFromArray:offices];
        _offices = [NSArray arrayWithArray:offices];
     
        [_offices enumerateObjectsUsingBlock:^(OfficeModel *officeModel, NSUInteger idx, BOOL *stop) {
            if (officeModel.hdUrl ) {
                
                [_officemutable addObject:officeModel];
//                NSLog(@"%@",_officemutable);
                
            }
        }];
       
        [_tableView reloadData];
        
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 243*SCREEN_WIDTH/320;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    NSLog(@"%d",indexPath.row);
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.url = [_officemutable[indexPath.row] hdUrl];
 
    detailVC.title = [_officemutable[indexPath.row] title];
    detailVC.uid = [_officemutable[indexPath.row] uid];
    
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    


}
#pragma mark-UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OfficeCell*cell = [tableView dequeueReusableCellWithIdentifier:@"officeCellID" ];
    OfficeModel *officeModel = _officemutable[indexPath.row];
 [cell refreshCell:officeModel];

    return cell;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _officemutable.count;
    
    
}


@end
