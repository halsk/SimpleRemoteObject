//
//  Tag.h
//  NSRemoteJsonObject
//
//  Created by Haruyuki Seki on 3/13/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import "SRSimpleRemoteObject.h"

@interface Tag : SRSimpleRemoteObject
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *resource_uri;
@property(nonatomic,retain) NSString *slug;

@end
