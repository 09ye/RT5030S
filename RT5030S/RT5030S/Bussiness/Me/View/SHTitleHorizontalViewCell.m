//
//  SHTitleHorizontalViewCell.m
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTitleHorizontalViewCell.h"

@implementation SHTitleHorizontalViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)loadSkin
{
    [super loadSkin];
    [self.imgPhone setCircleStyle:nil];
}
-(void) setEditing:(BOOL)editing
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if (editing) {
        self.txtContent.enabled = YES;
        self.txtContent.borderStyle = UITextBorderStyleRoundedRect;
    }else{
        self.txtContent.enabled = NO;
        self.txtContent.borderStyle = UITextBorderStyleNone;
    }
    [UIView commitAnimations];
    
}
@end
