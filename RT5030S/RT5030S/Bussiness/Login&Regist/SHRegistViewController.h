//
//  SHRegistViewController.h
//  offer_neptune
//
//  Created by yebaohua on 14-6-10.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@interface SHRegistViewController : SHViewController<SHTaskDelegate,UITextFieldDelegate>
{
    __weak IBOutlet UITextField *labPhone;
    __weak IBOutlet UITextField *labValidate;
    __weak IBOutlet UITextField *labPassword;
    __weak IBOutlet UIImageView *imgAgree;
    __weak IBOutlet UISwitch *mSwitch;
    __weak IBOutlet UILabel *labAgreement;
    BOOL imageFlag;
    __weak IBOutlet UIView *mView_1;
    __weak IBOutlet UIView *mView_2;
    __weak IBOutlet UIView *mView_3;
    __weak IBOutlet UIButton *mView_validate;
    __weak IBOutlet UIButton *mBtn_submit;

}
- (IBAction)validateOnTouch:(id)sender;
- (IBAction)submitOnTouch:(id)sender;
- (IBAction)switchOnTouch:(id)sender;

@end
