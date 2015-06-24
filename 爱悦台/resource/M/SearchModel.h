//
//  SearchModel.h
//  AiYueTai
//
//  Created by qianfeng on 15/6/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject
@property(nonatomic,copy)NSNumber *uid;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *posterPic;
@property(nonatomic,copy)NSString *artistName;
@property(nonatomic,copy)NSString *hdUrl;
-(instancetype)initWithDic:(NSDictionary*)dic;
+(SearchModel*)SearchModelWithDic:(NSDictionary*)dic;

@end
