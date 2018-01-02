//
//  JsonModelHttp.h
//  JsonModelHttp
//
//  Created by chat on 2018/1/2.
//  Copyright © 2018年 CHAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonModelHttp : NSObject
+(void) fire:(NSString*) method url:(NSString*) urlStr param:(NSDictionary*)param headers:(NSDictionary*)headValue body:(id<NSObject>) bodyModel responseModelClass:(Class)modelClass success:(void(^)(id data)) successBlk failure:(void(^)(NSError * error)) falilueBlk;
@end
