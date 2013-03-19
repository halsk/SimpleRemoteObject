//
//  NRJRemoteConfig.m
//  NSRemoteJsonObject
//
//  Created by Haruyuki Seki on 3/13/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import "SRRemoteConfig.h"

@implementation SRRemoteConfig

static SRRemoteConfig *defaultConfig = nil;

static int TIMEOUT_DEFAULT = 30;

+ (SRRemoteConfig *) defaultConfig
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SRRemoteConfig  *newConfig = [[SRRemoteConfig  alloc] init];
                      newConfig.timeout = TIMEOUT_DEFAULT;
                      [newConfig useAsDefault];
                  });
    
	return defaultConfig;
}
- (void) useAsDefault
{
    defaultConfig = self;
}

@end
