//
//  SHMainHomeViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHMainHomeViewController.h"
#import "SHMessageViewController.h"


@interface SHMainHomeViewController ()

@end

@implementation SHMainHomeViewController

- (void)viewDidLoad {
   
    // Do any additional setup after loading the view from its nib.
    
    SHSettingViewController * controller = [[SHSettingViewController alloc ]init];
    
    controller.delegate = self;
    controller.navController = self.navigationController;
    self.leftViewController = controller;
    SHMessageViewController * messageController = [[SHMessageViewController alloc ]init];
    messageController.navController = self.navigationController;
    self.rightViewController = messageController;
//    self.rightViewController = (SHViewController*)nacontroller;
     [super viewDidLoad];
    self.title = @"ST5030";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:NOTIFICATION_BACK_HOME object:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_home_left"] target:self action:@selector(btnLeftOntouch:)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_button_shezhi_default"] target:self action:@selector(btnRightOntouch:)];
     mTimer = [NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(requestMessageCount) userInfo:Nil repeats:YES];
    [self requestHistory];
}
-(void) requestHistory
{

    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:@"1" forKey:@"type"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"querySculptHistory.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        NSDictionary *mResult = [[task result]mutableCopy];
        mLabWeight.text = [NSString stringWithFormat:@"体重%dKg",[[mResult objectForKey:@"weight"]intValue]/1000];
        mLabCalorie.text = [NSString stringWithFormat:@"卡路里%@卡",[mResult objectForKey:@"calorie"]];
        NSDateFormatter * format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyyMMdd"];
        NSDate * date = [format dateFromString:[mResult objectForKey:@"date"]];
        [format setDateFormat:@"yyyy-MM-dd"];
        mLabTime.text = [format stringFromDate:date];
      
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
        [task.respinfo show];
    }];
}
- (CGFloat)leftSContentOffset
{
    return  195;
}

- (CGFloat)rightSContentOffset
{
    return  195;
}

- (void) notification:(NSNotification*)noti
{
    NSString * name = noti.name;
    if ([name isEqualToString:NOTIFICATION_BACK_HOME]){
         [self closeSideBar];
    }
}
-(void) requestMessageCount // 消息
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:@"" forKey:@"type"];
    [dic setValue:@"0" forKey:@"read"];// 0未读
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"listMsg.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        NSDictionary * result = [[task result]mutableCopy];
        mList = [[result objectForKey:@"msgs"]mutableCopy];
        if(mList.count>0){
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"hongdian"] target:self action:@selector(btnRightOntouch:)];
        }else{
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_button_shezhi_default"] target:self action:@selector(btnRightOntouch:)];
        }
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
       
    }];
    
}
#pragma  btn action
- (IBAction)btnLeftOntouch:(id)sender {
    if (!SiderShow) {
         [self leftItemClick4ViewController];
        SiderShow = YES;
    }else{
         [self closeSideBar];
         SiderShow = NO;
    }
    
}

- (IBAction)btnRightOntouch:(id)sender {
    if (!SiderShow) {
        [self rightItemClick4ViewController];
        SiderShow = YES;
    }else{
        [self closeSideBar];
        SiderShow = NO;
    }
  
}

- (IBAction)btnRecordOntouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHRecordViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnWeightOntouch:(id)sender {
    
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHWeightManageViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnBodyOntouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHBodyViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnChartOntouch:(id)sender {
    
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHChartsListViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}
- (IBAction)btnPKOntouch:(id)sender
{
    
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHPKViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}
- (IBAction)btnTargetOntouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHTargetSetViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}
- (IBAction)btnFamilyOntouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHFriendListViewController";
    [intent.args setValue:@"familylist" forKey:@"classType"];
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}
- (IBAction)btnFriensdOntouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHFriendListViewController";
    [intent.args setValue:@"friendlist" forKey:@"classType"];
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}
- (IBAction)btnCancleSongOntouch:(id)sender {
}
#pragma  delegate
-(void) settingViewControllerDelegateDidBackHome:(SHSettingViewController *)controller
{
    [self closeSideBar];
    
}
@end
