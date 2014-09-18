//
//  LoginViewController.h
//  
//
//  Created by sheely on 13-9-9.
//
//

#import "SHViewController.h"

@interface SHLoginViewController : SHViewController<SHTaskDelegate,UITextFieldDelegate>
{

    __weak IBOutlet UIButton *mBtnLogin;
    __weak IBOutlet UITextField *mTxtName;
    __weak IBOutlet UITextField *mTxtPassword;
   
}
- (IBAction)btnResigtOntouch:(id)sender;
- (IBAction)btnForgotPassOntouch:(id)sender;
- (IBAction)btnQQloginOntouch:(id)sender;
- (IBAction)btnWeiboOntouch:(id)sender;

- (IBAction)btnLoginOnTouch:(id)sender;
- (IBAction)tapOnTouch:(id)sender;
@end
