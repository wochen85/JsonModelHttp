//
//  GetResModel.m
//  JsonModelHttp
//
//  Created by chat on 2018/1/2.
//  Copyright © 2018年 CHAT. All rights reserved.
//

#import "GetResModel.h"
#import <MJExtension/MJExtension.h>

@implementation Args

@end

@implementation Headers
+(void) load
{
    [Headers mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"AcceptEncoding":@"Accept-Encoding",
                 @"ContentType":@"Content-Type",
                 @"UserAgent":@"User-Agent",
                 @"AcceptLanguage":@"Accept-Language",
                 };
    }];
}
@end

@implementation GetResModel
- (NSString *)description
{
    NSDictionary* dic = self.mj_keyValues;
    NSData* data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    str = [str stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    return str;
}
@end
