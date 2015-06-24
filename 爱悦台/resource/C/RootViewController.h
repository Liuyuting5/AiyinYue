//
//  RootViewController.h
//  爱悦台
//
//  Created by qianfeng on 15/6/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView1;
    UILabel *_textLabel;
}
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) BOOL show;

@property(nonatomic,assign)BOOL canShowLeft;
@property(nonatomic,assign)BOOL canShowRight;

-(void)customNavItem;


@end
