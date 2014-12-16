//
//  NSObject+UIView_NibLoading.h
//  VisitNorwich
//
//  Created by James Burrows on 05/12/2013.
//  Copyright (c) 2013 Balloondog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NibLoading)

+ (id)loadInstanceFromNib;
+ (id)loadInstanceFromNibWithNamed:(NSString *)nibname;

@end
