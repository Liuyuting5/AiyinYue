//
//  YueDanDetailRight.h
//  AiYueTai
//
//  Created by qianfeng on 15/6/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YueDanDetailRight : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *artistName;
@property (nonatomic,copy) NSString *des;
@property (nonatomic,copy) NSString *posterPic;
@property (nonatomic,copy) NSString *hdUrl;
@property (nonatomic,copy) NSString *totalViews;
@property (nonatomic,copy) NSString *updateTime;
-(instancetype)initWithdic:(NSDictionary*)dic;
+(YueDanDetailRight*)yuedanDetailRightWithdic:(NSDictionary*)dic;


@end
