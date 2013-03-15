//
//  SRSimpleRemoteObject.h
//  NSRemoteJsonObject
//
//  Created by Hal Seki on 2/22/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRRemoteConfig.h"

typedef void(^SRFetchCompletionBlock)(NSArray *allRemote, NSError *error);


@interface SRSimpleRemoteObject : NSObject
@property (nonatomic, strong) NSNumber* remoteId;

+(void)fetchAsync:(SRFetchCompletionBlock)completionBlock;
+(void)fetchAsyncWithParams:(NSDictionary *)params async:(SRFetchCompletionBlock)completionBlock;


/*
 // should override on subclass
 */
+(NSString *)representUrl;
+(NSString *)resultKey;

// optional

//
// Please extend this method if you want to customize object parse rules
//
-(void)parseObject:(id)object ForKey:(NSString *)key;

//
// Please override this method you want to specify date format.
// default is "yyyy-MM-dd HH:mm:ssZZZZ"
//
-(NSString *)timeformat;

@end
