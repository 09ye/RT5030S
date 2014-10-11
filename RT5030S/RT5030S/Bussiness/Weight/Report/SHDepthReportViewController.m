//
//  SHDepthReportViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-23.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHDepthReportViewController.h"

@interface SHDepthReportViewController ()

@end

@implementation SHDepthReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"深度报告";
    mViewShare.shareContent = @"xxxxxx";
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

- (IBAction)btnPhaseReportOntouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHPhaseReportViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnRunOntouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHAdviceHealthViewController";
    [intent.args setValue:@"run" forKey:@"classType"];
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnDietOntouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHAdviceHealthViewController";
    [intent.args setValue:@"diet" forKey:@"classType"];
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}
@end
