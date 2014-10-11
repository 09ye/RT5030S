//
//  SHSettingViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@class SHSettingViewController ;
@protocol SHSettingViewControllerDelegate <NSObject>


-(void) settingViewControllerDelegateDidBackHome :(SHSettingViewController*) controller;

@end

@interface SHSettingViewController : SHTableViewController
{

    __weak IBOutlet SHImageView *imgPhoto;
    __weak IBOutlet UILabel *labName;
    __weak IBOutlet UIButton *btnLoginOut;
    __weak IBOutlet UIButton *btnFeedBack;
}
@property (nonatomic,assign) id<SHSettingViewControllerDelegate> delegate;
@property(nonatomic,strong) UINavigationController *navController; // If this view controller has been pushed onto a navigation controller, return it.
- (IBAction)btnLoginOutOntouch:(id)sender;
- (IBAction)btnFeedBackOntouch:(id)sender;
- (IBAction)btnMyinfoOntouch:(id)sender;
@end
