//
//  SHUpdatePasswordViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-10-9.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHUpdatePasswordViewController.h"

@interface SHUpdatePasswordViewController ()

@end

@implementation SHUpdatePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    btnCommit.layer.cornerRadius = 3;
    btnCommit.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnCommitOntouch:(id)sender {
    if(txtNewPass1.text.length == 0){
        [self showAlertDialog:@"新密码不可为空"];
        return;
    }
    if(txtNewPass1.text.length < 6){
        [self showAlertDialog:@"密码长度必须大于6位"];
        return;
    }
    if([txtNewPass1.text caseInsensitiveCompare:txtOldPass.text] == NSOrderedSame){
        [self showAlertDialog:@"新密码不可以和旧密码相同!"];
        return;
    }
    if([txtNewPass1.text caseInsensitiveCompare:txtNewPass2.text] != NSOrderedSame){
        [self showAlertDialog:@"新密码2次输入不同!"];
        return;
    }
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:txtOldPass.text forKey:@"oldPwd"];
    [dic setValue:txtNewPass2.text forKey:@"newPwd"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"updatePwd.jhtml");
    post.delegate = self;
    [post setPostData:[Utility createPostData:dic]];
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        [task.respinfo show];
        [[NSNotificationCenter defaultCenter] postNotificationName:CORE_NOTIFICATION_LOGIN_RELOGIN object:nil];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
        [task.respinfo show];
    }];
}
@end
