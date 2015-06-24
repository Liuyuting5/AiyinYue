//
//  YueDanDetailRight.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "YueDanDetailRight.h"

@implementation YueDanDetailRight



-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"description"]) {
        _des = value;
    }

}
-(instancetype)initWithdic:(NSDictionary*)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;

}
+(YueDanDetailRight*)yuedanDetailRightWithdic:(NSDictionary*)dic{
    YueDanDetailRight *right = [[YueDanDetailRight alloc] initWithdic:dic];
    return right;
}
@end
