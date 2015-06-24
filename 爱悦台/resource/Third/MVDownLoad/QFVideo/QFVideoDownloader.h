//
//  QFVideoDownloader.h
//  视频下载
//
//  Created by yang on 5/5/14.
//  Copyright (c) 2014 Meeca. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QFVideoDownloader;

typedef void (^QFDownloadEvent)(QFVideoDownloader *download, float progress);

@interface QFVideoDownloader : NSObject <NSURLConnectionDataDelegate> {
    QFDownloadEvent progressCb;
    NSURLConnection *c;
    // 文件总长度
    long long fileSize;
    // 当前下载的长度
    long long currDownloadSize;
    NSMutableData *_data;
    NSString *fileName;
    NSFileHandle *fileHandle;
}
@property (nonatomic, retain) NSIndexPath *indexPath;
- (float) progress;
@property (nonatomic, retain) NSURL *url;
- (id) initWithURL:(NSURL *)url withProgress:(QFDownloadEvent)cb withTitle:(NSString *)title;
- (void) startDownload;
@end
