//
//  SHBodyModeViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-25.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import <MediaPlayer/MPMediaPickerController.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SHMusicPlayerManager.h"
@interface SHBodyModeViewController : SHTableViewController<SHTaskDelegate,MPMediaPickerControllerDelegate>
{
    __weak IBOutlet UISwitch *mSwitchYun;
    __weak IBOutlet UISwitch *mSwitchHand;
    __weak IBOutlet UIButton *mBtnStart;
    __weak IBOutlet UIButton *mBtnModeName;
    __weak IBOutlet UILabel *mLabMusicTime;
    __weak IBOutlet UILabel *mLabMusicTitle;
    __weak IBOutlet UIButton *mBtnTimeSet;
    __weak IBOutlet UIButton *mBtnFrequencySet;
    NSTimer * mTimer;
    
}
@property(nonatomic,retain) UINavigationController *navController; // If this view controller has been pushed onto a navigation controller, return it.
- (IBAction)btnMusSelectOntouch:(id)sender;
- (IBAction)switchOntouch:(UISwitch *)sender;
- (IBAction)btnStartOntouch:(id)sender;
- (IBAction)btnReduceOntouch:(UIButton *)sender;
- (IBAction)btnIncreaseOntouch:(UIButton *)sender;




@end
