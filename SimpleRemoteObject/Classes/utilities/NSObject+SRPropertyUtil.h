//
//  NSObject+NRJPropertyUtil.h
//  NSRemoteJsonObject
//
//  Created by Hal Seki on 3/12/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "objc/runtime.h"

@interface NSObject(SRPropertyUtil)
+ (NSString *)getPropertyTypeNSString:(objc_property_t)property;
+ (NSDictionary *)properties;

@end
