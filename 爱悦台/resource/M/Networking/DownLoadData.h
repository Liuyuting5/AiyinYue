//
//  DownLoadData.h
//  007AFN的使用
//
//  Created by 黎跃春 on 15/5/18.
//  Copyright (c) 2015年 黎跃春. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DetailModel;
@interface DownLoadData : NSObject

#pragma mark-获取官方推荐数据
// http://mapi.yinyuetai.com/suggestions/front_page.json?D-A=0&rn=640*540
//DeviceInfo: deviceinfo=%7B%22aid%22%3A%2210201027%22%2C%22os%22%3A%22Android%22%2C%22ov%22%3A%224.4.2%22%2C%22rn%22%3A%22480*800%22%2C%22dn%22%3A%22MX4%22%2C%22cr%22%3A%2200000%22%2C%22as%22%3A%22WIFI%22%2C%22uid%22%3A%220658f913a8fe165d024ba839ed691e38%22%2C%22clid%22%3A110010000%7D
+ (NSURLSessionDataTask *)getOfficeDatawithblock:(void (^)(id obj, NSError *error))block;


#pragma mark-获取点击详情数据
+ (NSURLSessionDataTask *)getDetailDataWithBlock:(void (^)(DetailModel *detailModel, NSError *error))block andid:(NSNumber*)uid;

//获取热播界面的地区信息
+ (NSURLSessionDataTask *)getHotAreaDataWithBlock:(void (^)( id obj, NSError *error))block;
#pragma mark-获取各个地区的数据
+ (NSURLSessionDataTask *)getHotDataWithBlock:(void (^)(id obj, NSError *error))block withcode:(NSString*)code;

#pragma mark-上拉刷新
+(NSURLSessionDataTask*)getNewDataWithBlock:(void(^)(id obj ,NSError *error ))block andCode:(NSString *)code andoffset:(NSInteger)offset;
//获取首播界面的地区信息
+ (NSURLSessionDataTask *)getLiveAreaDataWithBlock:(void (^)( id obj, NSError *error))block;
//获取流行界面的地区信息
+ (NSURLSessionDataTask *)getPopAreaDataWithBlock:(void (^)( id obj, NSError *error))block;
//猜你喜欢url
+ (NSURLSessionDataTask *)getFavoriteDataWithBlock:(void (^)(id obj, NSError *error))block andoffset:(NSInteger)offset;
//获取V榜地区的数据
+ (NSURLSessionDataTask *)getVbangAreDataWithBlock:(void (^)(id obj, NSError *error))block;




@end















