//
//  GetResModel.h
//  JsonModelHttp
//
//  Created by chat on 2018/1/2.
//  Copyright © 2018年 CHAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Args :NSObject
@property (nonatomic , copy) NSString              * param;

@end

@interface Headers :NSObject
@property (nonatomic , copy) NSString              * Accept;
@property (nonatomic , copy) NSString              * AcceptEncoding;
@property (nonatomic , copy) NSString              * Connection;
@property (nonatomic , copy) NSString              * ContentType;
@property (nonatomic , copy) NSString              * Host;
@property (nonatomic , copy) NSString              * UserAgent;
@property (nonatomic , copy) NSString              * AcceptLanguage;
@property (nonatomic , copy) NSString              * Myheader;

@end

@interface GetResModel :NSObject
@property (nonatomic , strong) Args              * args;
@property (nonatomic , strong) Headers              * headers;
@property (nonatomic , copy) NSString              * origin;
@property (nonatomic , copy) NSString              * url;

@end

