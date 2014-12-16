//
//  Location.h
//  AwesomeBD
//
//  Created by Jamie Currie on 21/11/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "Macros.h"

@protocol LocationDelegate <NSObject>
- (void) foundBeacon: (CLBeacon *) beacon;
- (void) beaconSearchError: (NSError *) error;
@end

@interface Location : NSObject <CLLocationManagerDelegate>

@property (strong,nonatomic) CLLocationManager *locationManager;
@property (assign,nonatomic) int major;
@property (assign,nonatomic) int minor;
@property (assign,nonatomic) BOOL majorMinorMode;
@property (strong,nonatomic) CLBeaconRegion *beaconReigen;
@property (nonatomic, weak) id <LocationDelegate> delegate;



-(instancetype)initWithDelegate: (id) delegate;
-(CGPoint) getCurrentLocation;
- (void) searchForBeaconWithUUID: (NSString *) stringUUID major: (int) major andMinor: (int) minor;
- (void) searchForBeaconWithUUID: (NSString *) stringUUID;
- (void) stopSearchingForBeacons;

+(float)getDistanceBetweenPointA:(CGPoint)pointA andPointB:(CGPoint)pointB;

@end
