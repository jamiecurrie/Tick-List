//
//  Social.h
//  AwesomeBD
//
//  Created by Jamie Currie on 21/11/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDataAdditions.h"
#import "Network.h"

@protocol TwitterRequestDelegate <NSObject>
- (void)TwitterDataSucceededWithData:(NSDictionary *)data;
- (void)TwitterDataFailed;
@end

@interface Social : NSObject <JSONRequestWrapperDelegate> {
    Network                 *feedRequest;
    NSString                *cachedURL;
    NSString                *cachedConsumerKey;
    NSString                *cachedNonce;
    NSString                *cachedSignatureKey;
    NSString                *cachedTimestamp;
    NSString                *cachedAuthToken;
    NSString                *cachedSignature;
    int                     cachedCount;
}

@property (nonatomic, weak) id <TwitterRequestDelegate> delegate;

-(id)initWithDelegate_TwitterAuth:(id)assignedDelegate;
-(NSString *) setupBaseParameterStringWithConsumerKey_TwitterAuth:(NSString *)conskey andTokenKey:(NSString *)tokenkey andPostCount:(int)count;
-(NSString *) createSignatureBaseStringWithParameterString_TwitterAuth:(NSString *)params andMethod:(NSString *)method andURL:(NSString *)url;
-(NSString *) createSigningKeyWithConsumerSecret_TwitterAuth:(NSString *)conssecret andTokenSecret:(NSString *)tokensecret;
-(NSString *) calcuteOAuthSignatureWithBaseString_TwitterAuth:(NSString *)baseString;
-(void)startTwitterFeedRequest_TwitterAuth;

@end
