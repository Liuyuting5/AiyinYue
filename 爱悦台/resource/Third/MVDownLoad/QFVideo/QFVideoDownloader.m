//
//  QFVideoDownloader.m
//  视频下载
//
//  Created by yang on 5/5/14.
//  Copyright (c) 2014 Meeca. All rights reserved.
//

#import "QFVideoDownloader.h"

@interface QFVideoDownloader()

@end

@implementation QFVideoDownloader
- (id) initWithURL:(NSURL *)url withProgress:(QFDownloadEvent)cb withTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.url = url;
        // 对于block赋值需要copy
        progressCb = [cb copy];
        fileName = title;
    }
    return self;
}
- (void) startDownload {
    NSURLRequest *r = [NSURLRequest requestWithURL:self.url];
    c = [[NSURLConnection alloc] initWithRequest:r delegate:self];
}
// 收到响应头... 准备接受真正的数据
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // 取得服务器发过来的数据总大小 总长度...
    fileSize = response.expectedContentLength;
    NSLog(@"video size is %lld", fileSize);
    _data = [[NSMutableData alloc] init];
    fileName = [self getSaveNameByUrl:self.url];
    NSLog(@"file name is %@", fileName);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        [[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];
    }
    fileHandle = [NSFileHandle fileHandleForWritingAtPath:fileName];
}
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [_data appendData:data];
    // 这里不能存在_data 只能写到文件上..
    currDownloadSize += data.length;
//    NSLog(@"progress is %f curr len is %lld", currDownloadSize*1.0/fileSize, currDownloadSize);
    // 把data 追加到文件最后
    [fileHandle writeData:data];
    if (progressCb) {
        progressCb(self, currDownloadSize*1.0/fileSize);
    }
}
- (float) progress {
    return currDownloadSize*1.0/fileSize;
}
- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    [fileHandle synchronizeFile];
    [fileHandle closeFile];
}
- (NSString *) getSaveNameByUrl:(NSURL *)url {
    // http://hc.yinyuetai.com/uploads/videos/common/0B490146B870876E2FFDB328E34EE4F1.flv?sc=744c33256c443b84&br=778&rd=Android
//拼接文件名
    NSString *s = url.absoluteString;
    // 取s最后一个 0B490146B870876E2FFDB328E34EE4F1.flv?sc=744c33256c443b84&br=778&rd=Android
    NSString *f = [s lastPathComponent];
    // 用？裁剪，取数组第0个元素  0B490146B870876E2FFDB328E34EE4F1.flv
    NSArray *array = [f componentsSeparatedByString:@"?"];
    NSArray *array2 = [array[0] componentsSeparatedByString:@"."];
    NSString *filename = [NSString stringWithFormat:@"%@.%@",fileName,array2[1]];
// Documents;  拼接下载MV的存储目标路径
    NSString *dir = [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), @"Documents"];
    NSString *retstr = [NSString stringWithFormat:@"%@/%@",dir,filename];
    return retstr;
}


@end
