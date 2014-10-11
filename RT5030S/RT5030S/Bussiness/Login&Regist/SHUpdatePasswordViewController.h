//
//  SHUpdatePasswordViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-10-9.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHUpdatePasswordViewController : SHTableViewController<SHTaskDelegate>
{
    __weak IBOutlet UITextField *txtOldPass;
    
    __weak IBOutlet UITextField *txtNewPass1;
    __weak IBOutlet UITextField *txtNewPass2;
    __weak IBOutlet UIButton *btnCommit;
}
- (IBAction)btnCommitOntouch:(id)sender;

@end
