//
//  SHRealDataViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-26.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHRealDataViewController : SHTableViewController
{
    __weak IBOutlet UILabel *mLabMusTime;
    
    __weak IBOutlet UILabel *mLabMusName;
    __weak IBOutlet UILabel *mLabCalrio;
    __weak IBOutlet UILabel *mLabUserTime;
    __weak IBOutlet UILabel *mLabFreq;
}
- (IBAction)btnMusSelectOntouch:(id)sender;

@end
