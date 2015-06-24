//
//  DetailModel.h
//  爱悦台
//
//  Created by qianfeng on 15/6/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RightModel;
@interface DetailModel : NSObject
//正在播放MV的文字说明、播放次数、更新时间,相关MV
@property (nonatomic,copy) NSString *des;
@property (nonatomic) NSNumber *totalViews;
@property (nonatomic,copy) NSString *regdate;
@property(nonatomic,copy)NSString *relatedV;
@property(nonatomic,strong)RightModel*rightModel;
@property(nonatomic,strong)NSMutableArray *mutableArray;
- (CGSize)currentSize;
-(instancetype)initWithDic:(NSDictionary*)dic;
+(DetailModel*)detailModelWithDic:(NSDictionary*)dic;
@end
