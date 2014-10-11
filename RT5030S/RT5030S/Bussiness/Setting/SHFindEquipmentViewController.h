//
//  SHFindEquipmentViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHFindEquipmentViewController : SHTableViewController
{
    __weak IBOutlet UILabel *mLabState;
    __weak IBOutlet UISwitch *mSwitchAutoLink;
    __weak IBOutlet UISwitch *mSwitchLinkEqu;
}
- (IBAction)btnEquipmentListOntouch:(id)sender;
- (IBAction)switchAutoLinkOntouch:(UISwitch *)sender;
- (IBAction)switchLinkEquOntouch:(UISwitch *)sender;
@end
