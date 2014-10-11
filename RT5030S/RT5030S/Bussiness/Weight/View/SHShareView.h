//
//  SHShareView.h
//  RT5030S
//
//  Created by yebaohua on 14-9-24.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHView.h"

@interface SHShareView : SHView<UIActionSheetDelegate>
{
    BOOL mIsShow;
   
 
}

@property (weak, nonatomic) IBOutlet UIView *backGround;
@property (nonatomic,strong) NSString * shareContent; //微博 微信要分享的 内容


- (IBAction)btnShareWeixinOntouch:(id)sender;
- (IBAction)btnShareWeiboOntouch:(id)sender;
- (IBAction)btnShareOntouch:(id)sender;

- (void)showIn:(UIView *) view :(CGRect) rect;

- (void)close;
@end
