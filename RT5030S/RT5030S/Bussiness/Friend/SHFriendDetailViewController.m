//
//  SHFriendDetailViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-21.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHFriendDetailViewController.h"

@interface SHFriendDetailViewController ()

@end

@implementation SHFriendDetailViewController
// message 好友申请列表
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"详细资料";
    [mImgPhoto setCircleStyle:nil];
    mBtnAdd.layer.cornerRadius = 3;
    mBtnAdd.layer.masksToBounds = YES;
    mBtnRefuse.layer.cornerRadius = 3;
    mBtnRefuse.layer.masksToBounds = YES;
    [self request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) request
{
    
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:[self.intent.args objectForKey:@"userId"] forKey:@"targetId"];//(mSearchView.text == nil ? @"" : mSearchView.text )
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"memberInfoQuery.jhtml");
    //    post.cachetype = CacheTypeTimes;
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        mResult = [[task result]mutableCopy];
        [mImgPhoto setUrl:[mResult objectForKey:@"headImg"]];
        mLabName.text = [mResult objectForKey:@"nickName"];
        mlabAccout.text = [mResult objectForKey:@"username"];
        mLabAddress.text = [mResult objectForKey:@"area"];
        mLabWeight.text = [[mResult objectForKey:@"targetWeight"]stringValue];
        mLabFatRate.text = [[mResult objectForKey:@"targetCalorie"]stringValue];
        if ([[mResult objectForKey:@"friend"]boolValue]) {
            mBtnRefuse.hidden = YES;
            mBtnAdd.hidden = YES;
        }else{
            mBtnAdd.hidden = NO;
            if([[self.intent.args objectForKey:@"classType"] isEqualToString:@"message"]){
                mBtnRefuse.hidden = NO;
            }else{
                mBtnRefuse.hidden = YES;
            }
            
        }
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
}
- (IBAction)btnAddOntouch:(id)sender {
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:[mResult objectForKey:@"userId"] forKey:@"friendId"];
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    if([[self.intent.args objectForKey:@"classType"] isEqualToString:@"message"]){// 申请
        post.URL = URL_FOR(@"passFriend.jhtml");
        [dic setValue:@"0" forKey:@"type"];// 通过
    }else{
        post.URL = URL_FOR(@"applyFriend.jhtml");
    }
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
        if ([[self.intent.args objectForKey:@"classType"] isEqualToString:@"message"]) {
            [self readMessage];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
}

- (IBAction)btnRefuseOntouch:(id)sender {
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:[mResult objectForKey:@"userId"] forKey:@"friendId"];
    [dic setValue:@"1" forKey:@"type"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"passFriend.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
        if ([[self.intent.args objectForKey:@"classType"] isEqualToString:@"message"]) {
            [self readMessage];
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
}
-(void) readMessage
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:[self.intent.args objectForKey:@"msgId"] forKey:@"msgId"];
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"readMsg.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
}
@end
