//
//  NRJPropertyUtil.m
//  NSRemoteJsonObject
//
//  Created by Hal Seki on 3/12/13.
//  Copyright (c) 2013 Georepublic. All rights reserved.
//

#import "NSObject+SRPropertyUtil.h"

@implementation NSObject(SRPropertyUtil)

+ (NSString *)getPropertyTypeNSString:(objc_property_t)property
{
    const char *attributes = property_getAttributes(property);
    printf("attributes=%s\n", attributes);
    NSString *state = [[NSString alloc] initWithData:[NSData dataWithBytes:attributes length:strlen(attributes)] encoding:NSASCIIStringEncoding];
    NSArray *attrs = [state componentsSeparatedByString:@","];
    for (NSString *attribute in attrs) {
        if ([attribute isEqualToString:@"T@"]) {
            // it's an ObjC id type:
            return @"id";
        } else if ([attribute hasPrefix:@"T@"]) {
            // it's another ObjC object type:
            return [attribute substringWithRange:NSMakeRange(3, [attribute length] - 4)];
        } else if ([attribute hasPrefix:@"T"]) {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            return [attribute substringWithRange:NSMakeRange(1, [attribute length] - 1)];
        }
    }
    return @"";
}

+ (NSDictionary *)properties
{
    NSMutableDictionary *results;
    if ([self superclass] != [NSObject class]) {
        results = (NSMutableDictionary *)[[self superclass] properties];
    } else {
        results = [NSMutableDictionary dictionary];
    }
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(self, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [self getPropertyTypeNSString:property];
            [results setObject:propertyType forKey:propertyName];
        }
    }
    free(properties);
    
    return results;
}


@end
