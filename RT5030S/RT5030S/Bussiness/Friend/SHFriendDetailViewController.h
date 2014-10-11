//
//  SHFriendDetailViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-21.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHFriendDetailViewController : SHTableViewController
{
    
    __weak IBOutlet SHImageView *mImgPhoto;
    __weak IBOutlet UILabel *mLabName;
    __weak IBOutlet UILabel *mlabAccout;
    __weak IBOutlet UILabel *mLabAddress;
    __weak IBOutlet UILabel *mLabWeight;
    __weak IBOutlet UILabel *mLabFatRate;
    __weak IBOutlet UIButton *mBtnAdd;
    __weak IBOutlet UIButton *btnRefuse;
}
- (IBAction)btnAddOntouch:(id)sender;
- (IBAction)btnRefuseOntouch:(id)sender;

@end
