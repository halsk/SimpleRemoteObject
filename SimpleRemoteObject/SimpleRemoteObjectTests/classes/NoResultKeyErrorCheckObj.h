//
//  NoResultKeyErrorCheckObj.h
//  SimpleRemoteObject
//
//  Created by 松澤 太郎 on 2013/06/14.
//  Copyright (c) 2013年 Georepublic. All rights reserved.
//

#import "SRSimpleRemoteObject.h"

@interface NoResultKeyErrorCheckObj : SRSimpleRemoteObject

@property(nonatomic) NSInteger status;
@property(nonatomic, strong) NSString *error;

@end
