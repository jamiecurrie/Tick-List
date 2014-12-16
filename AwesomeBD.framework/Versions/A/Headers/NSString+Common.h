//
//  NSString+Common.h
//  AwesomeBD
//
//  Created by Jamie Currie on 25/11/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Common)

-(BOOL)isBlank;
-(BOOL)containsSubString:(NSString *)string;
-(BOOL)containsCaseSensitiveSubString:(NSString *)string;
-(NSArray *)splitOnChar:(char)ch;
-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;
-(NSString *)stringByStrippingWhitespace;

@end
