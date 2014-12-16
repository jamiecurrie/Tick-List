//
//  Macros.h
//  AwesomeBD
//
//  Created by Jamie Currie on 22/11/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#ifndef AwesomeBD_Macros_h
#define AwesomeBD_Macros_h

// Prefix with BD_ to make it easier to find

// Log
#define BD_log( String, ... ) NSLog( @"<%@:%d> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,  [NSString stringWithFormat:(String), ##__VA_ARGS__] )
#define BD_debuglog( String, ... ) NSLog( @"<AwesomeBD.framework> %@",  [NSString stringWithFormat:(String), ##__VA_ARGS__] )
#define BD_NSStringFromBool(b) (b ? @"TRUE" : @"FALSE")

// Math
#define BD_DEGREES_TO_RADIANS( degrees ) ( degrees * M_PI / 180 )
#define BD_RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define BD_KM_TO_MILES(km) (km*0.621371)

//User Interface
#define BD_isIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define BD_isIPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define BD_isRetinaDevice ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] >= 2)
#define BD_isMultiTaskingSupported ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)] && [[UIDevice currentDevice] isMultitaskingSupported])

//Colors
#define BD_rgb(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//Convenience
#define BD_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#endif
