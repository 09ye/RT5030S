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
    if ([[self.intent.args objectForKey:@"classType"] isEqualToString:@"1"]) {
        self.title = @"运动方案";
        mLabTitle.text = @"运动方案";
        mViewShare.shareContent = @"#数据报告#我在使用荣泰RT5030S享秀派，看这是我们的数据报告，我在这里设定了我的目标，我每天都会测试和训练，你也来加入我们吧！ @荣泰健康科技官方微博";

    }else{
        self.title = @"饮食建议";
        mLabTitle.text = @"饮食建议";
        mViewShare.shareContent = @"#数据报告#我在使用荣泰RT5030S享秀派，看这是我们的数据报告，我在这里设定了我的目标，我每天都会测试和训练，你也来加入我们吧！ @荣泰健康科技官方微博";
    }
    
}
-(void) request
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:[NSNumber numberWithInt:[[self.intent.args objectForKey:@"classType"]intValue]] forKey:@"type"];//1运动方案，2:饮食建议，3：塑身建议
    [dic setValue:[NSNumber numberWithInt:[[self.intent.args objectForKey:@"state" ]intValue]] forKey:@"result"];//1标准，2：偏瘦：3偏胖
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"adviceQuery.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        mResult = [[task result]mutableCopy];
        txtContent.text = [mResult objectForKey:@"content"];
 
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
        [self showAlertDialog:task.respinfo.message];

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
