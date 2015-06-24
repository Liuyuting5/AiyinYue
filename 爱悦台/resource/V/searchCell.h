//
//  searchCell.h
//  AiYueTai
//
//  Created by qianfeng on 15/6/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchModel;
@interface searchCell : UITableViewCell
-(void)refreshCell:(SearchModel*)model;
@end
