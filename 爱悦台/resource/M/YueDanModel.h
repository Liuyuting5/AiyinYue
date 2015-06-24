//
//  YueDanModel.h
//  AiYueTai
//
//  Created by qianfeng on 15/6/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YueDanModel : NSObject
//悦单播放列表
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic) NSNumber *videoCount;
@property (nonatomic) NSNumber *weekIntegral;
@property (nonatomic,copy) NSString *playListBigPic;
@property (nonatomic,copy) NSString *largeAvatar;
@property (nonatomic,copy) NSNumber *uid;

@end
