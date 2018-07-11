//
//  GetResModel.m
//  JsonModelHttp
//
//  Created by chat on 2018/1/2.
//  Copyright © 2018年 CHAT. All rights reserved.
//

#import "GetResModel.h"
#import <YYModel/YYModel.h>

@implementation Args

@end

@implementation Headers

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"AcceptEncoding":@"Accept-Encoding",
             @"ContentType":@"Content-Type",
             @"UserAgent":@"User-Agent",
             @"AcceptLanguage":@"Accept-Language",
             };
}

@end

@implementation GetResModel
- (NSString *)description
{
    NSDictionary* dic = [self yy_modelToJSONObject];
    NSData* data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    str = [str stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    return str;
}
@end
