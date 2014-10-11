//
//  LoginViewController.h
//  
//
//  Created by sheely on 13-9-9.
//
//

#import "SHViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface SHLoginViewController : SHViewController<SHTaskDelegate,UITextFieldDelegate,TencentSessionDelegate>
{

    __weak IBOutlet UIButton *mBtnLogin;
    __weak IBOutlet UITextField *mTxtName;
    __weak IBOutlet UITextField *mTxtPassword;
    TencentOAuth * _tencentOAuth;
    NSMutableArray* _permissions;
   
}
- (IBAction)btnResigtOntouch:(id)sender;
- (IBAction)btnForgotPassOntouch:(id)sender;
- (IBAction)btnQQloginOntouch:(id)sender;
- (IBAction)btnWeiboOntouch:(id)sender;

- (IBAction)btnLoginOnTouch:(id)sender;
- (IBAction)tapOnTouch:(id)sender;
@end
