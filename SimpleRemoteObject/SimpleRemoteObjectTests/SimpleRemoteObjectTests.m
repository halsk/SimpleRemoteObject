
#import "Kiwi.h"
#import "User.h"


#import "NSObject+SRPropertyUtil.h"
#import "SRSimpleRemoteObject.h"
#import "SRRemoteConfig.h"
#import "RootObject.h"
#import "NonArrayObject.h"
#import "NonArrayRootObject.h"
#import "Tag.h"
#import "Echo.h"
#import "Schedule.h"
#import "Activity.h"
#import "Post.h"
#import "PostObj.h"
#import "TimeoutObj.h"
#import "ErrorObj.h"
#import "NoResultKeyErrorCheckObj.h"

SPEC_BEGIN(RemoteConfig)

describe(@"RemoteConfig", ^{
    context(@"read remote object", ^{
        beforeAll(^{
            [SRRemoteConfig defaultConfig].baseurl = @"http://localhost:2000/";
        });
        
        it(@"should have api endpoint", ^{
            [[[SRRemoteConfig defaultConfig].baseurl should] equal:@"http://localhost:2000/"];
        });
        it(@"should enable for SimpleRemoteObject class", ^{
            [[[Tag baseurl] should] equal:@"http://localhost:2000/"];
        });
    });
});

SPEC_END

SPEC_BEGIN(RemoteObject)

describe(@"SimpleRemoteObject", ^{
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

describe(@"SimpleRemoteObject", ^{
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

describe(@"SimpleRemoteObject", ^{
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
            [[expectFutureValue(((RootObject *)[ret objectAtIndex:0]).name) shouldEventually] equal:@"obj"];
        });
    });
});

describe(@"SimpleRemoteObject", ^{
    context(@"read remote echo object", ^{
        beforeAll(^{
            [SRRemoteConfig defaultConfig].baseurl = @"http://localhost:2000/";
        });
        
        it(@"should read remote json with params", ^{
            NSDictionary *params = @{@"hoge":@"fuga"};
            __block NSArray *ret;
            [Echo fetchAsyncWithParams:params async:^(NSArray *allRemote, NSError *error){
                ret = allRemote;
            }];
            [[expectFutureValue(ret) shouldEventually] beNonNil];
            [[expectFutureValue(ret) shouldEventually] haveCountOf:1];
            [[expectFutureValue(((Echo *)[ret objectAtIndex:0]).hoge) shouldEventually] equal:@"fuga"];
        });
    });
});
describe(@"SimpleRemoteObject", ^{
    context(@"read remote Date object", ^{
        beforeAll(^{
            [SRRemoteConfig defaultConfig].baseurl = @"http://localhost:2000/";
        });
        
        it(@"should apply date type data", ^{
            __block NSArray *ret;
            [Schedule fetchAsync:^(NSArray *allRemote, NSError *error){
                ret = allRemote;
            }];
            [[expectFutureValue(ret) shouldEventually] beNonNil];
            [[expectFutureValue(ret) shouldEventually] haveCountOf:2];
            
            NSString *fmt = @"yyyy-MM-dd HH:mm:ssZZZZ";
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:fmt];
            
            [[expectFutureValue(((Schedule *)[ret objectAtIndex:0]).date) shouldEventually] equal:[formatter dateFromString:@"2015-03-15 12:20:01+0900"]];
            [[expectFutureValue(((Schedule *)[ret objectAtIndex:1]).date) shouldEventually] equal:[formatter dateFromString:@"2015-04-15 12:20:01+0000"]];
        });
        it(@"should apply date type data with original format", ^{
            __block NSArray *ret;
            [Activity fetchAsync:^(NSArray *allRemote, NSError *error){
                ret = allRemote;
            }];
            [[expectFutureValue(ret) shouldEventually] beNonNil];
            [[expectFutureValue(ret) shouldEventually] haveCountOf:2];
            
            NSString *fmt = @"MM/dd, yyyy";
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:fmt];
            
            [[expectFutureValue(((Activity *)[ret objectAtIndex:0]).date) shouldEventually] equal:[formatter dateFromString:@"3/5, 2012"]];
            [[expectFutureValue(((Activity *)[ret objectAtIndex:1]).date) shouldEventually] equal:[formatter dateFromString:@"4/20, 2013"]];
        });
    });
});
describe(@"SimpleRemoteObject", ^{
    context(@"read remote post object", ^{
        beforeAll(^{
            [SRRemoteConfig defaultConfig].baseurl = @"http://localhost:2000/";
        });
        
        it(@"should use custom rule for parsing", ^{
            __block NSArray *ret;
            [Post fetchAsync:^(NSArray *allRemote, NSError *error){
                ret = allRemote;
            }];
            [[expectFutureValue(ret) shouldEventually] beNonNil];
            [[expectFutureValue(ret) shouldEventually] haveCountOf:2];
            
            [[expectFutureValue(((Post *)[ret objectAtIndex:0]).title) shouldEventually] equal:@"SimpleReleaseObject is released"];
            [[expectFutureValue(((Post *)[ret objectAtIndex:0]).tags) shouldEventually] haveCountOf:3];
            [[expectFutureValue([((Post *)[ret objectAtIndex:0]).tags objectAtIndex:0]) shouldEventually] equal:@"objective-c"];
        });
    });
});
describe(@"SimpleRemoteObject", ^{
    context(@"read remote post object using POST", ^{
        beforeAll(^{
            [SRRemoteConfig defaultConfig].baseurl = @"http://localhost:2000/";
        });
        
        it(@"should get object using POST method", ^{
            NSDictionary *params = @{@"key":@"value"};
            __block NSArray *ret;
            [PostObj postAsyncWithParams:params async:^(NSArray *allRemote, NSError *error){
                ret = allRemote;
            }];
            [[expectFutureValue(ret) shouldEventually] beNonNil];
            [[expectFutureValue(ret) shouldEventually] haveCountOf:1];
            [[expectFutureValue(((PostObj *)[ret objectAtIndex:0]).key) shouldEventually] equal:@"value"];
        });
    });
});

describe(@"SimpleRemoteObject", ^{
    context(@"read timeout", ^{
        beforeAll(^{
            [SRRemoteConfig defaultConfig].baseurl = @"http://localhost:2000/";
            [SRRemoteConfig defaultConfig].timeout = 2;
        });
        
        it(@"should timeout with specified second", ^{
            __block NSError *ret;
            [TimeoutObj fetchAsync:^(NSArray *allRemote, NSError *error) {
                ret = error;
            }];
            [[expectFutureValue(ret) shouldEventuallyBeforeTimingOutAfter(3.0)] beNonNil];
            [[expectFutureValue(ret.localizedDescription) shouldEventuallyBeforeTimingOutAfter(3.0)] equal:@"The request timed out."];
        });
    });
});

describe(@"SimpleRemoteObject", ^{
    context(@"parse error", ^{
        beforeAll(^{
            [SRRemoteConfig defaultConfig].baseurl = @"http://localhost:2000/";
        });
        
        it(@"should return NSError Object", ^{
            __block NSError *ret;
            [ErrorObj fetchAsync:^(NSArray *allRemote, NSError *error) {
                ret = error;
            }];
            [[expectFutureValue(ret) shouldEventually] beNonNil];
            [[expectFutureValue(theValue(ret.code)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(ret.localizedDescription) shouldEventually] equal:@"Session is invalid."];
        });
    });
});

describe(@"SimpleRemoteObject", ^{
    context(@"set a result key and return no key's value", ^{
        beforeAll(^{
            [SRRemoteConfig defaultConfig].baseurl = @"http://localhost:2000/";
        });
        
        it(@"should not raise error", ^{
            __block NSArray *ret;
            [NoResultKeyErrorCheckObj fetchAsync:^(NSArray *allRemote, NSError *error) {
                ret = allRemote;
            }];
            [[expectFutureValue(ret) shouldEventually] beNonNil];
            [[expectFutureValue(ret) shouldEventually] haveCountOf:1];
            [[expectFutureValue(theValue(((NoResultKeyErrorCheckObj *)[ret objectAtIndex:0]).status)) shouldEventually] equal:theValue(-1)];
            [[expectFutureValue(((NoResultKeyErrorCheckObj *)[ret objectAtIndex:0]).error) shouldEventually] equal:@"Session is invalid."];
        });
    });
});


SPEC_END

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

