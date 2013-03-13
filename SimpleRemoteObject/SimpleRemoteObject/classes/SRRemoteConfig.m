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


+ (SRRemoteConfig *) defaultConfig
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SRRemoteConfig  *newConfig = [[SRRemoteConfig  alloc] init];
                      [newConfig useAsDefault];
                  });
    
	return defaultConfig;
}
- (void) useAsDefault
{
    defaultConfig = self;
}

@end
