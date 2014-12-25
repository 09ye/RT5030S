//
//  SHFamilyAddViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-10-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHFamilyAddViewController.h"

@interface SHFamilyAddViewController ()

@end

@implementation SHFamilyAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加家庭成员";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnComfrieOntouch:(id)sender {
    if ([mTxtName.text isEqualToString:@""]) {
        [self showAlertDialog:@"昵称不能为空"];
        return;
    }
    if ([mTxtSex.text isEqualToString:@""]) {
        [self showAlertDialog:@"性别不能为空"];
        return;
    }
    if ([mTxtBrith.text isEqualToString:@""]) {
        [self showAlertDialog:@"出生日期不能为空"];
        return;
    }
    if (mTxtBrith.text.length !=8) {
        [self showAlertDialog:@"出生日期格式错误"];
        return;
    }
    if ([mTxtHeight.text isEqualToString:@""] ||mTxtHeight.text.intValue<=0) {
        [self showAlertDialog:@"身高不能为空"];
        return;
    }
    [self showWaitDialogForNetWork];
     NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
     [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
     [dic setValue:mTxtName.text forKey:@"familyName"];
    [dic setValue:mTxtBrith forKey:@"birthday"];
    if ([mTxtSex.text isEqualToString:@"男"]) {
        [dic setValue:@"M" forKey:@"gender"];
    }else{
        [dic setValue:@"F" forKey:@"gender"];
    }
    [dic setValue:[NSNumber numberWithInt:[mTxtHeight.text integerValue]*10] forKey:@"height"];
     SHPostTaskM * post = [[SHPostTaskM alloc]init];
     post.URL = URL_FOR(@"addFamily.jhtml");
     post.postData = [Utility createPostData:dic];
     post.delegate = self;
     [post start:^(SHTask *task) {
         [self dismissWaitDialog];
//         [task.respinfo show];
          [self showAlertDialog:task.respinfo.message];
         if (self.delegate && [self.delegate respondsToSelector:@selector(familyAddViewControllerAddSuccessful:)]) {
             [self.delegate familyAddViewControllerAddSuccessful:self];
         }
         [self.navigationController popViewControllerAnimated:YES];

    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
    
}
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField != mTxtSex ){
        return YES;
    }
    if(textField == mTxtSex){
        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHSexSelectViewController";
        [intent.args setValue:@"M" forKey:@"sex"];
        intent.container = self.navigationController;
        intent.delegate = self;
        [[UIApplication sharedApplication] open:intent];
    }
    return NO;
}
-(void)sexSelectViewControllerDidSelect:(SHSexSelectViewController *) controll sex:(NSString * )sex
{
    if ([sex isEqualToString:@"M"]) {
        mTxtSex.text = @"男";
    }else{
        mTxtSex.text = @"女";
    }
    
}
@end
