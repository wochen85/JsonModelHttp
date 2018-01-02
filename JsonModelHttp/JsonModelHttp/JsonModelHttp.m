//
//  JsonModelHttp.m
//  JsonModelHttp
//
//  Created by chat on 2018/1/2.
//  Copyright © 2018年 CHAT. All rights reserved.
//

#import "JsonModelHttp.h"
#import <MJExtension/MJExtension.h>
#import <AFNetworking/AFNetworking.h>

@implementation JsonModelHttp

#define HTTP_PARAM     @"param"
#define HTTP_BODY      @"body"

+(void) fire:(NSString*) method url:(NSString*) urlStr param:(NSDictionary*)param headers:(NSDictionary*)headValue body:(id<NSObject>) bodyModel responseModelClass:(Class)modelClass success:(void(^)(id data)) successBlk failure:(void(^)(NSError * error)) falilueBlk
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    for (NSString* key in headValue)
    {
        [mgr.requestSerializer setValue:headValue[key] forHTTPHeaderField:key];
    }
    NSDictionary *params = @{HTTP_PARAM : param?:@"",
                             HTTP_BODY : bodyModel};

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
        [mgr GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

        } success:okBlk failure:notOkBlk];
    }
    else if([method isEqualToString:@"POST"])
    {
        [mgr POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

        } success:okBlk failure:notOkBlk];
    }
    else if ([method isEqualToString:@"DELETE"])
    {
        [mgr DELETE:urlStr parameters:params success:okBlk failure:notOkBlk];
    }
    else if ([method isEqualToString:@"PUT"])
    {
        [mgr PUT:urlStr parameters:params success:okBlk failure:notOkBlk];
    }
}

@end
