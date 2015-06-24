//
//  AreaModel.h
//  AiYueTai
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaModel : NSObject
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString*code;
-(instancetype)initWithDictionary:(NSDictionary*)dic;
+(AreaModel *)AreaModelWithDictionary:(NSDictionary*)dic;

@end
