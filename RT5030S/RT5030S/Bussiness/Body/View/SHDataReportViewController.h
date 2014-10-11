//
//  SHDataReportViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-29.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHShareView.h"

@interface SHDataReportViewController : SHTableViewController
{
    __weak IBOutlet SHImageView *imgPhoto;
    __strong IBOutlet   SHShareView* mViewShare;
    __weak IBOutlet UILabel *mLabCalrio;
    __weak IBOutlet UILabel *mLabTime;
    __weak IBOutlet UITextView *txtSuggestRun;
    __weak IBOutlet UITextView *txtSuggestDiet;
}

@end
