//
//  MockResModel.m
//  JsonModelHttp
//
//  Created by CHAT on 2019/9/27.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import "MockResModel.h"
#import <YYModel/YYModel.h>

@implementation Names

@end
@implementation Address

@end
@implementation Regexp

@end
@implementation Date

@end
@implementation Login

@end
@implementation Contact

@end
@implementation Roles

@end
@implementation Job

@end
@implementation Comment

@end
@implementation Employee

@end
@implementation MockResModel
- (NSString *)description
{
    NSDictionary* dic = [self yy_modelToJSONObject];
    NSData* data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    str = [str stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    return str;
}
@end
