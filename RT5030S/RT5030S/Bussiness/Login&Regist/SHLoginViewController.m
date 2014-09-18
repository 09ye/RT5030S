//
//  LoginViewController.m
//  
//
//  Created by sheely on 13-9-9.
//
//

#import "SHLoginViewController.h"
#import "SHPostTaskM.h"
@interface SHLoginViewController ()

@end

@implementation SHLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self showAlertDialog:[IPAddress getIPAddress]];
    self.keybordView = self.view;
    
    if(iOS7){
         self.keybordheight = 70;
    }else{
         self.keybordheight = 80;
    }
   
    NSString *loginName = [[NSUserDefaults standardUserDefaults] valueForKey:USER_CENTER_LOGINNAME];
    mTxtName.text = loginName;
    if( [[NSUserDefaults standardUserDefaults]valueForKey:@"URL_HEADER" ]){
        [SHTask pull:URL_HEADER newUrl: [[NSUserDefaults standardUserDefaults]valueForKey:@"URL_HEADER" ]];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSkin
{
    [super loadSkin];
    mBtnLogin.userstyle = @"btnsubmit";
    mTxtName.userstyle = @"txtstandard";
    mTxtPassword.userstyle = @"txtstandard";
//mImgBack.image = [SHSkin.instance stretchImage:@"bg_login.png"];
//  mTxtName.leftView.frame.origin.x = 10;
//  CGRect)textRectForBounds:(CGRect)bounds{ return CGRectInset(bounds, 5, 0); }
//  (CGRect)editingRectForBounds:(CGRect)bounds{ return CGRectInset(bounds, 5, 0); }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (IBAction)btnResigtOntouch:(id)sender {

        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHRegistViewController";
        intent.container = self.navigationController;
        [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnForgotPassOntouch:(id)sender {
}

- (IBAction)btnQQloginOntouch:(id)sender {
}

- (IBAction)btnWeiboOntouch:(id)sender {
}

- (IBAction)btnLoginOnTouch:(id)sender
{
    if(mTxtName.text.length <= 0 || mTxtPassword.text.length <= 0){
        [self showAlertDialog:@"用户名和密码不能为空"];
        return;
    }
    
    [self showWaitDialogForNetWork];
    SHEntironment.instance.loginName = mTxtName.text;
    SHEntironment.instance.password = [SHTools md5Encrypt:mTxtPassword.text];
    SHPostTaskM * task = [[SHPostTaskM alloc]init];
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    task.postArgs = dic;
    task.URL = @"http://www.baidu.com";
    task.delegate = self;
    task.cachetype = CacheTypeTimes;
    [task start];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];

}

- (IBAction)tapOnTouch:(id)sender
{
    SHIntent* intent = [[SHIntent alloc]init:@"server_change" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];
}

- (void)taskDidFinished:(SHTask *)task
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
    [[NSUserDefaults standardUserDefaults] setValue:mTxtName.text forKey:USER_CENTER_LOGINNAME];
    [self dismissWaitDialog];
    [self dismiss];
    SHUser.instance.userId = [task.result valueForKey:@"user_row"];
}

- (void)taskDidFailed:(SHTask *)task
{
    //[task.respinfo show];
    [self dismissWaitDialog];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == mTxtName){
        [mTxtPassword becomeFirstResponder];
    }else{
        [self btnLoginOnTouch:nil];
        return YES;
    }
    return NO;
}

- (void)dismiss
{
    [self.view removeFromSuperview];
}@end
