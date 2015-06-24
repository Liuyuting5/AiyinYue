//
//  SearchViewController.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchModel.h"
#import "searchCell.h"
#import "DetailViewController.h"
#import "LiveModel.h"
@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *searchBar;
    UIButton *searchBnt;
    UIView *_noDataView;
    NSMutableArray *models;
    UITableView *_tableView;
    NSInteger _offset;
    
}

- (IBAction)biaoQianbuttonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *searchBiaoQianView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UIButton *button10;
@property (weak, nonatomic) IBOutlet UIButton *button11;
@property (weak, nonatomic) IBOutlet UIButton *button12;
@property (weak, nonatomic) IBOutlet UIButton *button13;
@property (weak, nonatomic) IBOutlet UIButton *button14;
@property (weak, nonatomic) IBOutlet UIButton *button15;
@property (weak, nonatomic) IBOutlet UIButton *button16;
@property (weak, nonatomic) IBOutlet UIButton *button17;
@property (weak, nonatomic) IBOutlet UIButton *button18;
@property (weak, nonatomic) IBOutlet UIButton *button19;
@property (weak, nonatomic) IBOutlet UIButton *button20;

@property (nonatomic)DetailViewController *detailVC;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    models = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundView"]];
    self.view.userInteractionEnabled = YES;
    [self createView];
    [self setButtonRadius];
    [self createNavView];
    [self createTableView];
    _tableView.hidden = YES;
    
    
}

#pragma mark-创建顶部的搜索栏
-(void)createView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *searchBarBg = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    searchBarBg.backgroundColor = [UIColor colorWithRed:26/(CGFloat)0x100 green:26/(CGFloat)0x100 blue:26/(CGFloat)0x100 alpha:1];
    [self.view addSubview:searchBarBg];
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH-60, 40)];
    searchBar.tintColor = [UIColor blueColor];
    searchBar.layer.cornerRadius = 10;
    searchBar.layer.masksToBounds = YES;
//       searchBar.placeholder = @"//";
    [self.view addSubview:searchBar];
   //搜素按钮
    searchBnt = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60+10, 64, 40, 40)];
    [searchBnt setTitle:@"搜索" forState:UIControlStateNormal];
    searchBnt.backgroundColor =[UIColor grayColor];
    [searchBnt addTarget:self action:@selector(searchBntClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBnt];
    
}
//搜索按钮点击事件
-(void)searchBntClicked:(UIButton*)button{
    [searchBar resignFirstResponder];
    if (searchBar.text.length==0) {
        _searchBiaoQianView.hidden = YES;
        [self createNoDataView];
        }
#pragma mark-请求数据
    NSString *urlstring = [NSString stringWithFormat:@"%@%@&%@",SEARCH_URL,[searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],DEVICE_URL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager] ;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    
    if (models) {
        [models removeAllObjects];
    }
    [manager GET:urlstring parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* dic) {
        NSArray *array = dic[@"videos"];
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            SearchModel *searchModel = [SearchModel SearchModelWithDic:dic];
            [models addObject:searchModel];
            [_tableView reloadData];
            
        }];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
    }];
    _searchBiaoQianView.hidden = YES;
    _tableView.hidden = NO ;
}
//创建TabeView
-(void)createTableView{
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64+40, SCREEN_WIDTH, SCREEN_HEIGHT-104) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self  setUpRefresh];
    UINib *nibName = [UINib nibWithNibName:@"searchCell" bundle:nil];
    [_tableView registerNib:nibName forCellReuseIdentifier:@"searchCell"];
    [self.view addSubview:_tableView];

}

#pragma mark-tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return models.count;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    searchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];
    
    SearchModel *searchModel = models[indexPath.row];
    [cell refreshCell:searchModel];
    return cell;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 150;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _detailVC = [[DetailViewController alloc] init];
//    LiveModel *liveModel =models[indexPath.row];
//    detailVC.url=liveModel.hdUrl;
//    detailVC.title = liveModel.title;
//    detailVC.uid = liveModel.uid;
    SearchModel *seacrMldel = models[indexPath.row];
    _detailVC.url =seacrMldel.hdUrl;
    _detailVC.title = seacrMldel.title;
    _detailVC.uid = seacrMldel.uid;
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

    
    


#pragma mark -tableView添加刷新
-(void)setUpRefresh{

    [_tableView.header setTitle:@"下拉刷新" forState:MJRefreshHeaderStateIdle];
    [_tableView.header setTitle:@"松开刷新" forState:MJRefreshHeaderStatePulling];
    [_tableView.header setTitle:@"正在刷新" forState:MJRefreshHeaderStateRefreshing];
    
    [_tableView.footer setTitle:@"上拉加载" forState:MJRefreshFooterStateIdle];
    [_tableView.footer setTitle:@"正在加载" forState:MJRefreshFooterStateRefreshing];
    [_tableView.footer setTitle:@"没有更多数据了" forState:MJRefreshFooterStateNoMoreData];
    
    _tableView.header.textColor = [UIColor grayColor];
    _tableView.header.font = [UIFont systemFontOfSize:12];
    _tableView.footer.textColor = [UIColor grayColor];
    _tableView.footer.font = [UIFont systemFontOfSize:12];
    
    [_tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];

}

#pragma mark-上拉刷新
-(void)footerRefresh{
    if (models) {
        [models removeAllObjects];
    }
    
#pragma mark-请求数据
    NSString *urlstring = [NSString stringWithFormat:@"%@%@&%@",SEARCH_URL,[searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],DEVICE_URL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager] ;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    
    if (models) {
        [models removeAllObjects];
    }
    [manager GET:urlstring parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* dic) {
        NSArray *array = dic[@"videos"];
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            SearchModel *searchModel = [SearchModel SearchModelWithDic:dic];
            [models addObject:searchModel];
            [_tableView reloadData];
            [_tableView.footer endRefreshing];
        }];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
    }];
    
    
    
}
#pragma mark-下拉刷新
-(void)headerRefresh{
    _offset += 21;
    NSString *urlstring = [NSString stringWithFormat:@"%@%@&%@",SEARCH_URL,[searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],DEVICE_URL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager] ;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    
    if (models) {
        [models removeAllObjects];
    }
    [manager GET:urlstring parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* dic) {
        NSArray *array = dic[@"videos"];
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            SearchModel *searchModel = [SearchModel SearchModelWithDic:dic];
            [models addObject:searchModel];
            [_tableView reloadData];
            [_tableView.header endRefreshing ];
        }];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
    }];
    



}

//点击键盘退出
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [searchBar resignFirstResponder];
//    [searchBar endEditing:YES];

}
//创建没有数据的View
-(void)createNoDataView{
    _noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-114)];
    _noDataView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_noDataView];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 200)];
    lable.text = @"您没有输入歌手名字，请重新输入";
    lable.textColor = [UIColor magentaColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:13];
    lable.numberOfLines = 0;
    [_noDataView addSubview:lable];
    


}
//定制上面的导航条
-(void)createNavView{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 24, 36, 36)];
    [button setImage:[UIImage imageNamed:@"yyt_return"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"yyt_return_Sel"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 22, 200, 40)];
    label.text = @"搜索";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];

}
-(void)backClicked:(UIButton*)button{

    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)biaoQianbuttonClicked:(UIButton*)sender {
    
    searchBar.text =sender.titleLabel.text;
}
// 设置button标签的外观
-(void)setButtonRadius{
    
    self.button1.layer.cornerRadius = 3;
    self.button1.layer.masksToBounds = YES;
    
    
    self.button2.layer.cornerRadius = 3;
    self.button2.layer.masksToBounds = YES;
    self.button3.layer.cornerRadius = 3;
    self.button3.layer.masksToBounds = YES;
    self.button4.layer.cornerRadius = 3;
    self.button4.layer.masksToBounds = YES;
    self.button5.layer.cornerRadius = 3;
    self.button5.layer.masksToBounds = YES;
    self.button6.layer.cornerRadius = 3;
    self.button6.layer.masksToBounds = YES;
    self.button7.layer.cornerRadius = 3;
    self.button7.layer.masksToBounds = YES;
    self.button8.layer.cornerRadius = 3;
    self.button8.layer.masksToBounds = YES;
    self.button9.layer.cornerRadius = 3;
    self.button9.layer.masksToBounds = YES;
    self.button10.layer.cornerRadius = 3;
    self.button10.layer.masksToBounds = YES;
    self.button11.layer.cornerRadius = 3;
    self.button11.layer.masksToBounds = YES;
    self.button12.layer.cornerRadius = 3;
    self.button12.layer.masksToBounds = YES;
    self.button13.layer.cornerRadius = 3;
    self.button13.layer.masksToBounds = YES;
    self.button14.layer.cornerRadius = 3;
    self.button14.layer.masksToBounds = YES;
    self.button15.layer.cornerRadius = 3;
    self.button15.layer.masksToBounds = YES;
    self.button16.layer.cornerRadius = 3;
    self.button16.layer.masksToBounds = YES;
    self.button17.layer.cornerRadius = 3;
    self.button17.layer.masksToBounds = YES;
    self.button18.layer.cornerRadius = 3;
    self.button18.layer.masksToBounds = YES;
    self.button19.layer.cornerRadius = 3;
    self.button19.layer.masksToBounds = YES;
    self.button20.layer.cornerRadius = 3;
    self.button20.layer.masksToBounds = YES;
    
    
}


@end
