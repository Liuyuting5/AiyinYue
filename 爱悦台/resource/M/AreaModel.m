//
//  AreaModel.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AreaModel.h"

@implementation AreaModel
-(instancetype)initWithDictionary:(NSDictionary*)dic
{
    if (self = [super init]) {
        self.code = dic[@"code"];
        self.name = dic[@"name"];
    }
    
    return self;
}
+(AreaModel *)AreaModelWithDictionary:(NSDictionary*)dic{
    
    AreaModel *areaModel = [[AreaModel alloc] initWithDictionary:dic];
    return areaModel;
}


@end
