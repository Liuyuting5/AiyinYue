//
//  LiveModel.h
//  AiYueTai
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *artistName;
@property (nonatomic,copy) NSString *posterPic;
@property (nonatomic,copy) NSString *des;
@property (nonatomic,copy) NSString *hdUrl;
@property (nonatomic) NSNumber *uid;
-(instancetype)initWithDic:(NSDictionary*)dic;
+(LiveModel*)liveModelWithDic:(NSDictionary*)dic;


@end
