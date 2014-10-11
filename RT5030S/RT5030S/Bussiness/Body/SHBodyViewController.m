//
//  SHBodyViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-25.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHBodyViewController.h"


@interface SHBodyViewController ()

@end

@implementation SHBodyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mViewBodyMode = [[SHBodyModeViewController alloc]init];
    mViewRealData = [[SHRealDataViewController alloc]init];
    mViewComperData = [[SHComperDataViewController alloc]init];
    mViewComperData.navigationCont = self.navigationController;
    [mViewContain addSubview:mViewBodyMode.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnTopTabOntohc:(UIButton *)sender{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
     [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:mViewContain cache:YES];
    switch (sender.tag) {
        case 0:
            [mbtnMode setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
            [mbtnRealData setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnDataComper setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            
            [mViewRealData.view removeFromSuperview];
            [mViewComperData.view removeFromSuperview];
             mViewBodyMode.view.frame = mViewContain.bounds;
            [mViewContain addSubview:mViewBodyMode.view];
            break;
        case 1:
            [mbtnMode setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnRealData setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
            [mbtnDataComper setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            
            [mViewBodyMode.view removeFromSuperview];
            [mViewComperData.view removeFromSuperview];
             mViewRealData.view.frame = mViewContain.bounds;
            [mViewContain addSubview:mViewRealData.view];
            break;
        case 2:
            [mbtnMode setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnRealData setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnDataComper setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
            [mViewBodyMode.view removeFromSuperview];
            [mViewRealData.view removeFromSuperview];
            mViewComperData.view.frame = mViewContain.bounds;
            [mViewContain addSubview:mViewComperData.view];
            break;
            
        default:
            break;
    }

    [UIView commitAnimations];

    

}

@end
