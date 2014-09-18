//
//  MainViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-17.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

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
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
    loginViewController = [[SHLoginViewController alloc ]init];
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
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
