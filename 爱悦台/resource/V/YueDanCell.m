//
//  YueDanCell.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "YueDanCell.h"
#import "YueDanModel.h"
@interface YueDanCell()
@property (weak, nonatomic) IBOutlet UIImageView *bgPictureBView;
@property (weak, nonatomic) IBOutlet UIImageView *smallPictureView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherLabel;
@end
@implementation YueDanCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)refresh:(YueDanModel*)model{

    
    [self.bgPictureBView sd_setImageWithURL:[NSURL URLWithString:model.playListBigPic] placeholderImage:[UIImage imageNamed:@"HomecellofficBgg"]];
    [self.smallPictureView sd_setImageWithURL:[NSURL URLWithString:model.largeAvatar] placeholderImage:[UIImage imageNamed:@"HomecellofficBgg"]];
    _titleLabel.text = model.title;
    _otherLabel.textColor = [UIColor whiteColor];
    _nickNameLabel.text = model.nickName;
_nickNameLabel.textColor = [UIColor whiteColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _otherLabel.text = [NSString stringWithFormat:@"收录高清MV:%@首 获得积分总数:%@",model.videoCount,model.weekIntegral];

}


@end
