//
//  SHDepthReportViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-23.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHShareView.h"

@interface SHDepthReportViewController : SHTableViewController<SHTaskDelegate>
{
    __strong IBOutlet   SHShareView* mViewShare;
    NSDictionary * mResult;
    __weak IBOutlet UILabel *mLabBeforeDay;
    __weak IBOutlet UILabel *mLabBeforeDate;
    __weak IBOutlet UILabel *mLabStander;
    __weak IBOutlet UILabel *mLabWeight;
    __weak IBOutlet UILabel *mLabFat;
    __weak IBOutlet UILabel *mLabWater;
    __weak IBOutlet UILabel *mLabMuscle;
    __weak IBOutlet UILabel *mLabLiver;
    __weak IBOutlet UILabel *mLabBase;
    __weak IBOutlet UILabel *mLabProtein;
    __weak IBOutlet UILabel *mLabBone;
    __weak IBOutlet UIButton *mBtnUseDay;
    __weak IBOutlet UIButton *mBtnWeight;
    __weak IBOutlet UIButton *mBtnFat;
    __weak IBOutlet UIButton *mBtnWater;
}
- (IBAction)btnPhaseReportOntouch:(id)sender;
- (IBAction)btnRunOntouch:(id)sender;
- (IBAction)btnDietOntouch:(id)sender;

@end
