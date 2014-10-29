//
//  SHComparisonViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-23.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//
//比一比
#import "SHTableViewController.h"

@interface SHComparisonViewController : SHTableViewController<SHTaskDelegate>
{
    __weak IBOutlet UISegmentedControl *mSegment;
    __weak IBOutlet SHImageView *imgMy;
    
    __weak IBOutlet UIImageView *imgCricle2;
    __weak IBOutlet SHImageView *imgOther;
    __weak IBOutlet UILabel *mLabName1;
    __weak IBOutlet UILabel *mLabName2;
    __weak IBOutlet UILabel *mLabDate2;
    __weak IBOutlet UILabel *mLabDate1;
    __weak IBOutlet UILabel *mLabWeight1;
    __weak IBOutlet UILabel *mLabWeight2;
    __weak IBOutlet UILabel *mLabFatRate1;
    __weak IBOutlet UILabel *mLabFatRate2;
    __weak IBOutlet UILabel *mLabFat1;
    __weak IBOutlet UILabel *mLabFat2;
    __weak IBOutlet UILabel *mLabScore1;
    __weak IBOutlet UILabel *mLabCalorie1;
    __weak IBOutlet UILabel *mLabScore2;
    __weak IBOutlet UILabel *mLabCalorie2;
    __weak IBOutlet UIView *mViewOther;
    __weak IBOutlet UIView *mViewTarget;
    
    __weak IBOutlet UILabel *mLabToTarget;
    NSDictionary * mResult;
}
- (IBAction)mSegmentTouch:(UISegmentedControl *)sender;
- (IBAction)btnShareOntouch:(UIButton *)sender;

@end
