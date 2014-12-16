//
//  Network+JSON.h
//  AwesomeBD
//
//  Created by Jamie Currie on 25/11/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import <AwesomeBD/AwesomeBD.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

@protocol JSONRequestWrapperDelegate <NSObject>
- (void)JSONRequstedLoadedWithData:(NSDictionary* )results;
- (void)JSONRequstedLoadedWithArray:(NSArray* )results;
- (void)JSONRequstedFailedWithError:(NSError *)error;

@end

@interface Network (JSON)

@property (strong, nonatomic) NSMutableURLRequest *request;

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


@end
