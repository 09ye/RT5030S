//
//  SHPhotoImgCell.m
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHPhotoImgCell.h"

@implementation SHPhotoImgCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)loadSkin
{
    [super loadSkin];
    [self.imgPhoto setCircleStyle:nil];
}
@end
