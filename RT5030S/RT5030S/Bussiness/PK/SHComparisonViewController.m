//
//  SHComparisonViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-23.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHComparisonViewController.h"

@interface SHComparisonViewController ()

@end

@implementation SHComparisonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [imgMy setCircleStyle:[SHSkin.instance colorOfStyle:@"ColorTextBlue"]];
    [imgOther setCircleStyle:[SHSkin.instance colorOfStyle:@"ColorTextOrg"]];
    self.title = @"比一比";
    [self requestOpponent];
}
-(void) requestOpponent
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:[self.intent.args objectForKey:@"userId"] forKey:@"targetId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"opponentCompare.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        mResult = [[task result]mutableCopy];
        NSDictionary * myDic = [mResult objectForKey:@"my"];
        [imgMy setUrl:[myDic objectForKey:@"headImg"]];
        mLabName1.text = [myDic objectForKey:@"nickName"];
        mLabWeight1.text = [NSString stringWithFormat:@"%dKg",[[myDic objectForKey:@"weight"]intValue]/1000];
        mLabFatRate1.text = [[myDic objectForKey:@"fat"]stringValue];
        mLabCalorie1.text = [NSString stringWithFormat:@"%@",[myDic objectForKey:@"calorie"]];
        
        mLabScore1.text = [[myDic objectForKey:@"score"]stringValue];
        
        NSDictionary * targetDic = [mResult objectForKey:@"target"];
        [imgOther setUrl:[targetDic objectForKey:@"headImg"]];
        mLabName2.text = [targetDic objectForKey:@"nickName"];
        mLabWeight2.text = [NSString stringWithFormat:@"%dKg",[[targetDic objectForKey:@"weight"]intValue]/1000];
        mLabFatRate2.text = [[targetDic objectForKey:@"fat"]stringValue];
        mLabCalorie2.text = [NSString stringWithFormat:@"%@",[targetDic objectForKey:@"calorie"]];
        
        mLabScore2.text = [[targetDic objectForKey:@"score"]stringValue];
        
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
        //        [task.respinfo show];
        [self showAlertDialog:task.respinfo.message];
    }];
}
-(void) requestTarget
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:[self.intent.args objectForKey:@"userId"] forKey:@"targetId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"targetCompare.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        mResult = [[task result]mutableCopy];
        NSDictionary * myDic = [mResult objectForKey:@"my"];
        [imgMy setUrl:[myDic objectForKey:@"headImg"]];
        mLabName1.text = [myDic objectForKey:@"nickName"];
        mLabWeight1.text = [NSString stringWithFormat:@"%dKg",[[myDic objectForKey:@"weight"]intValue]/1000];
        mLabFatRate1.text = [[myDic objectForKey:@"calorie"]stringValue];
        mLabCalorie1.text = [NSString stringWithFormat:@"%@",[myDic objectForKey:@"calorie"]];
        
        mLabScore1.text = [[myDic objectForKey:@"score"]stringValue];
        
        NSDictionary * targetDic = [mResult objectForKey:@"target"];
        imgOther.image  = [UIImage imageNamed:@"mubiao_icon"];
        mLabName2.text = @"目标";
        mLabWeight2.text = [NSString stringWithFormat:@"%dKg",[[targetDic objectForKey:@"weight"]intValue]/1000];
        mLabFatRate2.text = [[targetDic objectForKey:@"calorie"]stringValue];
        mLabToTarget.text = [NSString stringWithFormat:@"%dKg",[[myDic objectForKey:@"toTargetWeight"]intValue]/1000];
        
        
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
        //        [task.respinfo show];
        [self showAlertDialog:task.respinfo.message];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)mSegmentTouch:(UISegmentedControl *)sender {
    [self segmentAction:sender animation:YES];
}

- (IBAction)btnShareOntouch:(UIButton *)sender {
    NSString * content = @"#比一比#我在使用荣泰RT5030享秀派，看这是我跟好友的PK目标，你快来监督我们吧！ @荣泰健康科技官方微博";
    
    WBMessageObject *message = [WBMessageObject message];
    //    message.text=_sharedContent;
    message.text = content;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    request.shouldOpenWeiboAppInstallPageIfNotInstalled = YES;
    [WeiboSDK sendRequest:request];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:content forKey:@"content"];
    [dic setValue:@"2" forKey:@"type"];// 0weix 1 qq 2weibo 3qqweibo
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"share.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start];
}
-(void)segmentAction:(UISegmentedControl *)Seg animation :(BOOL) animation
{
    NSInteger index = Seg.selectedSegmentIndex;
    if(animation){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.0];
    }
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:imgCricle2 cache:YES];
    switch (index) {
        case 0:
            
            mLabDate2.text = @"今日";
            mLabFat1.text = @"脂肪";
            mLabFat2.text = @"脂肪";
            mViewOther.hidden = NO;
            mViewTarget.hidden = YES;
            [self requestOpponent];
            break;
        case 1:
            mLabName2.text = @"目标";
            mLabDate2.text = @"我的目标";
            mLabFat1.text = @"卡路里";
            mLabFat2.text = @"卡路里";
            mViewOther.hidden = YES;
            mViewTarget.hidden = NO;
            
            [self requestTarget];
            break;
            
        default:
            break;
    }
    if(animation){
        [UIView commitAnimations];
    }
}

@end
