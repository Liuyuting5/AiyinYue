//
//  YueDanDetsilLeft.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "YueDanDetsilLeft.h"
#import "YueDanDetailRight.h"
@implementation YueDanDetsilLeft


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
  
    
    
    if ([key isEqualToString:@"description"]) {
        _des = value;
        
    }
    if ([key isEqualToString:@"videos"]) {
        _rightModels = [[NSMutableArray alloc] init];
        _array = value;
        [_array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            
            
            YueDanDetailRight *model = [YueDanDetailRight yuedanDetailRightWithdic:dic];
            [_rightModels addObject:model];
        }];
        
    }
    
}


-(id)valueForUndefinedKey:(NSString *)key{

    return nil;
    
}
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;

}

+(YueDanDetsilLeft*)yuedanDetsileLeftWithDic:(NSDictionary*)dic{

    YueDanDetsilLeft *Left = [[YueDanDetsilLeft alloc] initWithDic:dic];
    return Left;

}


@end
