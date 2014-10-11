//
//  SHAdviceHealthViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-23.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHAdviceHealthViewController.h"

@interface SHAdviceHealthViewController ()

@end
// classType run 健康建议。 diet 饮食健康
@implementation SHAdviceHealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([[self.intent.args objectForKey:@"classType"] isEqualToString:@"run"]) {
        self.title = @"远动方案";
        mLabTitle.text = @"远动方案";
        mViewShare.shareContent = @"xxx22xxx";
    }else{
        self.title = @"饮食建议";
        mLabTitle.text = @"饮食建议";
        mViewShare.shareContent = @"xx222xxxx";
    }
    
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
