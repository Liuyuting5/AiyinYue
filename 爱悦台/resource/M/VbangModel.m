//
//  VbangModel.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "VbangModel.h"

@implementation VbangModel


-(id)valueForUndefinedKey:(NSString *)key{

    return nil;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.des = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.uid = value;
    }

}

-(instancetype)initWithDic:(NSDictionary*)dic{

    if (self  = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
    
}
+(VbangModel*)vbangModelinitWithDic:(NSDictionary*)dic{
    VbangModel *model = [[VbangModel alloc] initWithDic:dic];
    return model;

}

@end
