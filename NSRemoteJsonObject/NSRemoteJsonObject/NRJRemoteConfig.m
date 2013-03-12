//
//  NRJRemoteConfig.m
//  NSRemoteJsonObject
//
//  Created by Haruyuki Seki on 3/13/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import "NRJRemoteConfig.h"

@implementation NRJRemoteConfig

static NRJRemoteConfig *defaultConfig = nil;


+ (NRJRemoteConfig *) defaultConfig
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      NRJRemoteConfig  *newConfig = [[NRJRemoteConfig  alloc] init];
                      [newConfig useAsDefault];
                  });
    
	return defaultConfig;
}
- (void) useAsDefault
{
    defaultConfig = self;
}

@end
