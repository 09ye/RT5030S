//
//  SHFindEquipmentViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHFindEquipmentViewController.h"
#import "SHBlueToothManager.h"

@interface SHFindEquipmentViewController ()

@end

@implementation SHFindEquipmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"连接设备";
    self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundGray"];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"auto_link_equ"]) {// 自动连接设备
        mSwitchAutoLink.on = YES;
    }else{
         mSwitchAutoLink.on = NO;
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"auto_link_equ"]) {// 自动连接设备
        mSwitchLinkEqu.on = YES;
    }else{
        mSwitchLinkEqu.on = NO;
    }
    if (SHBlueToothManager.instance.peripheral && SHBlueToothManager.instance.peripheral.state !=CBPeripheralStateDisconnected ) {
        mLabState.text = [NSString stringWithFormat:@"已连接设备%@",SHBlueToothManager.instance.peripheral.name];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnEquipmentListOntouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHEquipmentListViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)switchAutoLinkOntouch:(UISwitch *)sender {// 自动连接

    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"auto_link_equ"];
}

- (IBAction)switchLinkEquOntouch:(UISwitch *)sender {
     [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"auto_link_equ"];
}


@end
