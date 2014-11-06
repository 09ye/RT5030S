//
//  SHMainViewController.m
//  crowdfunding-arcturus
//
//  Created by WSheely on 14-4-8.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//
#import "MainViewController.h"
#import "SHMainHomeViewController.h"
#import "SHGuideViewController.h"


@interface MainViewController ()<SHGuideViewControllerDelegate>
{
    
    SHGuideViewController  *guideVC;
}

@end

@implementation MainViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector: @selector(loginReLogin:) name: CORE_NOTIFICATION_LOGIN_RELOGIN object:nil];
    loginViewController = [[SHLoginViewController alloc ]init];
   


    // 引导页
    [self  showGuidePage] ;
    // Do any additional setup after loading the view from its nib.
    
}
- (void)loginReLogin:(NSObject *) n
{
    loginViewController.view.hidden = NO;
    [self.view addSubview:loginViewController.view];
}
- (void)notification:(NSObject*)sender
{
    [loginViewController.view removeFromSuperview];
    
    //[self showAlertDialog:@"您有新的重要任务事项" button:@"前往查看" otherButton:@"取消"];
    //    tabbar.selectedItem = [tabbar.items objectAtIndex:0];
    //    [self tabBar:tabbar didSelectItem:tabbar.selectedItem];
    //    SHIntent*intent = [[SHIntent alloc]init:@"un_do_message" delegate:nil containner:nil];
    //    [[UIApplication sharedApplication]open:intent];
    
    UINavigationController * nacontroller = [[UINavigationController alloc]initWithRootViewController: [[SHMainHomeViewController alloc ] init]];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [nacontroller.navigationBar setTitleTextAttributes:attributes];
    nacontroller.navigationBar.translucent = NO;
    nacontroller.navigationBar.tintColor = [UIColor whiteColor];
    if(!iOS7){
        nacontroller.navigationBar.clipsToBounds = YES;
    }
    [nacontroller.navigationBar setBackgroundImage:[UIImage imageNamed:@"ic_title"] forBarMetrics:UIBarMetricsDefault];
    nacontroller.view.frame =  self.view.bounds;
    [self.view addSubview:nacontroller.view];
    [self addChildViewController:nacontroller];
}
-(void)bootSetting{
    
     [self.view addSubview:loginViewController.view];
    

    
    
    //自动登录
    if ([[NSUserDefaults standardUserDefaults]boolForKey:AUTOLOGIN] == nil ||[[NSUserDefaults standardUserDefaults]boolForKey:AUTOLOGIN]) {
        [self autologin];
    }
    
    
}
-(void) autologin
{
    NSString * username = [[NSUserDefaults standardUserDefaults]objectForKey:USER_CENTER_LOGINNAME];
    NSString * password = [[NSUserDefaults standardUserDefaults]objectForKey:USER_CENTER_PASSWORD];
    if (username && password) {
        SHEntironment.instance.loginName = username;
        SHEntironment.instance.password = password;
        AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setValue:username forKey:@"username"];
        [dic setValue:password forKey:@"password"];
        [dic setValue:[NSNumber numberWithDouble: app.myLocation.location.coordinate.longitude] forKey:@"longitude"];
        [dic setValue:[NSNumber numberWithDouble: app.myLocation.location.coordinate.latitude] forKey:@"latitude"];
        SHPostTaskM * task = [[SHPostTaskM alloc]init];
        task.URL = URL_FOR(@"login.jhtml");
        task.delegate = self;
        task.tag = 0;
        task.postData  = [Utility createPostData:dic];
        [task start];
    }
    
}
-(void) taskDidFinished:(SHTask *)task
{
    [self dismissWaitDialog];
    if (task.tag == 0) {

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

            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
        }
        
    }
}




- (void)loginSuccessful:(NSObject *)sender
{
}

#pragma  mark  引导页加载

-(void)showGuidePage {
    //判断是否出现引导页
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        
    }
    else{
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"] && false) {
        // 这里判断是否第一次
        guideVC=[[SHGuideViewController alloc]  init];
        guideVC.delegate=self;
        [self.view addSubview:guideVC.view];
        return  ;
        
    }else{
        
        [self bootSetting];
        
    }
   
}
-(void) guideViewController:(SHGuideViewController *)aguidVC viewClosed:(int)viewClosed{
    
    
    [guideVC.view   removeFromSuperview];
    
    [self bootSetting];
    
    
}


@end
