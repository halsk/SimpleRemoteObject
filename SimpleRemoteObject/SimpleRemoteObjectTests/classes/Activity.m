//
//  Activity.m
//  SimpleRemoteObject
//
//  Created by Haruyuki Seki on 3/15/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import "Activity.h"

@implementation Activity
+(NSString *)representUrl{
    return @"activities.json";
}
+(NSString *)resultKey{
    return @"activities";
}
-(NSString *)timeformat{
    return @"MM/dd, yyyy";
}
@end
