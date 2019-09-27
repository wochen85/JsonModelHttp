//
//  MockResModel.h
//  JsonModelHttp
//
//  Created by CHAT on 2019/9/27.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Names :NSObject
@property (nonatomic , copy) NSString              * firstName;
@property (nonatomic , copy) NSString              * lastName;
@property (nonatomic , copy) NSString              * middleInitial;

@end

@interface Address :NSObject
@property (nonatomic , copy) NSString              * state;
@property (nonatomic , copy) NSString              * zipCode;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * addreess;

@end

@interface Regexp :NSObject

@end

@interface Date :NSObject

@end

@interface Login :NSObject
@property (nonatomic , strong) Regexp              * regexp;
@property (nonatomic , copy) NSString              * password;
@property (nonatomic , assign) BOOL              superUser;
@property (nonatomic , copy) NSString              * lastLoginDate;
@property (nonatomic , strong) Date              * date;
@property (nonatomic , copy) NSString              * text;
@property (nonatomic , copy) NSString              * employeeID;

@end

@interface Contact :NSObject
@property (nonatomic , copy) NSString              * beeper;
@property (nonatomic , copy) NSString              * phoneMobile;
@property (nonatomic , copy) NSString              * phoneOffice;
@property (nonatomic , copy) NSString              * fax;
@property (nonatomic , copy) NSString              * email1;
@property (nonatomic , copy) NSString              * phoneHome;

@end

@interface Roles :NSObject
@property (nonatomic , assign) NSInteger              role;

@end

@interface Job :NSObject
@property (nonatomic , assign) NSInteger              jobTitleID;
@property (nonatomic , copy) NSString              * terminationDate;
@property (nonatomic , copy) NSString              * hireDate;
@property (nonatomic , assign) NSInteger              departmentID;

@end

@interface Comment :NSObject
@property (nonatomic , copy) NSString              * PCDATA;

@end

@interface Employee :NSObject
@property (nonatomic , strong) Names              * names;
@property (nonatomic , strong) Address              * address;
@property (nonatomic , assign) NSInteger              companyID;
@property (nonatomic , strong) Login              * login;
@property (nonatomic , strong) Contact              * contact;
@property (nonatomic , copy) NSArray<Roles *>              * roles;
@property (nonatomic , strong) Job              * job;
@property (nonatomic , strong) Comment              * comment;
@property (nonatomic , assign) NSInteger              gid;
@property (nonatomic , assign) NSInteger              defaultActionID;

@end

@interface MockResModel :NSObject
@property (nonatomic , strong) Employee              * employee;

@end

NS_ASSUME_NONNULL_END
