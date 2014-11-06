//
//  SHDataReportViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-29.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHDataReportViewController.h"

@interface SHDataReportViewController ()

@end

@implementation SHDataReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [imgPhoto setCircleStyle:nil];
    [imgPhoto setUrl: [[NSUserDefaults standardUserDefaults]objectForKey:USER_CENTER_PHOTO]];
    mViewShare.shareContent = @"#数据报告#我在使用荣泰RT5030享秀派，看这是我们的数据报告，我在这里设定了我的目标，我每天都会测试和训练，你也来加入我们吧！ @荣泰健康科技官方微博";
    self.title = @"数据报告";
    [self request];
    
}
-(void) request
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"sculptReport.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        mResult = [[task result]mutableCopy];
        mLabCalrio.text = [NSString stringWithFormat:@"%@卡",[mResult objectForKey:@"totalCalorie"]];
        mLabTime.text = [NSString stringWithFormat:@"%@分钟",[mResult objectForKey:@"totalTime"]];
        txtSuggestRun.text = [mResult objectForKey:@"healthSuggest"];
        txtSuggestDiet.text = [mResult objectForKey:@"foodSuggest"];
 
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
