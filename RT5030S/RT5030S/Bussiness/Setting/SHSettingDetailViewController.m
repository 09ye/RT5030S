//
//  SHSettingDetailViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHSettingDetailViewController.h"

@interface SHSettingDetailViewController ()

@end

@implementation SHSettingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundGray"];
    if([[NSUserDefaults standardUserDefaults]boolForKey:SEARCH_ME]){
        mSwitchSearch.on = YES;
    }else {
        mSwitchSearch.on = NO;
    }
    if([[NSUserDefaults standardUserDefaults]boolForKey:AUTO_LINK]){
        mSwitchAutolink.on = YES;
    }else {
        mSwitchAutolink.on = NO;
    }
    if([[NSUserDefaults standardUserDefaults]boolForKey:AUTOLOGIN]){
        mSwitchAutoLogin.on = YES;
    }else {
        mSwitchAutoLogin.on = NO;
    }
}

#pragma btn action

- (IBAction)switchSearchOntouch:(UISwitch *)sender {
    if(sender.on){
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:SEARCH_ME];
    }else {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:SEARCH_ME];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (IBAction)switchAutolinkOntouch:(UISwitch *)sender {
    if(sender.on){
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:AUTO_LINK];
    }else {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:AUTO_LINK];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}


- (IBAction)switchAutoLoginOntouch:(UISwitch *)sender
{
    if(sender.on){
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:AUTOLOGIN];
    }else {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:AUTOLOGIN];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
