//
//  RightModel.h
//  爱悦台
//
//  Created by qianfeng on 15/6/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RightModel : NSObject
//推荐MV的图片、播放地址、标题、作者
@property (nonatomic,copy) NSString *posterPic;
@property (nonatomic,copy) NSString *hdUrl;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *artistName;
@property (nonatomic,copy) NSString *des;
@property (nonatomic) NSNumber *totalViews;
@property (nonatomic,copy) NSString *regdate;
-(instancetype)initWithDic:(NSDictionary*)dic;
+(RightModel*)rightModelWithDic:(NSDictionary*)dic;
@end
