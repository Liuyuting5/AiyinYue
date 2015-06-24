//
//  OfficeCell.m
//  爱悦台
//
//  Created by qianfeng on 15/6/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "OfficeCell.h"
#import "OfficeModel.h"
#import "UIImageView+AFNetworking.h"
@interface OfficeCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *desLable;
@property (weak, nonatomic) IBOutlet UIImageView *picure;
@end
@implementation OfficeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)refreshCell:(OfficeModel*)officeModel{

    _desLable.text = officeModel.des;
    _desLable.textColor = [UIColor greenColor];
    _titleLable.textColor = [UIColor whiteColor];
    _titleLable.text = officeModel.title;
    NSURL *url = [NSURL URLWithString:officeModel.posterPic];
    [_picure setImageWithURL:url];

}
@end
