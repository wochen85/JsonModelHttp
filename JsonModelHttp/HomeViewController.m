//
//  HomeViewController.m
//  JsonModelHttp
//
//  Created by chat on 2018/1/2.
//  Copyright © 2018年 CHAT. All rights reserved.
//

#import "HomeViewController.h"
#import "JsonModelHttp/JsonModelHttp.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "GetResModel.h"

@interface HomeViewController ()
@property(nonatomic,strong)NSArray<NSDictionary*>* fuckData;
@end

@implementation HomeViewController

-(NSArray<NSDictionary*>*) fuckData
{
    if (!_fuckData)
    {
        _fuckData = @[@{@"GET":
                            ^{
                                [SVProgressHUD showWithStatus:@"客官请稍候"];
                                [JsonModelHttp fire:@"GET" url:@"http://www.httpbin.org/get" param:@{@"param":@"hello"} headers:@{@"Myheader":@"world"} body:nil responseModelClass:[GetResModel class] success:^(GetResModel* model) {
                                    [SVProgressHUD dismiss];
                                } failure:^(NSError *error) {
                                    [SVProgressHUD dismiss];
                                }];
                            }},
                      @{@"POST":
                            ^{
                                [SVProgressHUD showWithStatus:@"客官请稍候"];
                                AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
                                [mgr POST:@"http://www.httpbin.org/post" parameters:@[@"aa",@"bb"] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    [SVProgressHUD dismiss];
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    [SVProgressHUD dismiss];
                                }];
                            }},
                      @{@"DELETE":
                            ^{

                            }},
                      @{@"PUT":
                            ^{

                            }}
                      ];
    }
    return _fuckData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fuckData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fuck"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fuck"];
    }
    cell.textLabel.text = self.fuckData[indexPath.row].allKeys[0];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    void(^task)(void) = self.fuckData[indexPath.row].allValues[0];
    task();
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
