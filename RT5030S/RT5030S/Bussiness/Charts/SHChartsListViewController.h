//
//  SHChartsListViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-24.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHChartsListViewController : SHTableViewController<SHTaskDelegate>
{
    __weak IBOutlet UIButton *mbtnTab1;
    __weak IBOutlet UIButton *mbtnTab2;
    __weak IBOutlet UIButton *mbtnTab3;
    __weak IBOutlet SHImageView *imgPhoto;
    __weak IBOutlet UILabel *mLabRank;
    int type;
    
}
- (IBAction)btnTopTabOntohc:(UIButton *)sender;

@end
