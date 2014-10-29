//
//  SHPKViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-24.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHFriendListViewController.h"

@interface SHPKViewController : SHTableViewController<SHTaskDelegate,SHFriendListViewControllerDelegate>
{
    __weak IBOutlet UIButton *mbtnTab1;

    __weak IBOutlet UIButton *mbtnTab2;
    int type ;
}
- (IBAction)btnTabOntouch:(UIButton *)sender;

- (IBAction)btnAddOntouch:(UIButton *)sender;
@end
