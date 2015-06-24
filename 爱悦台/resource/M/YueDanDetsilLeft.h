//
//  YueDanDetsilLeft.h
//  AiYueTai
//
//  Created by qianfeng on 15/6/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YueDanDetailRight;
@interface YueDanDetsilLeft : NSObject
@property(nonatomic,copy)NSString *vide;
@property (nonatomic,copy) NSString *des;
@property (nonatomic) NSNumber *totalViews;
@property (nonatomic,copy) NSString *updateTime;
@property(nonatomic,retain)YueDanDetailRight *rightModel;
@property(nonatomic,copy)NSMutableArray * rightModels;
@property(nonatomic,copy)NSArray *array;

-(instancetype)initWithDic:(NSDictionary*)dic;

+(YueDanDetsilLeft*)yuedanDetsileLeftWithDic:(NSDictionary*)dic;


@end
