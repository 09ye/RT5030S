//
//  SHFeedBackViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHFeedBackViewController : SHTableViewController<SHTaskDelegate>
{
    
    __weak IBOutlet UITextView *mTxtContent;
    __weak IBOutlet UITextField *mtxtPhone;
}

@end
