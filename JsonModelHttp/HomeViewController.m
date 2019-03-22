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
#import "ReqModel.h"
#import "ResModel.h"

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
                                [SVProgressHUD showWithStatus:@"请稍候..."];
                                [JsonModelHttp fire:@"GET" url:@"http://www.httpbin.org/get" param:@{@"param":@"hello"} headers:@{@"Myheader":@"world"} body:nil responseModelClass:[GetResModel class] success:^(GetResModel* model) {
                                    [SVProgressHUD dismiss];

                                    UIAlertController* alc = [UIAlertController alertControllerWithTitle:@"成功" message:model.description preferredStyle:UIAlertControllerStyleAlert];
                                    [alc addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                                    [self presentViewController:alc animated:YES completion:nil];
                                } failure:^(NSError *error) {
                                    [SVProgressHUD dismiss];
                                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                                    [SVProgressHUD dismissWithDelay:1.0];
                                }];
                            }},
                      @{@"POST":
                            ^{
                                ReqModel* reqModel = [ReqModel new];
                                reqModel.firstName = @"Chen";
                                reqModel.lastName = @"Haitao";
                                [SVProgressHUD showWithStatus:@"请稍候..."];
                                [JsonModelHttp fire:@"POST" url:@"http://www.httpbin.org/post" param:nil headers:@{@"Myheader":@"world"} body:reqModel responseModelClass:[ResModel class] success:^(ResModel* model) {
                                    [SVProgressHUD dismiss];

                                    UIAlertController* alc = [UIAlertController alertControllerWithTitle:@"成功" message:model.description preferredStyle:UIAlertControllerStyleAlert];
                                    [alc addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                                    [self presentViewController:alc animated:YES completion:nil];
                                } failure:^(NSError *error) {
                                    [SVProgressHUD dismiss];
                                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                                    [SVProgressHUD dismissWithDelay:1.0];
                                }];
                            }},
                      @{@"DELETE":
                            ^{
                                ReqModel* reqModel = [ReqModel new];
                                reqModel.firstName = @"Chen";
                                reqModel.lastName = @"Haitao";
                                [SVProgressHUD showWithStatus:@"请稍候..."];
                                [JsonModelHttp fire:@"DELETE" url:@"http://www.httpbin.org/delete" param:@{@"param":@"hello"} headers:@{@"Myheader":@"world"} body:reqModel responseModelClass:[ResModel class] success:^(ResModel* model) {
                                    [SVProgressHUD dismiss];

                                    UIAlertController* alc = [UIAlertController alertControllerWithTitle:@"成功" message:model.description preferredStyle:UIAlertControllerStyleAlert];
                                    [alc addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                                    [self presentViewController:alc animated:YES completion:nil];
                                } failure:^(NSError *error) {
                                    [SVProgressHUD dismiss];
                                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                                    [SVProgressHUD dismissWithDelay:1.0];
                                }];
                            }},
                      @{@"PUT":
                            ^{
                                ReqModel* reqModel = [ReqModel new];
                                reqModel.firstName = @"Chen";
                                reqModel.lastName = @"Haitao";
                                [SVProgressHUD showWithStatus:@"请稍候..."];
                                [JsonModelHttp fire:@"PUT" url:@"http://www.httpbin.org/put" param:@{@"param":@"hello"} headers:@{@"Myheader":@"world"} body:reqModel responseModelClass:[ResModel class] success:^(ResModel* model) {
                                    [SVProgressHUD dismiss];

                                    UIAlertController* alc = [UIAlertController alertControllerWithTitle:@"成功" message:model.description preferredStyle:UIAlertControllerStyleAlert];
                                    [alc addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                                    [self presentViewController:alc animated:YES completion:nil];
                                } failure:^(NSError *error) {
                                    [SVProgressHUD dismiss];
                                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                                    [SVProgressHUD dismissWithDelay:1.0];
                                }];
                            }},
                      @{@"PATCH":
                            ^{
                                ReqModel* reqModel = [ReqModel new];
                                reqModel.firstName = @"Chen";
                                reqModel.lastName = @"Haitao";
                                [SVProgressHUD showWithStatus:@"请稍候..."];
                                [JsonModelHttp fire:@"PATCH" url:@"http://www.httpbin.org/patch" param:@{@"param":@"hello"} headers:@{@"Myheader":@"world"} body:reqModel responseModelClass:[ResModel class] success:^(ResModel* model) {
                                    [SVProgressHUD dismiss];

                                    UIAlertController* alc = [UIAlertController alertControllerWithTitle:@"成功" message:model.description preferredStyle:UIAlertControllerStyleAlert];
                                    [alc addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                                    [self presentViewController:alc animated:YES completion:nil];
                                } failure:^(NSError *error) {
                                    [SVProgressHUD dismiss];
                                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                                    [SVProgressHUD dismissWithDelay:1.0];
                                }];
                            }}
                      ];
    }
    return _fuckData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
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
