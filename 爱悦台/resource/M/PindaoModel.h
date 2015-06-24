//
//  PindaoModel.h
//  AiYueTai
//
//  Created by qianfeng on 15/6/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PindaoModel : NSObject
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *img;
-(instancetype)initWithDic:(NSDictionary*)dic;
+(PindaoModel*)pinDaoModelWithDic:(NSDictionary*)dic;
@end
