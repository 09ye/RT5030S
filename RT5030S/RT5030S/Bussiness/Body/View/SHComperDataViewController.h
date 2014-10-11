//
//  SHComperDataViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-26.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHComperDataViewController : SHTableViewController<SHTableHorizontalViewDataSource,SHTableHorizontalViewDelegate>
{
    __weak IBOutlet UILabel *mLabWeightToday;
    
    __weak IBOutlet UILabel *mLabCalrioToday;
    __weak IBOutlet UILabel *mLabWegithWeek;
    __weak IBOutlet UILabel *mLabCalrioWeek;
    __weak IBOutlet UILabel *mLabFreq;
    __weak IBOutlet SHTableHorizontalView *mViewWeek;
    int  selectWeek;
}
@property(nonatomic,retain) UINavigationController *navigationCont; // If this view controller has been pushed onto a navigation controller, return it.
- (IBAction)btnCreateDataReportOntouch:(id)sender;

@end
