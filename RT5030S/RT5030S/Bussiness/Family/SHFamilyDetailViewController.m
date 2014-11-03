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
    NSDictionary * dic = [self.intent.args objectForKey:@"detail"];
    mLabName.text = [dic objectForKey:@"nickName"];
    mLabName.text = [dic objectForKey:@"area"];
    [mImgPhoto setUrl:[dic objectForKey:@"headImg"]];
    [self request];

}
-(void) request
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:[[self.intent.args objectForKey:@"detail"] objectForKey:@"userId"] forKey:@"userId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"deepWeightQuery.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        mResult = [[task result]mutableCopy];
        mLabWeight.text = [NSString stringWithFormat:@"%dKg",[[mResult objectForKey:@"weight"]intValue]/1000 ];
        mLabFat.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"fat"],@"%"];
        mLabWater.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"water"],@"%"];
        mLabMuscle.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"muscle"],@"%"];
        mLabVisceralFat.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"liver"],@"%"];
        mLabBase.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"metabolism"],@"%"];
        mLabprotein.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"protein"],@"%"];
        mLabBone.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"bone"],@"%"];
        mLabStander.text = [mResult objectForKey:@"statusName"];
//        mLabHeathState.text = [mResult objectForKey:@"statusName"];
        
        
        
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
