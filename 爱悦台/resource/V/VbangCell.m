//
//  VbangCell.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "VbangCell.h"
#import "VbangModel.h"
@interface VbangCell()

@end
@implementation VbangCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)refreshCell:(VbangModel*)model{
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:model.posterPic] placeholderImage:[UIImage imageNamed:@"HomecellofficBgg"]];
    self.scoreLabel.text = model.score;
    self.titleLabel.text = model.title;
    self.artistLabel.text = model.artistName;


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
