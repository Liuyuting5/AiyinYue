//
//  NSFileManager+PathMethod.m
//  LimitFreeProject
//
//  Created by student on 14-4-4.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "NSFileManager+PathMethod.h"


// 文件管理类的类别、
@implementation NSFileManager (PathMethod)



// 判断指定路径下得文件是否超出了规定的时间

+(BOOL)isTimeOutWhthPath:(NSString *)path time:(NSTimeInterval)time{

   //通过 NSFileManager 取到 path 下得文件属性 属性包括文件的创建时间
    
    // defaultManager 方法得到文件管理类的单例对象
    // 获取 path 路径下文件的属性
    NSDictionary * info = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    
    //NSLog(@"info : %@",info);
    //取到文件的创建时间
    NSDate * createDate = [info objectForKey:NSFileCreationDate];
    
    //获取到系统的当前时间
    
    NSDate * date = [NSDate date];
    
    // 算时间差
     NSTimeInterval currentTime  =  [date timeIntervalSinceDate:createDate];
    
    if (currentTime > time) {
        //YES 代表已经超时
        return YES;
    }
    
    //  no 代表没有超时
    return NO;

}



@end
