//
//  SHRecordViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHRecordViewController : SHTableViewController<SHTaskDelegate>
{
    NSDictionary * mResult;
    NSString * totalDays;
}

@end
