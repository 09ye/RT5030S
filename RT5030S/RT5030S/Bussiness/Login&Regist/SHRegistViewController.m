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
    if(!iOS7){
        CGRect frame =  mSwitch.frame;
        frame.origin.x -= 30;
        mSwitch.frame = frame;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"注册";
   
    imageFlag = YES;
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgAction:)];
    imgAgree.userInteractionEnabled =YES;
    [imgAgree addGestureRecognizer:tap];
    labPassword.delegate = self;
    UITapGestureRecognizer *labTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labAction:)];
    labAgreement.userInteractionEnabled = YES;
    [labAgreement addGestureRecognizer:labTap];
    
    mView_1.layer.cornerRadius = 3;
    mView_1.layer.backgroundColor = [[UIColor colorWithRed:255 green:255 blue:255 alpha:0.5]CGColor];
    mView_2.layer.cornerRadius = 3;
    mView_2.layer.backgroundColor = [[UIColor colorWithRed:255 green:255 blue:255 alpha:0.5]CGColor];
    mView_3.layer.cornerRadius = 3;
    mView_3.layer.backgroundColor = [[UIColor colorWithRed:255 green:255 blue:255 alpha:0.5]CGColor];
    mView_validate.layer.masksToBounds = YES;
    mView_validate.layer.cornerRadius = 4;
    
    mBtn_submit.layer.cornerRadius = 4;
    
}

-(void)imgAction:(id)sender
{
    
    if(imageFlag == YES){
        imgAgree.image = [SHSkin.instance image:@"ic_autologin"];
        imageFlag = NO;
    }else if(imageFlag == NO){
        imgAgree.image = [SHSkin.instance image:@"ic_autologin_select"];
        imageFlag = YES;
    }
    
}

-(void)labAction:(id)sender
{
//    NSLog(@"ssssss");
    SHIntent *intent = [[SHIntent alloc]init];
//    intent.module = @"agreement";
    intent.target =@"SHAgreementViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)validateOnTouch:(id)sender {
    if (labPhone.text.length <= 0) {
        [self showAlertDialog:@"请输入手机号码"];
        return;
    }
  
    if ( ![SHTools isValidateMobile:labPhone.text]) {
        [self showAlertDialog:@"您输入的是手机号吗？"];
        return;
    }
    [self showWaitDialogForNetWorkDismissBySelf];
    SHPostTaskM *task = [[SHPostTaskM alloc]init];
    task.delegate = self;
    task.URL = URL_FOR(@"getverifycode");
    task.tag = 0;
    [task.postArgs setObject:labPhone.text forKey:@"MobileNumber"];
    [task start];
    
}

- (IBAction)submitOnTouch:(id)sender {
   
[[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_REGIST_SUCCESSFUL object:nil];

    if (labPhone.text.length <= 0) {
        [self showAlertDialog:@"请输入手机号码"];
        return;
    }
    if (labValidate.text.length <= 0) {
        [self showAlertDialog:@"请输入验证码"];
        return;
    }
    if (labPassword.text.length <= 0) {
        [self showAlertDialog:@"请输入密码"];
        return;
    }
    if ([labPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 6 || [labPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 18) {
        [self showAlertDialog:@"请检查密码长度"];
        return;
    }
    if (!imageFlag){
        [self showAlertDialog:@"亲，您还没同意“欧孚网站用户注册协议”哦"];
        return;
    }
    [self showWaitDialogForNetWorkDismissBySelf];
    SHPostTaskM *task = [[SHPostTaskM alloc]init];
    task.tag = 1;
    task.delegate = self;
    task.URL = URL_FOR(@"registeruser");
    [task.postArgs setObject:labPhone.text forKey:@"username"];
    [task.postArgs setObject:labValidate.text forKey:@"VerifyCode"];
    [task.postArgs setObject:labPassword.text forKey:@"password"];
    [task.postArgs setValue:@"mobile" forKey:@"UserNameType"];
    [task.postArgs setValue:@"jobhunter" forKey:@"RoleID"];
    [task start];
}

- (IBAction)switchOnTouch:(id)sender {
    if (mSwitch.isOn) {
        labPassword.secureTextEntry = YES;
    }else{
        labPassword.secureTextEntry = NO;
    }
}

-(void)taskDidFinished:(SHTask *)task
{
    [self dismissWaitDialog];
//    if (task.tag == 1) {
//        NSDictionary *  result = (NSDictionary *)[task result];
//        Entironment.instance.sessionid = [result objectForKey:@"SessionId"];
//        Entironment.instance.loginName = labPhone.text;
//        Entironment.instance.password = labPassword.text;
//        [[NSUserDefaults standardUserDefaults] setValue:labPhone.text  forKey:@"username"];
//        [[NSUserDefaults standardUserDefaults] setValue:labPassword.text  forKey:@"password"];
//        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:0]  forKey:@"personinfo_state"];
//
//        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
//        SHPostTaskM * post = [[SHPostTaskM alloc]init];
//        post.tag = 2;
//        post.URL = URL_FOR(@"getuserinformationbysession");
//        post.delegate  = self;
//        [post start];
//        
//    }else if(task.tag == 2){
//        NSDictionary * mResult = (NSDictionary *)[task result];
//        [[NSUserDefaults standardUserDefaults] setValue:[mResult objectForKey:@"MobileNumber"]  forKey:@"moblile"];
//        [[NSUserDefaults standardUserDefaults] setValue:[mResult objectForKey:@"EmailAddress"]   forKey:@"email"];
//        [[NSUserDefaults standardUserDefaults] setValue:[mResult objectForKey:@"DisplayName"]   forKey:@"display_name"];
//        [[NSUserDefaults standardUserDefaults] setValue:[mResult objectForKey:@"UserInformationID"]   forKey:@"pseron_id"];
//
//    }else if(task.tag == 3){
//        labValidate.enabled = YES;
//        labPassword.enabled = YES;
//    }
}

-(void)taskDidFailed:(SHTask *)task
{
    [self dismissWaitDialog];
    [task.respinfo show];
    if (task.tag == 3) {
        labValidate.enabled = NO;
        labPassword.enabled = NO;
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
{
   
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString * phone = [textField.text stringByAppendingString:string];
    if (textField == labPhone && [SHTools isValidateMobile:phone] && ![string isEqualToString:@""]) {
        SHPostTaskM * post = [[SHPostTaskM alloc]init];
        post.URL = URL_FOR(@"validateuser");
        [post.postArgs setValue:phone forKeyPath:@"mobile"];
        post.delegate = self;
        post.tag = 3;
        [post start];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == labPhone) {
        [labValidate becomeFirstResponder];
    }else if(textField == labValidate){
       [labPassword becomeFirstResponder];
    }else if (textField == labPassword) {
        [labPassword resignFirstResponder];
        [self submitOnTouch:nil];
        
    }
    return YES;
}
@end
