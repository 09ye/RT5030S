//
//  SHSexSelectViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-10-8.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
@class SHSexSelectViewController;
@protocol SHSexSelectViewControllerDelegate <NSObject>

-(void)sexSelectViewControllerDidSelect:(SHSexSelectViewController *) controll sex:(NSString * )sex;

@end
@interface SHSexSelectViewController : SHTableViewController
@property (nonatomic,strong) NSString * sex;
@property(nonatomic,assign) id<SHSexSelectViewControllerDelegate> delegate;
@end
