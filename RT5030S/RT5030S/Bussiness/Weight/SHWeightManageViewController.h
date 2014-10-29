//
//  SHWeightManageViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-21.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHShareView.h"

@interface SHWeightManageViewController : SHTableViewController<UIActionSheetDelegate,SHTaskDelegate>
{
    
    __weak IBOutlet UILabel *mLabScord;
    __weak IBOutlet UIButton *mBtnTarget;
    __weak IBOutlet UILabel *mLabWeight;
    __weak IBOutlet UILabel *mLabWater;
    __weak IBOutlet UILabel *mLabFatRate;
    __strong IBOutlet   SHShareView* mViewShare;
    NSDictionary * mResult;

}
- (IBAction)btnTargetOntouch:(id)sender;

- (IBAction)btnCompareOntouch:(id)sender;
- (IBAction)btnOnGoReportOntouch:(id)sender;
//- (IBAction)btnShareWeixinOntouch:(id)sender;
//- (IBAction)btnShareWeiboOntouch:(id)sender;
//- (IBAction)btnShareOntouch:(id)sender;
- (IBAction)btnCreateReportOntouch:(id)sender;
@end
