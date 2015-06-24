//
//  OfficeCell.h
//  爱悦台
//
//  Created by qianfeng on 15/6/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OfficeModel;
@interface OfficeCell : UITableViewCell
-(void)refreshCell:(OfficeModel*)officeModel;
@end
