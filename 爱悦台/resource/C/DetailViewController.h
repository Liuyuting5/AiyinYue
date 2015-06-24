//
//  DetailViewController.h
//  爱悦台
//
//  Created by qianfeng on 15/6/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property(nonatomic,copy)NSString*url;
@property(nonatomic,copy)NSString*title;
@property(nonatomic)NSNumber*uid;
- (void)dismissSelf;
@end
