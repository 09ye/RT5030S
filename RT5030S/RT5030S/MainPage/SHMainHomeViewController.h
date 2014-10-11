//
//  SHMainHomeViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHSettingViewController.h"


@interface SHMainHomeViewController : SHTableViewController<SHSettingViewControllerDelegate>
{
    __weak IBOutlet UIView *mViewTop;
    __weak IBOutlet UIView *mViewButtom;
    __weak IBOutlet UILabel *mLabWeight;
     
    __weak IBOutlet UILabel *mLabTime;
    __weak IBOutlet UILabel *mLabCalorie;
    __weak IBOutlet UILabel *mLabSongName;
    __weak IBOutlet SHImageView *mImgSong;
    SHLoginViewController* loginViewController;
}
- (IBAction)btnLeftOntouch:(id)sender;

- (IBAction)btnRightOntouch:(id)sender;
- (IBAction)btnRecordOntouch:(id)sender;
- (IBAction)btnWeightOntouch:(id)sender;
- (IBAction)btnBodyOntouch:(id)sender;
- (IBAction)btnChartOntouch:(id)sender;
- (IBAction)btnPKOntouch:(id)sender;
- (IBAction)btnTargetOntouch:(id)sender;
- (IBAction)btnFamilyOntouch:(id)sender;
- (IBAction)btnFriensdOntouch:(id)sender;
- (IBAction)btnCancleSongOntouch:(id)sender;
@end
