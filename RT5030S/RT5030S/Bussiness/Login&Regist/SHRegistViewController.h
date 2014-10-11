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
    __weak IBOutlet UITextField *labPassOne;
    __weak IBOutlet UITextField *labPassTwo;
    BOOL imageFlag;
    BOOL registType;
    NSString * verificationCode;
    __weak IBOutlet UIButton *mBtn_submit;

    __weak IBOutlet UIButton *btnVerification;
    __weak IBOutlet UIButton *mBtnEmail;
    __weak IBOutlet UIButton *mBtnPhone;
    __weak IBOutlet UIButton *mBtnAgree;
}
- (IBAction)submitOnTouch:(id)sender;
- (IBAction)btnEmailResgitOntouch:(id)sender;
- (IBAction)btnPhoneResgitOntouch:(id)sender;
- (IBAction)btnVerificationOntouch:(id)sender;
- (IBAction)btnAgreeOntouch:(id)sender;
- (IBAction)btnReadAgreementOntouch:(id)sender;

@end
