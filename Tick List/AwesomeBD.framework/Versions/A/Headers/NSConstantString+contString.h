//
//  NSConstantString+contString.h
//  AwesomeBD
//
//  Created by Jamie Currie on 25/11/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSConstantString (contString)

-(BOOL) containsSubString: (NSString *) string;
-(int) findCharInString: (NSString *) string;

@end
