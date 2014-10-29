//
//  SHTargetSetViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-22.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHTargetSetViewController : SHTableViewController<SHTableHorizontalViewDataSource,SHTableHorizontalViewDelegate,SHTaskDelegate>
{
    __weak IBOutlet UISegmentedControl *mSegment;
    __weak IBOutlet UILabel *mLabNowTarget;
    
    __weak IBOutlet UILabel *mLabTargetName;
    __weak IBOutlet UIButton *mBtnTargetLevel;
    __weak IBOutlet UILabel *mLabMount;
    __weak IBOutlet UIImageView *mImgBg;
    __weak IBOutlet UIImageView *img1;
    __weak IBOutlet UIImageView *img2;
     NSMutableDictionary * mResult;
    __weak IBOutlet SHTableHorizontalView *mScrollview;
}

@end
