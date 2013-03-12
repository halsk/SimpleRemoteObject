//
//  NSRemoteJsonObject.h
//  NSRemoteJsonObject
//
//  Created by Hal Seki on 2/22/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^NRJFetchCompletionBlock)(NSArray *allRemote, NSError *error);


@interface NRJRemoteJsonObject : NSObject
@property (nonatomic, strong) NSNumber* remoteId;

+(void)fetchAsync:(NRJFetchCompletionBlock)completionBlock;

/*
 // should override on subclass
 */
+(NSString *)representUrl;
+(NSString *)resultKey;
-(void)parseObject:(id)object ForKey:(NSString *)key;



@end
