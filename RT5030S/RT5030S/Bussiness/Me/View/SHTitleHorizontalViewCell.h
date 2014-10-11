//
//  SHTitleHorizontalViewCell.h
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHTitleHorizontalViewCell : SHTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet SHImageView *imgPhone;

@property (weak, nonatomic) IBOutlet UITextField *txtContent;

-(void) setEditing:(BOOL)editing;
@end
