//
//  SHPhaseReportViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-24.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "PNChart.h"
#import "SHCalendarViewController.h"

@interface SHPhaseReportViewController : SHTableViewController<SHCalendarViewControllerDelegate,SHTaskDelegate>
{
    
    __weak IBOutlet UILabel *mLabTitle;
    __weak IBOutlet UIImageView *imgTitle;
    __weak IBOutlet UIButton *mbtnTab1;
    __weak IBOutlet UIButton *mbtnTab2;
    __weak IBOutlet UIButton *mbtnTab3;
    __weak IBOutlet UIButton *mbtnTab4;
    __weak IBOutlet UIView *mViewContain;
    __weak IBOutlet UISegmentedControl *mSegment;
    __weak IBOutlet UILabel *mLabCalendarDate;
    __weak IBOutlet UILabel *mLabCriLeftContent;
    __weak IBOutlet UILabel *mLabCriLeftTitle;
    __weak IBOutlet UILabel *mLabCriMidContent;
    __weak IBOutlet UILabel *mLabCriMidTitle;
    __weak IBOutlet UILabel *mLabCriRightContent1;
      __weak IBOutlet UILabel *mLabCriRightContent2;
    __weak IBOutlet UILabel *mLabCriRightTitle;
    __weak IBOutlet UIView *mViewChart;
    
    
    PNChart * lineChart ;
    SHCalendarViewController * mStartDatecontroller;
    int tabType;
    NSDictionary * mResult;
    
}
- (IBAction)btnTopTabOntohc:(id)sender;
- (IBAction)segmentOntouch:(id)sender;
- (IBAction)btnCalender:(id)sender;

@end
