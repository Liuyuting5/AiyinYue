//
//  VbangModel.h
//  AiYueTai
//
//  Created by qianfeng on 15/6/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VbangModel : NSObject
@property (nonatomic,copy) NSString *posterPic;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *artistName;
@property (nonatomic,copy) NSString *score;
@property (nonatomic,copy) NSString *des;
@property (nonatomic,copy) NSString *hdUrl;
@property (nonatomic) NSNumber *uid;
-(instancetype)initWithDic:(NSDictionary*)dic;
+(VbangModel*)vbangModelinitWithDic:(NSDictionary*)dic;

@end
