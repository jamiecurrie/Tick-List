//
//  Visual+LazyLoader.h
//  AwesomeBD
//
//  Created by Jamie Currie on 25/11/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import <AwesomeBD/AwesomeBD.h>

@interface Visual (LazyLoader)

@property (nonatomic, strong) NSString *MD5URL;
@property (nonatomic, strong) NSString *fileURL;
@property (nonatomic, copy) void (^completionHandler)(void);
@property (nonatomic, strong) UIImage *imageDownloaded;
@property (nonatomic, strong) NSMutableData *activeDownload;
@property (nonatomic, strong) NSURLConnection *imageConnection;
@property (nonatomic, assign) BOOL usingcached;
@property (assign, nonatomic) int imWidth;
@property (assign, nonatomic) int imHeight;

- (id)initWithURL_LazyLoader:(NSString *)url targetWidth:(int)newwidth andTargetHeight:(int)newheight;
- (void)startDownload_LazyLoader;
- (void)cancelDownload_LazyLoader;
- (NSString*)getCachedFileName_LazyLoader;

@end
