//
//  searchCell.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "searchCell.h"
#import "SearchModel.h"
@interface searchCell()
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@end
@implementation searchCell
-(void)refreshCell:(SearchModel*)model{

    self.artistNameLabel.text = model.artistName;
    self.titleLabel.text = model.title;
    NSURL *url = [NSURL URLWithString:model.posterPic];
    [self.pictureView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"HomecellofficBgg"]];
   }

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
