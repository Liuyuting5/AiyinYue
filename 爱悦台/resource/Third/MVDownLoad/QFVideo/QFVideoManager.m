//
//  QFVideoManager.m
//  视频下载
//
//  Created by yang on 5/5/14.
//  Copyright (c) 2014 Meeca. All rights reserved.
//

#import "QFVideoManager.h"

@implementation QFVideoManager

+ (id) sharedInstance {
    static id _s;
    if (_s == nil) {
        _s = [[[self class] alloc] init];
    }
    return _s;
}
- (id)init
{
    self = [super init];
    if (self) {
        _allConnections = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) beginDownloadVideo:(id)urlpath withTitle:(NSString *)nameStr withIndexPath:(NSIndexPath *)indexPath withProgress:(QFDownloadEvent)cb {
    // 开始下载
    NSURL *url = [NSURL URLWithString:urlpath];
    QFVideoDownloader *oneItem = [[QFVideoDownloader alloc] initWithURL:url withProgress:cb withTitle:nameStr];
    oneItem.indexPath = indexPath;
    [_allConnections addObject:oneItem];
    [oneItem startDownload];
}

- (float) getCurrProgressByIndexPath:(NSIndexPath *)indexPath {
    for (QFVideoDownloader *oneItem in _allConnections) {
        // 循环当前正在下载的视频
//        if (oneItem.indexPath.row == indexPath.row) {
//            return oneItem.progress;
//        }
    }
    return 0;
}

@end










