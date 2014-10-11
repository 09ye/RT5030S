//
//  SHWeightManageViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-21.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHWeightManageViewController.h"

@interface SHWeightManageViewController ()

@end

@implementation SHWeightManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"体重管理";
    self.view.backgroundColor = [UIColor whiteColor];
    mViewShare.shareContent = @"xxxxxx";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnTargetOntouch:(id)sender {
    
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHTargetSetViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnCompareOntouch:(id)sender {
    
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHFriendListViewController";
    [intent.args setValue:@"comper" forKey:@"classType"];
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnOnGoReportOntouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHPhaseReportViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}
- (IBAction)btnCreateReportOntouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHDepthReportViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}






@end
