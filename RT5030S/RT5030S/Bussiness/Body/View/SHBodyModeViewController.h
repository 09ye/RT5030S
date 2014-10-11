//
//  SHBodyModeViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-25.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHBodyModeViewController : SHTableViewController
{
    __weak IBOutlet UISwitch *mSwitchYun;
    
    __weak IBOutlet UISwitch *mSwitchHand;
}
- (IBAction)switchOntouch:(UISwitch *)sender;


@end
