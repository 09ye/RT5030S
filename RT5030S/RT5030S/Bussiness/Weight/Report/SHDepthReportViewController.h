//
//  SHDepthReportViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-23.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHShareView.h"

@interface SHDepthReportViewController : SHTableViewController
{
       __strong IBOutlet   SHShareView* mViewShare;
}
- (IBAction)btnPhaseReportOntouch:(id)sender;
- (IBAction)btnRunOntouch:(id)sender;
- (IBAction)btnDietOntouch:(id)sender;

@end
