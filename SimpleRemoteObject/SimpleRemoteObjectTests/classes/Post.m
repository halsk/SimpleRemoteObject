//
//  Post.m
//  SimpleRemoteObject
//
//  Created by Haruyuki Seki on 3/15/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import "Post.h"

@implementation Post
+(NSString *)representUrl{
    return @"posts.json";
}
+(NSString *)resultKey{
    return @"posts";
}

-(void)parseObject:(id)object ForKey:(NSString *)key{
    if ([key isEqual:@"tags"]){
        self.tags = [((NSString *)object) componentsSeparatedByString:@","];
    }else{
        [super parseObject:object ForKey:key];
    }
}

@end
