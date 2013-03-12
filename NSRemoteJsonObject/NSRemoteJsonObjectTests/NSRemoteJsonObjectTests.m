#import "Kiwi.h"
#import "User.h"
#import "NSObject+NRJPropertyUtil.h"

SPEC_BEGIN(PropertyUtil)

describe(@"PropertyUtil", ^{
    it(@"should have 3 properties", ^{
        [[theValue([[User properties] count]) should] equal:theValue(3)];
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
SPEC_BEGIN(MathSpec)

describe(@"Math", ^{
    it(@"is pretty cool", ^{
        NSUInteger a = 16;
        NSUInteger b = 26;
        [[theValue(a + b) should] equal:theValue(42)];
    });
});

SPEC_END