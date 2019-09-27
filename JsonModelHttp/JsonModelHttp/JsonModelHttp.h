//
//  JsonModelHttp.h
//  JsonModelHttp
//
//  Created by chat on 2018/1/2.
//  Copyright © 2018年 CHAT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface CHTJsonRequestSerializer : AFHTTPRequestSerializer

/**
 Options for writing the request JSON data from Foundation objects. For possible values, see the `NSJSONSerialization` documentation section "NSJSONWritingOptions". `0` by default.
 */
@property (nonatomic, assign) NSJSONWritingOptions writingOptions;

/**
 Creates and returns a JSON serializer with specified reading and writing options.

 @param writingOptions The specified JSON writing options.
 */
+ (instancetype)serializerWithWritingOptions:(NSJSONWritingOptions)writingOptions;

@end

@interface CHTJsonResponseSerializer : AFHTTPResponseSerializer

- (instancetype)init;

/**
 Options for reading the response JSON data and creating the Foundation objects. For possible values, see the `NSJSONSerialization` documentation section "NSJSONReadingOptions". `0` by default.
 */
@property (nonatomic, assign) NSJSONReadingOptions readingOptions;

/**
 Whether to remove keys with `NSNull` values from response JSON. Defaults to `NO`.
 */
@property (nonatomic, assign) BOOL removesKeysWithNullValues;

/**
 Creates and returns a JSON serializer with specified reading and writing options.

 @param readingOptions The specified JSON reading options.
 */
+ (instancetype)serializerWithReadingOptions:(NSJSONReadingOptions)readingOptions;

@end

@interface JsonModelHttp : NSObject
+(void) fire:(NSString*) method url:(NSString*) url param:(NSDictionary*)param headers:(NSDictionary*)headValue body:(id<NSObject>) bodyModel responseModelClass:(Class)modelClass success:(void(^)(id model)) successBlk failure:(void(^)(NSError * error)) failureBlk;
@end













