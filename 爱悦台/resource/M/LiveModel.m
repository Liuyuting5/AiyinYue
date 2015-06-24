//
//  LiveModel.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LiveModel.h"

@implementation LiveModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"]) {
        
        _des = ((NSString *)value).description;
    }
    if ([key isEqualToString:@"id"]) {
        _uid = value;
    }
    
    
}

//防止别人利用kvc来读取数据模型的属性，当属性不存在时，如果不重写下面的方法，程序会发生崩溃
- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}




-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
    
}
+(LiveModel*)liveModelWithDic:(NSDictionary*)dic{
    
    LiveModel *liveModel = [[LiveModel alloc] initWithDic:dic];
    return liveModel;
    
}

@end
