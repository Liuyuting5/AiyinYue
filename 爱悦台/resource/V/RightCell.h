//
//  RightCell.h
//  AiYueTai
//
//  Created by qianfeng on 15/6/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  RightModel;
@interface RightCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;


-(void)refreshCell:(RightModel*)rightModel;
@end
