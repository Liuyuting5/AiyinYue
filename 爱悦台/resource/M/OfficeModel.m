//
//  officeModel.m
//  爱悦台
//
//  Created by qianfeng on 15/6/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "OfficeModel.h"

@implementation OfficeModel
//当字典中有key时，但是数据模型里面没有对应key的属性，这种情况会调用下面的方法，可以处理一些特殊情况

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
+(OfficeModel*)officeModelWithDic:(NSDictionary*)dic{

    OfficeModel *officeModel = [[OfficeModel alloc] initWithDic:dic];
    return officeModel;

}
@end
