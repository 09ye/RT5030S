//
//  SHMainHomeViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHMainHomeViewController.h"


@interface SHMainHomeViewController ()

@end

@implementation SHMainHomeViewController

- (void)viewDidLoad {
   
    // Do any additional setup after loading the view from its nib.
    
    SHSettingViewController * controller = [[SHSettingViewController alloc ]init];
    controller.delegate = self;
    controller.navController = self.navigationController;
    self.leftViewController = controller;
//    self.rightViewController = (SHViewController*)nacontroller;
     [super viewDidLoad];
    self.title = @"ST5030";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:NOTIFICATION_BACK_HOME object:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_home_left"] target:self action:@selector(btnLeftOntouch:)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_button_shezhi_default"] target:self action:@selector(btnRightOntouch:)];
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

#pragma  btn action
- (IBAction)btnLeftOntouch:(id)sender {
     [self leftItemClick4ViewController];
}

- (IBAction)btnRightOntouch:(id)sender {
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
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}
- (IBAction)btnFriensdOntouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHFriendListViewController";
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
