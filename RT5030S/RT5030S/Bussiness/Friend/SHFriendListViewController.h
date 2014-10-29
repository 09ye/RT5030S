//
//  SHFriendListViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-21.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHFamilyAddViewController.h"
@class SHFriendListViewController;
@protocol SHFriendListViewControllerDelegate <NSObject>

-(void) friendListViewControllerPkAddSuccessful:(SHFriendListViewController *)control type:(int) index;

@end
@interface SHFriendListViewController : SHTableViewController<SHTaskDelegate,SHFamilyAddViewControllerDelegate>
{

    __weak IBOutlet UIButton *btnButtomAdd;
    
}
@property (nonatomic,assign) id<SHFriendListViewControllerDelegate> delegate;
- (IBAction)btnBottomAddOntouch:(id)sender;

@end
