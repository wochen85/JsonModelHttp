# JsonModelHttp
整合简化Http+Json的网络调用

## Requirements

* iOS 8.0+
* ARC

## Installation
### CocoaPods

Add the following to your **podfile**
```
pod 'JsonModelHttp'
```
### manual
Add JsonModelHttp folder to your prject
## Usage 

### Example

First, create your Model(ReqModel,GetResModel,ResModel).

You can create your Model using https://github.com/netyouli/WHC_DataModelFactory.

**GET**
```
[JsonModelHttp fire:@"GET" url:@"http://www.httpbin.org/get" param:@{@"param":@"hello"} headers:@{@"Myheader":@"world"} body:nil responseModelClass:[GetResModel class] success:^(GetResModel* model) {
                                    
                                } failure:^(NSError *error) {
                                    
                                }];
```
**POST**
```
[JsonModelHttp fire:@"POST" url:@"http://www.httpbin.org/post" param:nil headers:@{@"Myheader":@"world"} body:reqModel responseModelClass:[ResModel class] success:^(ResModel* model) {
                                    
                                } failure:^(NSError *error) {

                                }];
```
**DELETE**
```
[JsonModelHttp fire:@"DELETE" url:@"http://www.httpbin.org/delete" param:@{@"param":@"hello"} headers:@{@"Myheader":@"world"} body:reqModel responseModelClass:[ResModel class] success:^(ResModel* model) {
                                    
                                } failure:^(NSError *error) {
                                    
                                }];
```
**PUT**
```
[JsonModelHttp fire:@"PUT" url:@"http://www.httpbin.org/put" param:@{@"param":@"hello"} headers:@{@"Myheader":@"world"} body:reqModel responseModelClass:[ResModel class] success:^(ResModel* model) {
                                    
                                } failure:^(NSError *error) {
                                    
                                }];
```
