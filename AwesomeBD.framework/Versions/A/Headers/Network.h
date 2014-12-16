//
//  Network.h
//  AwesomeBD
//
//  Created by Jamie Currie on 21/11/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

@protocol JSONRequestWrapperDelegate <NSObject>
- (void)JSONRequstedLoadedWithData:(NSDictionary* )results;
- (void)JSONRequstedLoadedWithArray:(NSArray* )results;
- (void)JSONRequstedFailedWithError:(NSError *)error;

@end


typedef enum : NSInteger {
    NotReachable = 0,
    ReachableViaWiFi,
    ReachableViaWWAN
} NetworkStatus;

extern NSString *kReachabilityChangedNotificationDN;


@interface Network : NSObject <NSURLConnectionDelegate> {
    
    NSMutableURLRequest *request;
    
}


// Json Wrapper
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, weak) id <JSONRequestWrapperDelegate> delegate;
@property (nonatomic, strong) NSString *trustedHost;
@property (nonatomic, strong) NSString *authUsername;
@property (nonatomic, strong) NSString *authPassword;
@property (nonatomic, strong) NSString *compID;


- (id)initWithUrl_JSON:(NSString *)targeturl andDelegate:(id)assignedDelegate;
- (id)initWithLocalUrl_JSON:(NSString *)targetfile ofType:(NSString *)type andDelegate:(id)assignedDelegate;
- (void)setRequestBody_JSON:(NSString *)data;
- (void)setRequestHeaderWithKey_JSON:(NSString *)key andValue:(NSString *)value;
- (void)startRequest_JSON;

// Reachability
+ (instancetype)reachabilityWithHostName:(NSString *)hostName;
+ (instancetype)reachabilityWithAddress:(const struct sockaddr_in *)hostAddress;
+ (instancetype)reachabilityForInternetConnection;
+ (instancetype)reachabilityForLocalWiFi;
- (BOOL)startNotifier;
- (void)stopNotifier;
- (NetworkStatus)currentReachabilityStatus;
- (BOOL)connectionRequired;


@end
