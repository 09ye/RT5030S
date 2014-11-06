//
//  SHFeedBackViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHFeedBackViewController.h"

@interface SHFeedBackViewController ()

@end

@implementation SHFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundGray"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithSubmit:self action:@selector(subimitOntouch)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) subimitOntouch
{
   
    if (mTxtContent.text.length <= 0) {
        [self showAlertDialog:@"请输入您的宝贵意见！"];
        return;
    }
    if (mtxtPhone.text.length <= 0) {
        [self showAlertDialog:@"请输入手机号码"];
        return;
    }
    
    if ( ![SHTools isValidateMobile:mtxtPhone.text]) {
        [self showAlertDialog:@"您输入手机号码不存在"];
        return;
    }
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:mTxtContent.text forKey:@"content"];
    [dic setValue:mtxtPhone.text forKey:@"mobile"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"suggest.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
        [self.navigationController popViewControllerAnimated:YES];
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
}

@end
