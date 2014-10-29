//
//  SHRecordViewCell.h
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHRecordViewCell : SHTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labYear;
@property (weak, nonatomic) IBOutlet UILabel *labWeight;
@property (weak, nonatomic) IBOutlet UILabel *labCalorie;
@property (weak, nonatomic) IBOutlet UIView *viewLine;
@property (weak, nonatomic) IBOutlet UIView *viewLine2;

@end
