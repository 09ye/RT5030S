//
//  SHBodyModeViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-25.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHBodyModeViewController.h"
#import "SHBlueToothManager.h"

@interface SHBodyModeViewController ()

@end

@implementation SHBodyModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)switchOntouch:(UISwitch *)sender {// 韵律模式 04(自行设置时间） 自动模式03（自行设置时间和频率）
    if(sender.on){
        if(sender == mSwitchYun){
            [mSwitchHand setOn:NO animated:YES];
        }
        else if(sender == mSwitchHand){
            [mSwitchYun setOn:NO animated:YES];
        }
    }else {
        if(sender == mSwitchYun){
            [mSwitchHand setOn:YES animated:YES];
        }
        else if(sender == mSwitchHand){
            [mSwitchYun setOn:YES animated:YES];
        }
    }
    if (mSwitchYun.on) {
        Byte byte [] = {0xf0,0x04,0xf1};
        NSData * data =  [NSData dataWithBytes:&byte length:3];
        [SHBlueToothManager.instance sendData:data];
    }else{
        Byte byte [] = {0xf0,0x03,0xf1};
        NSData * data =  [NSData dataWithBytes:&byte length:3];
        [SHBlueToothManager.instance sendData:data];
    }
  
}

@end
