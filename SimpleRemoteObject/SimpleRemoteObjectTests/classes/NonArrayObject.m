//
//  NonArrayObject.m
//  SimpleRemoteObject
//
//  Created by Haruyuki Seki on 3/13/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import "NonArrayObject.h"

@implementation NonArrayObject


+(NSString *)representUrl{
    return @"nonarray.json";
}
+(NSString *)resultKey{
    return @"object";
}
@end
