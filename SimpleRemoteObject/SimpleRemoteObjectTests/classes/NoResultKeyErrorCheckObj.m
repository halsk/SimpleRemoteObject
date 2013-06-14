//
//  NoResultKeyErrorCheckObj.m
//  SimpleRemoteObject
//
//  Created by 松澤 太郎 on 2013/06/14.
//  Copyright (c) 2013年 Georepublic. All rights reserved.
//

#import "NoResultKeyErrorCheckObj.h"

@implementation NoResultKeyErrorCheckObj

+(NSString *)representUrl{
    return @"error.json";
}
+(NSString *)resultKey{
    return @"results";
}

@end
