//
//  PinDaoViewController.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PinDaoViewController.h"
#import "PindaoModel.h"
#import "PindaoCell.h"
#import "PinDaoListController.h"
@interface PinDaoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSMutableArray *pinDaoModels;
    MBProgressHUD *_HUD;
    
}

@end

@implementation PinDaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    pinDaoModels = [[NSMutableArray alloc] init];
    self.label.text = @"频道";
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    UINib *nibName = [UINib nibWithNibName:@"PindaoCell" bundle:nil];
    [_collectionView registerNib:nibName forCellWithReuseIdentifier:@"collectionCell"];
//    _collectionView.backgroundColor = [UIColor yellowColor];
//    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 200)];
//    la.backgroundColor = [UIColor redColor];
//    [_collectionView addSubview:la];
    [self.view addSubview:_collectionView];
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    _HUD = [[MBProgressHUD alloc] init];
    [self.view addSubview:_HUD];
    [_HUD  show:YES];
    [manager GET:[NSString stringWithFormat:PINDAO_SHOUYE@"%@",DEVICE_URL] parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* dic) {
        NSArray *array = dic[@"data"];
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            PindaoModel *pinDaoModel = [PindaoModel pinDaoModelWithDic:dic];
            [pinDaoModels addObject:pinDaoModel];
            
        }];
        
        
        [_collectionView reloadData];
        [_HUD hide:YES ];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      
        
    }];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return pinDaoModels.count;
//    return 3;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    PindaoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    PindaoModel * model =pinDaoModels[indexPath.row];
    [cell refreshcell:model];

    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-3)/2, (SCREEN_WIDTH-3)/2);


}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(100, 100, 0, 0);
//}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    PinDaoListController *VC = [[PinDaoListController alloc] init];
 
    PindaoModel *model = pinDaoModels[indexPath.row];
    VC.title = model.title;
    VC.uid = model.uid;
    VC.type = model.type;
    [self presentViewController:VC animated:YES completion:nil];
    
    
    
}

@end
