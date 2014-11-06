//
//  SHDepthReportViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-23.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHDepthReportViewController.h"

@interface SHDepthReportViewController ()

@end

@implementation SHDepthReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"深度报告";
    mViewShare.shareContent = @"#阶段报告#我在使用荣泰RT5030享秀派，看这是我的阶段报告，在这里我可以检测体重和体质，你快来加入我们吧！ @荣泰健康科技官方微博";
    [self request];
}
-(void) request
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"deepWeightQuery.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        mResult = [[task result]mutableCopy];
        if(![[mResult objectForKey:@"beforeDate"] isEqualToString:@""]){
            NSDateFormatter * format = [[NSDateFormatter alloc]init];
            [format setDateFormat:@"yyyyMMdd"];
            NSDate * date = [format dateFromString:[mResult objectForKey:@"beforeDate"]];
            [format setDateFormat:@"MM月dd日"];
            mLabBeforeDate.text = [format stringFromDate:date];
        }
        mLabBeforeDay.text = [NSString stringWithFormat:@"%@天前",[mResult objectForKey:@"beforeDays"]];
        mLabWeight.text = [NSString stringWithFormat:@"%dKg",[[mResult objectForKey:@"weight"]intValue]/1000 ];
        mLabFat.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"fat"],@"%"];
        mLabWater.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"water"],@"%"];
        mLabMuscle.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"muscle"],@"%"];
        mLabLiver.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"liver"],@"%"];
        mLabBase.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"metabolism"],@"%"];
        mLabProtein.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"protein"],@"%"];
        mLabBone.text = [NSString stringWithFormat:@"%@%@",[mResult objectForKey:@"bone"],@"%"];
        [mBtnUseDay setTitle:[NSString stringWithFormat:@"使用%@天",[mResult objectForKey:@"useDays"]] forState:UIControlStateNormal];
        mLabStander.text = [mResult objectForKey:@"statusName"];
        if([[mResult objectForKey:@"useDays"]intValue] <2){
            mBtnReport.enabled  = NO;
        }
        

        
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


- (IBAction)btnPhaseReportOntouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHPhaseReportViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnRunOntouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHAdviceHealthViewController";
    [intent.args setValue:@"1" forKey:@"classType"];
     [intent.args setValue:@"1" forKey:@"state"];
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnDietOntouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHAdviceHealthViewController";
    [intent.args setValue:@"2" forKey:@"classType"];
     [intent.args setValue:@"1" forKey:@"state"];
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}
@end
