//
//  Visual.h
//  AwesomeBD
//
//  Created by Jamie Currie on 21/11/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+MD5.h"

@interface Visual : NSObject

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


+ (void)showMessage: (NSString *) message;


@end
