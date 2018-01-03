//
//  ResModel.h
//  JsonModelHttp
//
//  Created by chat on 2018/1/3.
//  Copyright © 2018年 CHAT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetResModel.h"

@interface Json :NSObject
@property (nonatomic , copy) NSString              * firstName;
@property (nonatomic , copy) NSString              * lastName;

@end

@interface Files :NSObject

@end

@interface Form :NSObject

@end

@interface ResModel :NSObject
@property (nonatomic , strong) Json              * json;
@property (nonatomic , copy) NSString              * origin;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * data;
@property (nonatomic , strong) Headers              * headers;
@property (nonatomic , strong) Args              * args;
@property (nonatomic , strong) Files              * files;
@property (nonatomic , strong) Form              * form;

@end
