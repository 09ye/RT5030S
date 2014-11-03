//
//  SHFamilyDetailViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-10-22.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHFamilyDetailViewController : SHTableViewController<SHTaskDelegate>
{
    __weak IBOutlet SHImageView *mImgPhoto;
    
    __weak IBOutlet UILabel *mLabName;
    __weak IBOutlet UILabel *mLabScore;
    __weak IBOutlet UILabel *mLabHeathState;
    __weak IBOutlet UILabel *mLabStander;
    __weak IBOutlet UILabel *mLabWeight;
    __weak IBOutlet UIButton *mbtnWeight;
    __weak IBOutlet UILabel *mLabFat;
    __weak IBOutlet UIButton *mbtnFat;
    __weak IBOutlet UILabel *mLabWater;
    __weak IBOutlet UIButton *mbtnWater;
    __weak IBOutlet UILabel *mLabMuscle;
    __weak IBOutlet UIButton *mbtnMuscle;
    __weak IBOutlet UILabel *mLabVisceralFat;
    __weak IBOutlet UIButton *mbtnVisceralFat;
    __weak IBOutlet UILabel *mLabBase;
    __weak IBOutlet UIButton *mbtnBase;
    __weak IBOutlet UILabel *mLabprotein;
    __weak IBOutlet UIButton *mbtnProtein;
    __weak IBOutlet UILabel *mLabBone;
    __weak IBOutlet UIButton *mbtnBone;
    
    NSMutableDictionary * mResult;
}

@end
