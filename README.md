SimpleRemoteObject
--------

SimpleRemoteObject is a simple Objectie-C library that can create your classes' instance from server-side JSON text.
I created this library inspired by NSRails framework.
NSRails is awesome framework but it is suitable for Active-Record.
Since I had to read data from NON-RAILS server, I made own library.


For example, you can get User class instance with below code.

```objc
[User fetchAsync:^(NSArray *allRemote, NSError *error) {
    if (error){
        //Do error handling
    }else{
        for (User* user in allRemote){
            NSLog(@"my name is:%@",user.name);
        }
    }
}];
```

Features
--------

* Create object instance from server side JSON text
* Server side JSON text does not need to well-structured with local objects.

CAUTION
--------

Currently this library is providing just simple usecase.
Feel free to add your own usecases and contribute! ;)

Dependencies
--------

* iOS 5.1+
* AFNetworking


Getting started
--------

1. Install

 SimpleRemoteObject is supporting cocoapods.
 Please add below line to your Podfile and run `pod install`.

 ```
 pod 'SimpleRemoteObject'
 ```

2. Make an Objective-C class and have it subclass **SRSimpleRemoteObject** and set properties.

 For example, if the server return below JSON for `http://your_server/users.json`:

 ```javascript
 {
   meta: {
     limit: 20,
     next: null,
     offset: 0,
     previous: null,
     total_count: 3
   },
   objects: [
     {
       id: 2,
       name: "Daniel",
       email: "daniel@example.com",
       age: 25
     },
     {
       id: 2,
       name: "Mario",
       email: "mario@example.com",
       age: 30
     },
     {
       id: 3,
       name: "Hal",
       email: "hal@example.com",
       age: 32
     }
   ]
 }

 ```

 You can make an object like this.

 ```objc:User.h
 #import "SRSimpleRemoteObject.h"
 @interface User : SRSimpleRemoteObject
 @property(nonatomic,retain) NSString *name;
 @property(nonatomic,retain) NSString *email;
 @property(nonatomic) int age;
 @end
 ```

3. Implement representUrl and resultKey methods

 ```objc:User.m
 #import "User.h"

 @implementation Tag
 +(NSString *)representUrl{
     return @"users.json";
 }
 +(NSString *)resultKey{
     return @"objects"; // key of target JSON object
 }
 @end
 ```

4. Set base url of server API on somewhere.

 ```objc:YouAppDelegate.m
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
 {
     [SRRemoteConfig defaultConfig].baseurl = SERVER_URL;

     // Override point for customization after application launch.
     return YES;
 }
 ```


5. Retrieve data

 ```objc
 [User fetchAsync:^(NSArray *allRemote, NSError *error) {
     if (error){
         //Do error handling
     }else{
         for (User* user in allRemote){
             NSLog(@"my name is:%@",user.name);
         }
     }
 }];

 ```

Documentation
-------

Sorry, not provided yet.

TODOs
-------

* Imprement CRUD support
* Support CoreData

Contribution
-------

* Bug report: please make a ticket here.
* Pull request: of course, you are welcome!

License
-------
SimpleRemoteObject is available under the MIT license. See the LICENSE file for more info.

Credits
-------

Version 0.0.4

SimpleRemoteObject is written and maintained by Hal Seki. I've learned and inspired by NSRails project, many thanks there!

