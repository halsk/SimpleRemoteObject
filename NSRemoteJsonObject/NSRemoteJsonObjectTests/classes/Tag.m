//
//  Tag.m
//  NSRemoteJsonObject
//
//  Created by Haruyuki Seki on 3/13/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import "Tag.h"

@implementation Tag

+(NSString *)representUrl{
    return @"tags.json";
}
+(NSString *)resultKey{
    return @"objects";
}
@end
