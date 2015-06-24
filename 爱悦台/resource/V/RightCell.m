//
//  RightCell.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RightCell.h"

#import "RightModel.h"
@interface RightCell()
@end




@implementation RightCell
-(void)refreshCell:(RightModel*)rightModel{
    _titleLabel.text  = rightModel.title;
    _artistLabel.text = rightModel.artistName;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:rightModel.posterPic] placeholderImage:[UIImage imageNamed:@"HomecellofficBgg"]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
