//
//  officeModel.h
//  爱悦台
//
//  Created by qianfeng on 15/6/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfficeModel : NSObject
//@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *clickUrl;
@property(nonatomic,copy)NSString *des;
@property(nonatomic,copy)NSString *hdUrl;
@property(nonatomic,copy)NSString *posterPic;
@property(nonatomic,copy)NSString *thumbnailPic;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *traceUrl;
@property(nonatomic,copy)NSString *uhdUrl;
@property(nonatomic,copy)NSString *url;
@property(nonatomic)NSNumber *uid;
@property(nonatomic)NSNumber *videoSize;
@property(nonatomic)NSNumber *hdVideoSize;
@property(nonatomic)NSNumber *uhdVideoSize;
@property(nonatomic)NSNumber *status;
-(instancetype)initWithDic:(NSDictionary*)dic;
+(OfficeModel*)officeModelWithDic:(NSDictionary*)dic;

@end
