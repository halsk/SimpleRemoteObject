
#import "Kiwi.h"
#import "User.h"


#import "NSObject+SRPropertyUtil.h"
#import "SRSimpleRemoteObject.h"
#import "SRRemoteConfig.h"
#import "RootObject.h"
#import "NonArrayObject.h"
#import "NonArrayRootObject.h"
#import "Tag.h"


SPEC_BEGIN(PropertyUtil)

describe(@"PropertyUtil", ^{
    it(@"should have 3 properties", ^{
        [[[User properties] should] haveCountOf:3];
    });
    it(@"should have name , mail and age", ^{
        [[[[User properties] allKeys] should] contain:@"name"];
        [[[[User properties] allKeys] should] contain:@"mail"];
        [[[[User properties] allKeys] should] contain:@"age"];
    });
    it(@"should return object type ", ^{
        [[[[User properties] objectForKey:@"name"] should] equal:@"NSString"];
        [[[[User properties] objectForKey:@"mail"] should] equal:@"NSString"];
        [[[[User properties] objectForKey:@"age"] should] equal:@"i"];
    });
});

SPEC_END

SPEC_BEGIN(RemoteConfig)

describe(@"RemoteConfig", ^{
    context(@"read remote object", ^{
        beforeAll(^{
            [SRRemoteConfig defaultConfig].baseurl = @"http://localhost:2000/";
        });
        
        it(@"should have api endpoint", ^{
            [[[SRRemoteConfig defaultConfig].baseurl should] equal:@"http://localhost:2000/"];
        });
    });
});

SPEC_END

SPEC_BEGIN(RemoteObject)

describe(@"RemoteConfig", ^{
    context(@"read remote tag object", ^{
        beforeAll(^{
            [SRRemoteConfig defaultConfig].baseurl = @"http://localhost:2000/";
        });
        
        it(@"should read remote json", ^{
            __block NSArray *ret;
            [Tag fetchAsync:^(NSArray *allRemote, NSError *error) {
                ret = allRemote;
            }];
            [[expectFutureValue(ret) shouldEventually] beNonNil];
            [[expectFutureValue(ret) shouldEventually] haveCountOf:3];
            [[expectFutureValue(((Tag *)[ret objectAtIndex:0]).name) shouldEventually] equal:@"カフェ"];
            [[expectFutureValue(((Tag *)[ret objectAtIndex:1]).name) shouldEventually] equal:@"ハッカソン"];
            [[expectFutureValue(((Tag *)[ret objectAtIndex:2]).name) shouldEventually] equal:@"破滅"];
            [[expectFutureValue(((Tag *)[ret objectAtIndex:0]).resource_uri) shouldEventually] equal:@"/api/tag/%E3%82%AB%E3%83%95%E3%82%A7"];
            [[expectFutureValue(((Tag *)[ret objectAtIndex:0]).slug) shouldEventually] equal:@"カフェ"];
            [[expectFutureValue(((Tag *)[ret objectAtIndex:0]).remoteId) shouldEventually] equal:theValue(2)];
        });
    });
});

describe(@"RemoteConfig", ^{
    context(@"read non-array object", ^{
        beforeAll(^{
            [SRRemoteConfig defaultConfig].baseurl = @"http://localhost:2000/";
        });
        
        it(@"should read non-array object", ^{
            __block NSArray *ret;
            [NonArrayObject fetchAsync:^(NSArray *allRemote, NSError *error) {
                ret = allRemote;
            }];
            [[expectFutureValue(ret) shouldEventually] beNonNil];
            [[expectFutureValue(ret) shouldEventually] haveCountOf:1];
            [[expectFutureValue(((RootObject *)[ret objectAtIndex:0]).name) shouldEventually] equal:@"obj1"];
        });
    });
});

describe(@"RemoteConfig", ^{
    context(@"read root object", ^{
        beforeAll(^{
            [SRRemoteConfig defaultConfig].baseurl = @"http://localhost:2000/";
        });
        
        it(@"should read root object", ^{
            __block NSArray *ret;
            [RootObject fetchAsync:^(NSArray *allRemote, NSError *error) {
                ret = allRemote;
            }];
            [[expectFutureValue(ret) shouldEventually] beNonNil];
            [[expectFutureValue(ret) shouldEventually] haveCountOf:3];
            [[expectFutureValue(((RootObject *)[ret objectAtIndex:0]).name) shouldEventually] equal:@"obj1"];
            [[expectFutureValue(((RootObject *)[ret objectAtIndex:1]).name) shouldEventually] equal:@"obj2"];
        });
        it(@"should read root object (and not array)", ^{
            __block NSArray *ret;
            [NonArrayRootObject fetchAsync:^(NSArray *allRemote, NSError *error) {
                ret = allRemote;
            }];
            [[expectFutureValue(ret) shouldEventually] beNonNil];
            [[expectFutureValue(ret) shouldEventually] haveCountOf:1];
            [[expectFutureValue(((RootObject *)[ret objectAtIndex:0]).name) shouldEventually] equal:@"obj1"];
        });
    });
});

describe(@"RemoteConfig", ^{
    context(@"read remote echo object", ^{
        beforeAll(^{
            [SRRemoteConfig defaultConfig].baseurl = @"http://localhost:2000/";
        });
        
        it(@"should read remote json with params", ^{
            
        });
    });
});
SPEC_END