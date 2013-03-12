//
//  NSRemoteJsonObject.m
//  NSRemoteJsonObject
//
//  Created by Hal Seki on 2/22/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import "NRJRemoteJsonObject.h"
#import "NRJRemoteConfig.h"
#import "AFNetworking.h"
#import "NSObject+NRJPropertyUtil.h"


@implementation NRJRemoteJsonObject

/**
 // read data from specified URI
 */
+(void)fetchAsync:(NRJFetchCompletionBlock)completionBlock{
    
    NSString *strurl = [NSString stringWithFormat:@"%@%@", [NRJRemoteConfig defaultConfig].baseurl, [[self class] performSelector:@selector(representUrl)]];
    [[self class] performSelector:@selector(fetchURL:async:) withObject:strurl withObject:completionBlock];
}
+(void)fetchURL:(NSString *)strurl async:(NRJFetchCompletionBlock)completionBlock{
    NSURL *url = [NSURL URLWithString:strurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"App.net Global Stream: %@", JSON);
        NSArray *ret = [[self class] parseJSONArray:[JSON valueForKeyPath:[[self class] performSelector:@selector(resultKey)]]];
        completionBlock(ret,nil);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"App.net Error: %@", [error localizedDescription]);
        completionBlock(nil,error);
    }];
    [operation start];
    
}
#pragma mark -
#pragma mark internal method
/**
 // parse JSONArray and create class instance
 */
+(NSArray *)parseJSONArray:(NSArray *)array{
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:[array count]];
    for (NSDictionary *dict in array){
        id obj = [[[self class] alloc] init];
        [obj performSelector:@selector(setPropertiesUsingRemoteDictionary:) withObject:dict];
        [ret addObject:obj];
    }
    return [[NSArray alloc] initWithArray:ret];
}
- (void) setPropertiesUsingRemoteDictionary:(NSDictionary *)dict
{
    if ([dict objectForKey:@"id"]){
        self.remoteId = [dict objectForKey:@"id"];
    }
    NSDictionary *props = [[self class] properties];
    for (NSString *key in [props allKeys]){
        NSLog(@"key:%@", key);
        [self parseObject:[dict objectForKey:key] ForKey:key];
    }
    
}

#pragma mark -
#pragma mark below methods shoul be doverride in a subclass
+(NSString *)representUrl{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}
+(NSString *)resultKey{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}
// optional
-(void)parseObject:(id)object ForKey:(NSString *)key{
    if (object){
        [self setValue:object forKey:key];
    }
}

@end
