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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sinaAuthonSuccess:) name:NOTIFY_SinaAuthon_Success object:nil];
    _permissions = [NSMutableArray arrayWithObjects:kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,nil];
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:APPID_QQ andDelegate:self];
    // Do any additional setup after loading the view from its nib.
//#if DEBUG
//    
//    mTxtName.text = @"18010551979";//15173
//    
//    mTxtPassword.text = @"123456";
//    
//#else
    
    mTxtName.text =  [[NSUserDefaults standardUserDefaults]stringForKey:USER_CENTER_LOGINNAME];
    mTxtPassword.text =  [[NSUserDefaults standardUserDefaults]stringForKey:USER_CENTER_PASSWORD];
    
//#endif
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

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
#pragma  btnOntouch
- (IBAction)btnResigtOntouch:(id)sender {
    
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHRegistViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnForgotPassOntouch:(id)sender {
    
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHForgetPassWordViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnQQloginOntouch:(id)sender {
    [_tencentOAuth authorize:_permissions inSafari:YES];
}

- (IBAction)btnWeiboOntouch:(id)sender {
    AppDelegate  *dd=(AppDelegate  *)[UIApplication sharedApplication].delegate;
    
    [dd  sendLoginSina:self];
}
-(void)sinaAuthonSuccess:(NSDictionary  *)userDic{
    
#pragma  mark  2014 05 08 sina 登录数据接入
    //[self showWaitDialogForNetWork];
    
    //    NSDictionary  *detailDic=[userDic valueForKey:@"object"];
    
    //    NSString  *nickname=[detailDic valueForKey:@"screen_name"];
    //    NSString   *userphotoURL=[detailDic valueForKey:@"avatar_large"];
    [self oauthlogin];
    
    
    
}
- (IBAction)btnLoginOnTouch:(id)sender
{
    if(mTxtName.text.length <= 0 || mTxtPassword.text.length <= 0){
        [self showAlertDialog:@"用户名和密码不能为空"];
        return;
    }
    
    [self showWaitDialogForNetWork];
    AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:mTxtName.text forKey:@"username"];
    [dic setValue:mTxtPassword.text forKey:@"password"];
    [dic setValue:[NSNumber numberWithDouble: app.myLocation.location.coordinate.longitude] forKey:@"longitude"];
    [dic setValue:[NSNumber numberWithDouble: app.myLocation.location.coordinate.latitude] forKey:@"latitude"];
    SHPostTaskM * task = [[SHPostTaskM alloc]init];
    task.URL = URL_FOR(@"login.jhtml");
    task.delegate = self;
    task.tag = 0;
    task.postData  = [Utility createPostData:dic];
    [task start];
    
}
- (void)showInvalidTokenOrOpenIDMessage{
    
    __autoreleasing UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
    [alert show];
}

-(void)tencentDidNotLogin:(BOOL)cancelled{
    
    
    [self showAlertDialog:@"用户取消登录"];
}
/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    
    [self showAlertDialog:@"网络有问题!"];
    
}

-(void)tencentDidLogin{
    NSLog(@"accessToken==>%@",[_tencentOAuth   accessToken]);
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
        // 记录登录用户的OpenID、Token以及过期时间
        if (  [_tencentOAuth  getUserInfo] ) {
            
            NSLog(@"获取用户资料成功 openId==> %@" ,[_tencentOAuth  openId] );
            // user/OauthLogin  data{openid,token,nickname,userphoto,type}
            
        }
    }
    else
    {
        //_labelAccessToken.text = @"登录不成功 没有获取accesstoken";
    }
}
/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
 *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */

-(void)getUserInfoResponse:(APIResponse *)response{
    
    /*{
     figureurl = "http://qzapp.qlogo.cn/qzapp/101072114/C8AED19C5F9093F97E1595BADE1290BA/30";
     "figureurl_1" = "http://qzapp.qlogo.cn/qzapp/101072114/C8AED19C5F9093F97E1595BADE1290BA/50";
     "figureurl_2" = "http://qzapp.qlogo.cn/qzapp/101072114/C8AED19C5F9093F97E1595BADE1290BA/100";
     "figureurl_qq_1" = "http://q.qlogo.cn/qqapp/101072114/C8AED19C5F9093F97E1595BADE1290BA/40";
     "figureurl_qq_2" = "http://q.qlogo.cn/qqapp/101072114/C8AED19C5F9093F97E1595BADE1290BA/100";
     gender = "\U7537";
     "is_lost" = 0;
     "is_yellow_vip" = 0;
     "is_yellow_year_vip" = 0;
     level = 0;
     msg = "";
     nickname = "1/2\U7684\U5fc3";
     ret = 0;
     vip = 0;
     "yellow_vip_level" = 0;
     } */
    NSLog(@"获取用户资料成功111==> %@ ",  [response jsonResponse]);
#pragma  mark  2014 05 08 QQ 登录数据接入
    // [self showWaitDialogForNetWork];
    
    [[NSUserDefaults standardUserDefaults] setObject:[_tencentOAuth   accessToken] forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] setObject:[_tencentOAuth  openId]  forKey:@"openId"];
    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"login_type"];
    
    [self oauthlogin];
    
}
/**
 * 退出登录的回调
 */
- (void)tencentDidLogout{
    
    NSLog(@"  * 退出登录的回调");
    [_tencentOAuth logout:self];
}
/**
 * 第三方登陆offer接口
 */
-(void) oauthlogin
{    
    [self showWaitDialogForNetWork];
    AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"openId"] forKey:@"openId"];
    [dic setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"token"] forKey:@"token"];
    [dic setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"login_type"] forKey:@"type"];//1微信2 QQ 3新浪微博4腾讯微博
    [dic setValue:[NSNumber numberWithDouble: app.myLocation.location.coordinate.longitude] forKey:@"longitude"];
    [dic setValue:[NSNumber numberWithDouble: app.myLocation.location.coordinate.latitude] forKey:@"latitude"];
    SHPostTaskM * task = [[SHPostTaskM alloc]init];
    task.URL = URL_FOR(@"loginThird.jhtml");
    task.delegate = self;
    task.tag = 100;
    task.postData  = [Utility createPostData:dic];
    [task start];
    
}


- (void)taskDidFinished:(SHTask *)task
{
    [self dismissWaitDialog];
 
    if (task.tag == 0 || task.tag == 100) {
       
        [[NSUserDefaults standardUserDefaults] setValue:mTxtName.text forKey:USER_CENTER_LOGINNAME];
        [[NSUserDefaults standardUserDefaults] setValue:mTxtPassword.text forKey:USER_CENTER_PASSWORD];
        SHEntironment.instance.loginName = mTxtName.text;
        SHEntironment.instance.password = mTxtPassword.text;
        SHEntironment.instance.userId = [task.result valueForKey:@"userId"];
          [[NSUserDefaults standardUserDefaults] setValue:[task.result valueForKey:@"nickName"] forKey:USER_CENTER_NICKNAME];
          [[NSUserDefaults standardUserDefaults] setValue:[task.result valueForKey:@"headImg"] forKey:USER_CENTER_PHOTO];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if(![[task.result valueForKey:@"complete"]boolValue]){
            // 注册成功 进入完善资料
            SHIntent * intent = [[SHIntent alloc ]init];
            intent.target = @"SHSelfInfoViewController";
            intent.container = self.navigationController;
            [intent.args setValue:@"complete" forKey:@"classType"];
            [[UIApplication sharedApplication] open:intent];
            
        }else{
            [self dismiss];
             [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
        }
    }
   
    
   
}
# pragma  taskdid
- (void)taskDidFailed:(SHTask *)task
{
    [task.respinfo show];
    [self dismissWaitDialog];
 
    
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
