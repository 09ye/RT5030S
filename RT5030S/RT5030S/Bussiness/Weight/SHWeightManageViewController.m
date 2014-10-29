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
    mViewShare.shareContent = @"#体重管理#我在使用荣泰RT5030享秀派，看这是我们的体重管理，我在这里设定了我的目标，我每天都会测试和训练，你也来加入我们吧！ @荣泰健康科技官方微博";
    [self request];
}
-(void) request
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"weightQuery.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        mResult = [[task result]mutableCopy];
        mLabScord.text = [NSString stringWithFormat:@"%@分",[mResult objectForKey:@"point"]];
        mLabWeight.text = [NSString stringWithFormat:@"%dKg",[[mResult objectForKey:@"currentWeight"]intValue]/1000];
        mLabWater.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"currentWater"],@"%"];
        mLabFatRate.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"currentFat"],@"%"];
        [mBtnTarget setTitle:[NSString stringWithFormat:@"目标%dKg",[[mResult objectForKey:@"weightTargat"]intValue]/1000] forState:UIControlStateNormal];

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
