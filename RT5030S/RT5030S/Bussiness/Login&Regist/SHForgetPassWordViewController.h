//
//  SHForgetPassWordViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHForgetPassWordViewController : SHTableViewController<SHTaskDelegate>
{
    __weak IBOutlet UITextField *mLabEmail;
    
    __weak IBOutlet UITextField *mLabVerilication;
     NSString * verificationCode;
}
- (IBAction)btnVerificationOntouch:(id)sender;
- (IBAction)btnGetPasswordOntouch:(id)sender;
@end
