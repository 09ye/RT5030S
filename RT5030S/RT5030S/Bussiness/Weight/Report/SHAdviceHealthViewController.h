//
//  SHAdviceHealthViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-23.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHShareView.h"

@interface SHAdviceHealthViewController : SHTableViewController<SHTaskDelegate>
{
    
    __weak IBOutlet UILabel *mLabTitle;
    __weak IBOutlet UITextView *txtContent;
    __strong IBOutlet   SHShareView* mViewShare;
    NSDictionary * mResult;
}

@end
