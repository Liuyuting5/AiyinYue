//
//  LiveCell.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LiveCell.h"
#import "LiveModel.h"
@interface LiveCell()
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@end
@implementation LiveCell
-(void)refreshCell:(LiveModel*)liveModel{
    self.titleLabel.text = liveModel.title;
    self.artistNameLabel.text = liveModel.artistName;
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:liveModel.posterPic] placeholderImage:[UIImage imageNamed:@"HomecellofficBgg"]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
