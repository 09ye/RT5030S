//
//  SHFamilyDetailViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-10-22.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHFamilyDetailViewController.h"

@interface SHFamilyDetailViewController ()

@end

@implementation SHFamilyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详细数据";
    [mImgPhoto setCircleStyle:nil];
    [self request];

}
-(void) request
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"listFriend.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        NSDictionary * result = [[task result]mutableCopy];
        mList = [[result objectForKey:@"friends"]mutableCopy];
        [self.tableView reloadData];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
        [task.respinfo show];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
