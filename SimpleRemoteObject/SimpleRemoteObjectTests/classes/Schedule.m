//
//  Schedule.m
//  SimpleRemoteObject
//
//  Created by Haruyuki Seki on 3/15/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import "Schedule.h"

@implementation Schedule

+(NSString *)representUrl{
    return @"schedules.json";
}
+(NSString *)resultKey{
    return @"schedules";
}
@end
