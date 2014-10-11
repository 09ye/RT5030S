//
//  SHRealDataViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-26.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHRealDataViewController.h"

@interface SHRealDataViewController ()

@end

@implementation SHRealDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:NOTIFICATION_BLUETOOTH_DATA_UPDATE object:nil];
}
-(void)notification:(NSNotification *) noti
{
    if ([noti.name isEqualToString:NOTIFICATION_BLUETOOTH_DATA_UPDATE]){
        NSDictionary * temp=[noti object];
        NSArray * array = [temp objectForKey:@"data"];
        mLabCalrio.text = [[array objectAtIndex:1]stringValue];
        mLabUserTime.text = [[array objectAtIndex:7]stringValue];
        mLabFreq.text = [[array objectAtIndex:5]stringValue];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnMusSelectOntouch:(id)sender {
}
@end
