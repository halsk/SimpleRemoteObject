## 0.0.6

###### Features

- Added changing http timeout interval


## 0.0.5

###### Features

- Support POST method

 ```objc
 +(void)postAsyncWithParams:(NSDictionary *)params async:(SRFetchCompletionBlock)completionBlock;
 ```

- Added custome rule of property matching

 ```objc
 -(void)parseObject:(id)object ForKey:(NSString *)key;
 ```

