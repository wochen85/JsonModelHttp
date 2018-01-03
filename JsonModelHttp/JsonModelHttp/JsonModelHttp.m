//
//  JsonModelHttp.m
//  JsonModelHttp
//
//  Created by chat on 2018/1/2.
//  Copyright © 2018年 CHAT. All rights reserved.
//

#import "JsonModelHttp.h"
#import <MJExtension/MJExtension.h>

#define HTTP_PARAM     @"param"
#define HTTP_BODY      @"body"

#pragma mark - Temp
static NSError * AFErrorWithUnderlyingError(NSError *error, NSError *underlyingError) {
    if (!error) {
        return underlyingError;
    }

    if (!underlyingError || error.userInfo[NSUnderlyingErrorKey]) {
        return error;
    }

    NSMutableDictionary *mutableUserInfo = [error.userInfo mutableCopy];
    mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;

    return [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:mutableUserInfo];
}

static BOOL AFErrorOrUnderlyingErrorHasCodeInDomain(NSError *error, NSInteger code, NSString *domain) {
    if ([error.domain isEqualToString:domain] && error.code == code) {
        return YES;
    } else if (error.userInfo[NSUnderlyingErrorKey]) {
        return AFErrorOrUnderlyingErrorHasCodeInDomain(error.userInfo[NSUnderlyingErrorKey], code, domain);
    }

    return NO;
}

static id AFJSONObjectByRemovingKeysWithNullValues(id JSONObject, NSJSONReadingOptions readingOptions) {
    if ([JSONObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[(NSArray *)JSONObject count]];
        for (id value in (NSArray *)JSONObject) {
            [mutableArray addObject:AFJSONObjectByRemovingKeysWithNullValues(value, readingOptions)];
        }

        return (readingOptions & NSJSONReadingMutableContainers) ? mutableArray : [NSArray arrayWithArray:mutableArray];
    } else if ([JSONObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:JSONObject];
        for (id <NSCopying> key in [(NSDictionary *)JSONObject allKeys]) {
            id value = (NSDictionary *)JSONObject[key];
            if (!value || [value isEqual:[NSNull null]]) {
                [mutableDictionary removeObjectForKey:key];
            } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                mutableDictionary[key] = AFJSONObjectByRemovingKeysWithNullValues(value, readingOptions);
            }
        }

        return (readingOptions & NSJSONReadingMutableContainers) ? mutableDictionary : [NSDictionary dictionaryWithDictionary:mutableDictionary];
    }

    return JSONObject;
}

@implementation CHTJsonRequestSerializer

+ (instancetype)serializer {
    return [self serializerWithWritingOptions:(NSJSONWritingOptions)0];
}

+ (instancetype)serializerWithWritingOptions:(NSJSONWritingOptions)writingOptions
{
    CHTJsonRequestSerializer *serializer = [[self alloc] init];
    serializer.writingOptions = writingOptions;

    return serializer;
}

#pragma mark - AFURLRequestSerialization

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(request);
    NSParameterAssert([parameters isKindOfClass:[NSDictionary class]]);

    NSMutableURLRequest *mutableRequest = [request mutableCopy];

    [self.HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        if (![request valueForHTTPHeaderField:field]) {
            [mutableRequest setValue:value forHTTPHeaderField:field];
        }
    }];
    [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    if (parameters) {

        NSDictionary* paraDic = (NSDictionary*) parameters;
        NSDictionary* realPara = paraDic[HTTP_PARAM];
        NSObject* bodyModel = paraDic[HTTP_BODY];

        NSData* realBody = nil;
        if (![bodyModel isKindOfClass:[NSString class]])
        {
            NSMutableDictionary* bodyDic = bodyModel.mj_keyValues;
            if (bodyDic && [bodyDic isKindOfClass:[NSMutableDictionary class]] && bodyDic.allKeys.count)
            {
                realBody = [NSJSONSerialization dataWithJSONObject:bodyDic options:NSJSONWritingPrettyPrinted error:error];
            }
        }

        NSString* query = AFQueryStringFromParameters(realPara);
        if (query && query.length > 0) {
            NSURL* tmp = mutableRequest.URL;
            mutableRequest.URL = [NSURL URLWithString:[[mutableRequest.URL absoluteString] stringByAppendingFormat:mutableRequest.URL.query ? @"&%@" : @"?%@", query]];
            tmp = mutableRequest.URL;
            NSLog(@"");
        }

        if (realBody)
        {
            [mutableRequest setHTTPBody:realBody];
        }
    }

    return mutableRequest;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (!self) {
        return nil;
    }

    self.writingOptions = [[decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(writingOptions))] unsignedIntegerValue];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];

    [coder encodeInteger:self.writingOptions forKey:NSStringFromSelector(@selector(writingOptions))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    CHTJsonRequestSerializer *serializer = [super copyWithZone:zone];
    serializer.writingOptions = self.writingOptions;

    return serializer;
}

@end

@implementation CHTJsonResponseSerializer

+ (instancetype)serializer {
    return [self serializerWithReadingOptions:(NSJSONReadingOptions)0];
}

+ (instancetype)serializerWithReadingOptions:(NSJSONReadingOptions)readingOptions {
    CHTJsonResponseSerializer *serializer = [[self alloc] init];
    serializer.readingOptions = readingOptions;

    return serializer;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", nil];

    return self;
}

#pragma mark - AFURLResponseSerialization

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error])
    {
        if (!error || AFErrorOrUnderlyingErrorHasCodeInDomain(*error, NSURLErrorCannotDecodeContentData, AFURLResponseSerializationErrorDomain))
        {
            return nil;
        }
    }

    id responseObject = nil;
    NSError *serializationError = nil;
    BOOL isSpace = [data isEqualToData:[NSData dataWithBytes:" " length:1]];
    if (data.length > 0 && !isSpace)
    {
        responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:error];
    }
    else
    {
        return nil;
    }

    if (self.removesKeysWithNullValues && responseObject) {
        responseObject = AFJSONObjectByRemovingKeysWithNullValues(responseObject, self.readingOptions);
    }

    if (error)
    {
        *error = AFErrorWithUnderlyingError(serializationError, *error);
    }

    return responseObject;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (!self) {
        return nil;
    }

    self.readingOptions = [[decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(readingOptions))] unsignedIntegerValue];
    self.removesKeysWithNullValues = [[decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(removesKeysWithNullValues))] boolValue];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];

    [coder encodeObject:@(self.readingOptions) forKey:NSStringFromSelector(@selector(readingOptions))];
    [coder encodeObject:@(self.removesKeysWithNullValues) forKey:NSStringFromSelector(@selector(removesKeysWithNullValues))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    CHTJsonResponseSerializer *serializer = [[[self class] allocWithZone:zone] init];
    serializer.readingOptions = self.readingOptions;
    serializer.removesKeysWithNullValues = self.removesKeysWithNullValues;

    return serializer;
}

@end

@implementation JsonModelHttp

+(void) fire:(NSString*) method url:(NSString*) url param:(NSDictionary*)param headers:(NSDictionary*)headValue body:(id<NSObject>) bodyModel responseModelClass:(Class)modelClass success:(void(^)(id model)) successBlk failure:(void(^)(NSError * error)) falilueBlk
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer = [CHTJsonRequestSerializer serializer];
    mgr.responseSerializer = [CHTJsonResponseSerializer serializer];
    for (NSString* key in headValue)
    {
        [mgr.requestSerializer setValue:headValue[key] forHTTPHeaderField:key];
    }
    NSDictionary *params = @{HTTP_PARAM : param?:@{},
                             HTTP_BODY : bodyModel?:@""};

    void (^okBlk)(NSURLSessionDataTask * _Nonnull, id _Nullable) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlk)
        {
            NSDictionary* responseDic = (NSDictionary*) responseObject;
            if (modelClass && [responseDic isKindOfClass:[NSDictionary class]])
            {
                id model = [modelClass mj_objectWithKeyValues:responseDic];
                successBlk(model);
            }
            else
            {
                successBlk(responseDic);
            }
        }
    };

    void (^notOkBlk)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (falilueBlk)
        {
            falilueBlk(error);
        }
    };

    method = method.uppercaseString;
    if ([method isEqualToString:@"GET"])
    {
        [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

        } success:okBlk failure:notOkBlk];
    }
    else if([method isEqualToString:@"POST"])
    {
        [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

        } success:okBlk failure:notOkBlk];
    }
    else if ([method isEqualToString:@"DELETE"])
    {
        [mgr DELETE:url parameters:params success:okBlk failure:notOkBlk];
    }
    else if ([method isEqualToString:@"PUT"])
    {
        [mgr PUT:url parameters:params success:okBlk failure:notOkBlk];
    }
}

@end
