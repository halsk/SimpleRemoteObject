//
//  NRJRemoteConfig.h
//  NSRemoteJsonObject
//
//  Created by Haruyuki Seki on 3/13/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRJRemoteConfig : NSObject
@property(nonatomic,strong) NSString *baseurl;

+ (NRJRemoteConfig *) defaultConfig;

@end
