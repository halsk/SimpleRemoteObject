//
//  NoResultKeyErrorCheckObj.m
//  SimpleRemoteObject
//
//  Created by Taro Matsuzawa on 2013/06/14.
//  Copyright (c) 2013 Georepublic. All rights reserved.
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
