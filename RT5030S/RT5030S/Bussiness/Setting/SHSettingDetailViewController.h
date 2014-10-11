//
//  SHSettingDetailViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHSettingDetailViewController : SHTableViewController
{
    
    __weak IBOutlet UISwitch *mSwitchAutolink;
    __weak IBOutlet UISwitch *mSwitchSearch;
    __weak IBOutlet UISwitch *mSwitchAutoLogin;
}
- (IBAction)switchSearchOntouch:(id)sender;
- (IBAction)switchAutolinkOntouch:(id)sender;
- (IBAction)switchAutoLoginOntouch:(id)sender;



@end
