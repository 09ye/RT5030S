//
//  SHForgetPassWordViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHForgetPassWordViewController.h"

@interface SHForgetPassWordViewController ()

@end

@implementation SHForgetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"忘记密码";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnVerificationOntouch:(id)sender {
    if (mLabEmail.text.length <= 0) {
        [self showAlertDialog:@"请输入邮箱地址"];
        return;
    }
    
    if ( ![SHTools isValidateEmail:mLabEmail.text]) {
        [self showAlertDialog:@"您输入邮箱地址不存在"];
        return;
    }
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:mLabEmail.text forKey:@"username"];
    [dic setValue:@"1" forKey:@"type"];// 1
    SHPostTaskM *task = [[SHPostTaskM alloc]init];
    task.delegate = self;
    task.URL = URL_FOR(@"code.jhtml");
    task.postData = [Utility createPostData:dic];
    task.tag = 0;
    [task start];
    
}

- (IBAction)btnGetPasswordOntouch:(id)sender {
    if (mLabEmail.text.length <= 0) {
        [self showAlertDialog:@"请输入邮箱地址"];
        return;
    }
    
    if ( ![SHTools isValidateEmail:mLabEmail.text]) {
        [self showAlertDialog:@"您输入邮箱地址不存在"];
        return;
    }
//    if (![mLabVerilication.text isEqualToString:verificationCode]) {
//        [self showAlertDialog:@"输入验证码错误！"];
//        return;
//    }
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:mLabEmail.text forKey:@"username"];
    [dic setValue:@"1" forKey:@"type"];// 1 邮箱
    SHPostTaskM *task = [[SHPostTaskM alloc]init];
    task.delegate = self;
    task.URL = URL_FOR(@"findPwd.jhtml");
    task.postData = [Utility createPostData:dic];
    task.tag = 1;
    [task start];

    
}
-(void)taskDidFinished:(SHTask *)task
{
    [self dismissWaitDialog];
    NSDictionary * result = [[task result]mutableCopy];
    if (task.tag == 0) {
        verificationCode = [result objectForKey:@"verifyCode"];
    }else if (task.tag == 1){
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
        [SHIntentManager clear];
    }
    
}

-(void)taskDidFailed:(SHTask *)task
{
    [self dismissWaitDialog];
//    [task.respinfo show];
     [self showAlertDialog:task.respinfo.message];
    
    
}
@end
