//
//  DetailModel.m
//  爱悦台
//
//  Created by qianfeng on 15/6/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailModel.h"
#import "RightModel.h"
@interface DetailModel()

@property(nonatomic,strong)NSArray*array;
@end
@implementation DetailModel
- (CGSize)currentSize
{
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
    CGSize size = [self.des boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 500) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.des = value;
    }
    if ([key isEqualToString:@"relatedVideos"]) {
        
        _array = value;
        
        _mutableArray = [[NSMutableArray alloc] init];
        [_array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
             RightModel *rightModel = [RightModel rightModelWithDic:dic];
            
            [_mutableArray addObject:rightModel];
            
            
        }];
       
        
        
        
        
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
+(DetailModel*)detailModelWithDic:(NSDictionary*)dic{
    DetailModel *detailModel = [[DetailModel alloc] initWithDic:dic];
    return detailModel;

}
@end
