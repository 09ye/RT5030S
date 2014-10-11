//
//  SHRegistViewController.m
//  offer_neptune
//
//  Created by yebaohua on 14-6-10.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHRegistViewController.h"


@interface SHRegistViewController ()

@end

@implementation SHRegistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
    
    imageFlag = YES;
    mBtn_submit.layer.cornerRadius = 4;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    //    mValidate.
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [labPhone resignFirstResponder];
    [labValidate resignFirstResponder];
    [labPassOne resignFirstResponder];
    [labPassTwo resignFirstResponder];
}
- (void)notification:(NSObject*)sender
{
     [SHIntentManager clear];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)submitOnTouch:(id)sender {
    
//    SHIntent * intent = [[SHIntent alloc ]init];
//    intent.target = @"SHSelfInfoViewController";
//    intent.container = self.navigationController;
//    [intent.args setValue:@"regist" forKey:@"classType"];
//    [[UIApplication sharedApplication] open:intent];
//    return;
////    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_REGIST_SUCCESSFUL object:nil];
    if(!registType){
        if (labPhone.text.length <= 0) {
            [self showAlertDialog:@"请输入手机号码"];
            return;
        }
        if ( ![SHTools isValidateMobile:labPhone.text]) {
            [self showAlertDialog:@"您输入的是手机号吗？"];
            return;
        }
    }else{
        if (labPhone.text.length <= 0) {
            [self showAlertDialog:@"请输入邮箱"];
            return;
        }
        if ( ![SHTools isValidateEmail:labPhone.text]) {
            [self showAlertDialog:@"您输入的是邮箱吗？"];
            return;
        }
    }
    
    if (labValidate.text.length <= 0) {
        [self showAlertDialog:@"请输入验证码"];
        return;
    }
    if (labPassOne.text.length <= 0) {
        [self showAlertDialog:@"请输入密码"];
        return;
    }
    if ([labPassOne.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 6 || [labPassOne.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 18) {
        [self showAlertDialog:@"请检查密码长度"];
        return;
    }
    if (labPassTwo.text.length <= 0) {
        [self showAlertDialog:@"请再次输入密码"];
        return;
    }
    if (![labPassOne.text isEqualToString:labPassTwo.text]) {
        [self showAlertDialog:@"两次输入密码不一致，请重新输入"];
        labPassTwo.text = @"";
        return;
    }
    if (!imageFlag){
        [self showAlertDialog:@"亲，您还没同意软件许可及服务协议哦"];
        return;
    }
    if (![labValidate.text isEqualToString:verificationCode]) {
        [self showAlertDialog:@"输入验证码错误！"];
        return;
    }
    [self showWaitDialogForNetWork];
    SHPostTaskM *task = [[SHPostTaskM alloc]init];
    task.tag = 1;
    task.delegate = self;
    task.URL = URL_FOR(@"register.jhtml");
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    if (!registType) {
        [dic setValue:labPhone.text forKey:@"mobile"];
        [dic setValue:@"" forKey:@"email"];
        [dic setValue:@"0" forKey:@"type"];
    }else{
        [dic setValue:@"" forKey:@"mobile"];
        [dic setValue:labPhone.text forKey:@"email"];
        [dic setValue:@"1" forKey:@"type"];
    }
   
    [dic setValue:labPassTwo.text forKey:@"password"];
    [dic setValue:labValidate.text forKey:@"verifyCode"];
    task.postData = [Utility createPostData:dic];
    [task start];
}

- (IBAction)btnPhoneResgitOntouch:(id)sender {
    [mBtnPhone setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
    [mBtnEmail setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
    labPhone.placeholder = @"请输入手机号码";
    registType = NO;
}
- (IBAction)btnEmailResgitOntouch:(id)sender {
    [mBtnPhone setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
    [mBtnEmail setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
    
    registType = YES;
    labPhone.placeholder = @"请输入邮箱地址";
}



- (IBAction)btnVerificationOntouch:(id)sender {
    
    if (!registType) {
        if (labPhone.text.length <= 0) {
            [self showAlertDialog:@"请输入手机号码"];
            return;
        }
        
        if ( ![SHTools isValidateMobile:labPhone.text]) {
            [self showAlertDialog:@"您输入手机号码不存在"];
            return;
        }
    }else {
        if (labPhone.text.length <= 0) {
            [self showAlertDialog:@"请输入邮箱地址"];
            return;
        }
        
        if ( ![SHTools isValidateEmail:labPhone.text]) {
            [self showAlertDialog:@"您输入的邮箱地址有误"];
            return;
        }
    }
   
    [self showWaitDialogForNetWork];
    SHPostTaskM *task = [[SHPostTaskM alloc]init];
    task.delegate = self;
    task.URL = URL_FOR(@"code.jhtml");
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:labPhone.text forKey:@"username"];
    if (!registType) {
         [dic setValue:@"0" forKey:@"type"];// 0 代表手机
    }else{
         [dic setValue:@"1" forKey:@"type"];// 1 
    }
   
    task.postData = [Utility createPostData:dic];
    task.tag = 0;
    [task start];
}

- (IBAction)btnAgreeOntouch:(id)sender {
    
    if(imageFlag == YES){
        [mBtnAgree setBackgroundImage:[SHSkin.instance image:@"xieyi_xuangxiang_weixuan"] forState:UIControlStateNormal];
        imageFlag = NO;
    }else if(imageFlag == NO){
        [mBtnAgree setBackgroundImage:[SHSkin.instance image:@"xieyi_xuangxiang_selected"] forState:UIControlStateNormal];
        imageFlag = YES;
    }
}

- (IBAction)btnReadAgreementOntouch:(id)sender {
    SHIntent *intent = [[SHIntent alloc]init];
    //    intent.module = @"agreement";
    intent.target =@"SHAgreementViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}

-(void)taskDidFinished:(SHTask *)task
{
    [self dismissWaitDialog];
     NSDictionary * result = [[task result]mutableCopy];
    if (task.tag == 0) {
        verificationCode = [result objectForKey:@"verifyCode"];
    }else if (task.tag == 1){
//        [task.respinfo show];
        [[NSUserDefaults standardUserDefaults] setValue:labPhone.text forKey:USER_CENTER_LOGINNAME];
        [[NSUserDefaults standardUserDefaults] setValue:labPassTwo.text forKey:USER_CENTER_PASSWORD];
        SHEntironment.instance.loginName = labPhone.text;
        SHEntironment.instance.password = labPassTwo.text;
        SHEntironment.instance.userId = [task.result valueForKey:@"userId"];
        
        // 注册成功 进入完善资料
        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHSelfInfoViewController";
        intent.container = self.navigationController;
        [intent.args setValue:@"regist" forKey:@"classType"];
        [[UIApplication sharedApplication] open:intent];
    }
    
}

-(void)taskDidFailed:(SHTask *)task
{
    [self dismissWaitDialog];
    [task.respinfo show];
   
    
}
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
//{
//    
//    return YES;
//}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    
//    NSString * phone = [textField.text stringByAppendingString:string];
//    if (textField == labPhone && [SHTools isValidateMobile:phone] && ![string isEqualToString:@""]) {
//        SHPostTaskM * post = [[SHPostTaskM alloc]init];
//        post.URL = URL_FOR(@"validateuser");
//        [post.postArgs setValue:phone forKeyPath:@"mobile"];
//        post.delegate = self;
//        post.tag = 3;
//        [post start];
//    }
//    return YES;
//}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == labPhone) {
        [labValidate becomeFirstResponder];
    }else if(textField == labValidate){
        [labPassOne becomeFirstResponder];
    }else if (textField == labPassOne) {
        [labPassTwo becomeFirstResponder];
    }else if (textField == labPassTwo) {
        [labPassTwo resignFirstResponder];
        [self submitOnTouch:nil];
        
    }
    return YES;
}
@end
