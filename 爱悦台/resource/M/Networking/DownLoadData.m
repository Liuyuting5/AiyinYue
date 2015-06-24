//
//  DownLoadData.m
//  007AFN的使用
//
//  Created by 黎跃春 on 15/5/18.
//  Copyright (c) 2015年 黎跃春. All rights reserved.
//

#import "DownLoadData.h"
#import "AFAppDotNetAPIClient.h"
#import "OfficeModel.h"
#import "DetailModel.h"
#import "AreaModel.h"
#import "LiveModel.h"
@implementation DownLoadData
#pragma mark-获取官方推荐数据
+ (NSURLSessionDataTask *)getOfficeDatawithblock:(void (^)(id obj, NSError *error))block{

    return [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"%@&%@",OFFICE_URL,DEVICE_URL] parameters:nil success:^(NSURLSessionDataTask *task, NSArray* JSON) {
        
        NSMutableArray *offices = [NSMutableArray array];
        [JSON enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
//            NSLog(@"%@", JSON);
            OfficeModel * officeModel =[OfficeModel officeModelWithDic:dic];
            [offices addObject:officeModel];
            
        }];
    
        if (block) {
            
            block(offices,nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        if (block) {
            
            block(nil,error);
        }
        
    }];
    
    

}
#pragma mark-获取点击详情数据


+ (NSURLSessionDataTask *)getDetailDataWithBlock:(void (^)( DetailModel  *detailModel, NSError *error))block andid:(NSNumber*)uid{

    return [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"%@%@&%@",DETAIL_URL,uid,DEVICE_URL] parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary*dic ) {
        
        //NSLog(@"%@",dic);
        DetailModel *detailModel = [DetailModel detailModelWithDic:dic];
        
        if (block) {
            block(detailModel,nil);
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (block) {
            block(nil,error);
        }
        
    }];


}
//获取地区名
+ (NSURLSessionDataTask *)getHotAreaDataWithBlock:(void (^)( id  obj, NSError *error))block  {
    
    return [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"%@&%@",LIVE_AREA_URL,DEVICE_URL] parameters:nil success:^(NSURLSessionDataTask *task, NSArray*array ) {
        NSLog(@"====%@",array);
        NSMutableArray *areas = [[NSMutableArray alloc] init];
        //NSLog(@"%@",dic);
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
             AreaModel *areaModel = [AreaModel AreaModelWithDictionary:dic];
            [areas addObject:areaModel];
            
        } ];
       
                 if (block) {
            block(areas,nil);
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (block) {
            block(nil,error);
        }
        
    }];
    
    
}

+ (NSURLSessionDataTask *)getHotDataWithBlock:(void (^)(id obj, NSError *error))block withcode:(NSString*)code{

    return [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"%@area=%@%@&%@",AREA_BEFOR,code,AREA_BEHIND,DEVICE_URL] parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* dic) {
        NSArray *array = dic[@"videos"];
        
          NSMutableArray *liveModels = [[NSMutableArray alloc] init];
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
          
            
            LiveModel *liveModel  = [LiveModel liveModelWithDic:dic];
            [liveModels addObject:liveModel];
            
        }];
        
        if (block) {
            block(liveModels,nil);
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil,error);
        }
    }];

}
#pragma mark-上拉刷新
+(NSURLSessionDataTask*)getNewDataWithBlock:(void(^)(id obj ,NSError *error ))block andCode:(NSString *)code andoffset:(NSInteger)offset{
    
    return [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"%@area=%@"NEW_DATA_URL@"&%@",AREA_BEFOR,code,offset,DEVICE_URL] parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* dic) {
        
        NSArray *array = dic[@"videos"];
        NSMutableArray *Models =[[NSMutableArray alloc] init];
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            LiveModel *model = [LiveModel liveModelWithDic:dic];
            [Models addObject:model];
            
            
        }];
        if (block) {
            block(Models,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil,error);
        }
        
        
        
    }];


}
//获取首播界面的地区信息
+ (NSURLSessionDataTask *)getLiveAreaDataWithBlock:(void (^)( id obj, NSError *error))block{

    return [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"%@&%@",SHOUBO_ARE_URL,DEVICE_URL] parameters:nil success:^(NSURLSessionDataTask *task, NSArray*array ) {
        NSLog(@"====%@",array);
        NSMutableArray *areas = [[NSMutableArray alloc] init];
        //NSLog(@"%@",dic);
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            AreaModel *areaModel = [AreaModel AreaModelWithDictionary:dic];
            [areas addObject:areaModel];
            
        } ];
        
        if (block) {
            block(areas,nil);
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (block) {
            block(nil,error);
        }
        
    }];

}
//获取流行界面的地区信息
+ (NSURLSessionDataTask *)getPopAreaDataWithBlock:(void (^)( id obj, NSError *error))block{
    return [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"%@&%@",POP_AREA_URL,DEVICE_URL] parameters:nil success:^(NSURLSessionDataTask *task, NSArray*array ) {
        NSLog(@"====%@",array);
        NSMutableArray *areas = [[NSMutableArray alloc] init];
        //NSLog(@"%@",dic);
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            AreaModel *areaModel = [AreaModel AreaModelWithDictionary:dic];
            [areas addObject:areaModel];
            
        } ];
        
        if (block) {
            block(areas,nil);
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (block) {
            block(nil,error);
        }
        
    }];

}
//猜你喜欢url
+ (NSURLSessionDataTask *)getFavoriteDataWithBlock:(void (^)(id obj, NSError *error))block andoffset:(NSInteger)offset{
    return [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat: FAVORITE_NEW_URL@"&%@",offset,DEVICE_URL]parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* dic) {
        
        NSArray *array = dic[@"videos"];
        NSMutableArray *Models =[[NSMutableArray alloc] init];
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            LiveModel *model = [LiveModel liveModelWithDic:dic];
            [Models addObject:model];
            
            
        }];
        if (block) {
            block(Models,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil,error);
        }
        
        
        
    }];
    
}
+ (NSURLSessionDataTask *)getVbangAreDataWithBlock:(void (^)(id obj, NSError *error))block{

    return [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:VBANG_AREA@"&%@",DEVICE_URL] parameters:nil success:^(NSURLSessionDataTask *task, NSArray *array) {
        NSMutableArray *models = [[NSMutableArray alloc] init];
        [array enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            
            AreaModel *model = [AreaModel AreaModelWithDictionary:dic];
            
            [models addObject:model];
            
        }];
        if (block) {
            block(models,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (block) {
            block(nil,error);
        }
        
        
    }];

}

@end












