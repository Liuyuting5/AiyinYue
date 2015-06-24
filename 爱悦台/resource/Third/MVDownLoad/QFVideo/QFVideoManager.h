//
//  QFVideoManager.h
//  视频下载
//
//  Created by yang on 5/5/14.
//  Copyright (c) 2014 Meeca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QFVideoDownloader.h"


// QFVideoManager视频下载管理单例
// QFVideoDownloader单独一个视频下载对象
@interface QFVideoManager : NSObject {
    NSMutableArray *_allConnections;
}

+ (id) sharedInstance;
// 开始一个视频下载
- (void) beginDownloadVideo:(id)urlpath withTitle:(NSString *)nameStr withIndexPath:(NSIndexPath *)indexPath withProgress:(QFDownloadEvent)cb;
// 得到当前所有的正在下载的对象
- (NSArray *) getAllDownloader;
- (float) getCurrProgressByIndexPath:(NSIndexPath *)indexPath;

@end
