//
//  RightModel.m
//  爱悦台
//
//  Created by qianfeng on 15/6/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RightModel.h"

@implementation RightModel




-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.des = value;
    }
    

}
-(id)valueForUndefinedKey:(NSString *)key{


    return nil;
}
-(instancetype)initWithDic:(NSDictionary*)dic{
     
    if(self = [super init])
    {
    
    
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+(RightModel*)rightModelWithDic:(NSDictionary*)dic{
    RightModel *rightModel = [[RightModel alloc] initWithDic:dic];
    return rightModel;
}

@end
