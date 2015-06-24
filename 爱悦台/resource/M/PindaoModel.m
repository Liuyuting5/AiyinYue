//
//  PindaoModel.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PindaoModel.h"


@implementation PindaoModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.uid =  value;
    }

}
-(id)valueForUndefinedKey:(NSString *)key{

    return nil;
}

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        

    }
    return self;
   }
+(PindaoModel*)pinDaoModelWithDic:(NSDictionary*)dic{
    PindaoModel *pindaoModel = [[PindaoModel alloc] initWithDic:dic];
    return pindaoModel;
}



@end
