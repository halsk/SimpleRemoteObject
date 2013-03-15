//
//  Post.h
//  SimpleRemoteObject
//
//  Created by Haruyuki Seki on 3/15/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import "SRSimpleRemoteObject.h"

@interface Post : SRSimpleRemoteObject
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSArray *tags;
@property(nonatomic,strong) NSDate *date;

@end
