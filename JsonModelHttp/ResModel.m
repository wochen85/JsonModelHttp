//
//  ResModel.m
//  JsonModelHttp
//
//  Created by chat on 2018/1/3.
//  Copyright © 2018年 CHAT. All rights reserved.
//

#import "ResModel.h"
#import <YYModel/YYModel.h>

@implementation Json

@end

@implementation Files

@end

@implementation Form

@end

@implementation ResModel
- (NSString *)description
{
    NSDictionary* dic = [self yy_modelToJSONObject];
    NSData* data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    str = [str stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    return str;
}
@end
