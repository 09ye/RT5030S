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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)mSegmentTouch:(UISegmentedControl *)sender {
    [self segmentAction:sender animation:YES];
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
            mLabName2.text = @"xxx";
            mLabDate2.text = @"今日";
            mLabFat1.text = @"脂肪";
            mLabFat2.text = @"脂肪";
            mViewOther.hidden = NO;
            mViewTarget.hidden = YES;
            mLabCalorie2.text = @"1000卡";
            break;
        case 1:
            mLabName2.text = @"目标";
            mLabDate2.text = @"我的目标";
            mLabFat1.text = @"卡路里";
            mLabFat2.text = @"卡路里";
            mViewOther.hidden = YES;
            mViewTarget.hidden = NO;
            mLabCalorie2.text = @"99Kg";
            break;
            
        default:
            break;
    }
    if(animation){
        [UIView commitAnimations];
    }
}

@end
