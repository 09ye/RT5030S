//
//  SHMessageViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-10-15.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHMessageViewController : SHTableViewController<SHTaskDelegate>
{
    
}

@property(nonatomic,strong) UINavigationController *navController; // If this view controller has been pushed onto a navigation controller, return it.
@end
