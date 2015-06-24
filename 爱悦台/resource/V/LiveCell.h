//
//  LiveCell.h
//  AiYueTai
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LiveModel;
@interface LiveCell : UITableViewCell
-(void)refreshCell:(LiveModel*)liveModel;
@end
