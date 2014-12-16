//
//  Debug.h
//  AwesomeBD
//
//  Created by Jamie Currie on 21/11/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Debug : NSObject

+ (void) setDevMode: (BOOL) input;
+ (BOOL) devMode;
+ (void) showDebugLog: (BOOL) input;

+ (void) log: (NSString *) string;

@end
