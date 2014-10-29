//
//  SHFrienItemCell.m
//  RT5030S
//
//  Created by yebaohua on 14-9-21.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHFrienItemCell.h"

@implementation SHFrienItemCell
@synthesize detail = _detail;
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
-(void)setDetail:(NSDictionary *)detail_
{
    _detail = detail_;
    [self.imgPhoto setUrl:[detail_ objectForKey:@"headImg"]];
    self.labName.text = [detail_ objectForKey:@"nickName"];
    self.labAddress.text = [detail_ objectForKey:@"area"];
    self.labRank.text = [[detail_ objectForKey:@"rank"]stringValue];
    
    if (![[detail_ allKeys]containsObject:@"friend"] ||[[detail_ objectForKey:@"friend"]boolValue]) {
        self.btnAddFriend.hidden = YES;
    }else{
        self.btnAddFriend.hidden = NO;
    }
    
}
- (IBAction)btnAddFriendOntouch:(UIButton *)sender {
    
}
@end
