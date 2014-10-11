//
//  SHFrienItemCell.m
//  RT5030S
//
//  Created by yebaohua on 14-9-21.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHFrienItemCell.h"

@implementation SHFrienItemCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) loadSkin
{
    [super loadSkin];
    [self.imgPhoto setCircleStyle:nil];
}
@end
