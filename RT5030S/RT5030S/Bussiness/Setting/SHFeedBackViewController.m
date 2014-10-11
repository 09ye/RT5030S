//
//  SHFeedBackViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHFeedBackViewController.h"

@interface SHFeedBackViewController ()

@end

@implementation SHFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundGray"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithSubmit:self action:@selector(subimitOntouch)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) subimitOntouch
{
    
}

@end
