//
//  SHFriendListViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-21.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHFriendListViewController : SHTableViewController
{

    __weak IBOutlet UIButton *btnButtomAdd;
    
}

- (IBAction)btnBottomAddOntouch:(id)sender;

@end
