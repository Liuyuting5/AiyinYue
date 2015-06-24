//
//  SearchModel.m
//  AiYueTai
//
//  Created by qianfeng on 15/6/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{


    if ([key isEqualToString:@"id"]) {
        _uid = value;
        
    }
    
}


-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }

    return self;

}
+(SearchModel*)SearchModelWithDic:(NSDictionary*)dic{
    SearchModel *searchModel = [[SearchModel alloc] initWithDic:dic];
    return searchModel;
}
@end
