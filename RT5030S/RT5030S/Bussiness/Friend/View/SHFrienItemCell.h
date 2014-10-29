//
//  SHFrienItemCell.h
//  RT5030S
//
//  Created by yebaohua on 14-9-21.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHFrienItemCell : SHTableViewCell
@property (weak, nonatomic) IBOutlet SHImageView *imgPhoto;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labRank;
@property (weak, nonatomic) IBOutlet UIButton *btnAddFriend;
@property (weak, nonatomic) IBOutlet UILabel *labTargetTitle;
@property (weak, nonatomic) IBOutlet UILabel *labTargetCalrio;
@property (nonatomic,strong) NSDictionary* detail;
@property (weak, nonatomic) IBOutlet UIButton *btnPk;
- (IBAction)btnAddFriendOntouch:(UIButton *)sender;


@end
