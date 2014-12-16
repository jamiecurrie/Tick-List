//
//  Storage.h
//  AwesomeBD
//
//  Created by Jamie Currie on 21/11/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Storage : NSObject

+ (void) saveObject: (id) input withFileName: (NSString *) name;
+ (id) openFileWithName: (NSString *) name;
+ (void) deleteFileWithName: (NSString *) name;

@end
