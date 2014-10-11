//
//  SHBodyViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-25.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHBodyModeViewController.h"
#import "SHRealDataViewController.h"
#import "SHComperDataViewController.h"

@interface SHBodyViewController : SHTableViewController
{
    
    __weak IBOutlet UIButton *mbtnMode;
    __weak IBOutlet UIView *mViewContain;
    __weak IBOutlet UIButton *mbtnRealData;
    __weak IBOutlet UIButton *mbtnDataComper;
    SHBodyModeViewController * mViewBodyMode;
    SHRealDataViewController * mViewRealData;
    SHComperDataViewController * mViewComperData;
}

- (IBAction)btnTopTabOntohc:(UIButton *)sender;
@end
