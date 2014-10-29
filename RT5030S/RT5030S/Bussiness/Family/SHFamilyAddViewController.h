//
//  SHFamilyAddViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-10-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHSexSelectViewController.H"
@class SHFamilyAddViewController;
@protocol SHFamilyAddViewControllerDelegate <NSObject>

-(void) familyAddViewControllerAddSuccessful:(SHFamilyAddViewController *)control;

@end
@interface SHFamilyAddViewController : SHTableViewController<SHTaskDelegate,SHSexSelectViewControllerDelegate>
{
    
    __weak IBOutlet UITextField *mTxtName;
    __weak IBOutlet UITextField *mTxtSex;
    __weak IBOutlet UITextField *mTxtBrith;
    __weak IBOutlet UITextField *mTxtHeight;
}
@property (nonatomic,assign) id<SHFamilyAddViewControllerDelegate> delegate;
- (IBAction)btnComfrieOntouch:(id)sender;

@end
