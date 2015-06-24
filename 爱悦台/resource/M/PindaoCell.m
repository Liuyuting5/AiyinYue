//
//  PindaoCell.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PindaoCell.h"
#import "PindaoModel.h"
@interface PindaoCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;


@end
@implementation PindaoCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)refreshcell:(PindaoModel *)model{

    self.titleLabel.text = model.title;
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"HomecellofficBgg"]];
    
    
    
}
@end
