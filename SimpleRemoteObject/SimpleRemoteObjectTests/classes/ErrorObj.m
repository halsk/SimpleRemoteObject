//
//  ErrorObj.m
//  SimpleRemoteObject
//
//  Created by 松澤 太郎 on 2013/06/14.
//  Copyright (c) 2013年 Georepublic. All rights reserved.
//

#import "ErrorObj.h"

@implementation ErrorObj

+(NSString *)representUrl{
    return @"error.json";
}
+(NSString *)resultKey{
    return nil;
}

+(NSError *)parseError:(id)obj
{
    NSString *status_str = [obj valueForKey:@"status"];
    if (status_str) {
        NSInteger status = [status_str integerValue];
        if (status < 0) {
            NSString *descripton = [obj valueForKey:@"error"];
            NSDictionary *userinfo = [NSDictionary dictionaryWithObject:descripton
                                                                 forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"test domain"
                                                 code:1
                                             userInfo:userinfo];
            return error;
        }
    }
    return nil;
}

@end
