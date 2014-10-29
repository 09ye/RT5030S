//
//  SHShareView.m
//  RT5030S
//
//  Created by yebaohua on 14-9-24.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHShareView.h"

@implementation SHShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)loadSkin
{

    self.backgroundColor = [UIColor clearColor];
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.transform = CGAffineTransformTranslate(self.transform, -72, 0);
    
}

- (void)showIn:(UIView *)view :(CGRect)rect
{
    if(!mIsShow){
        mIsShow = YES;
        [UIView animateWithDuration:0.7 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformTranslate(self.transform, 72,0);
        } completion:^(BOOL finished) {

        }];
    }
    
}

- (void)close
{
    if(mIsShow){
        mIsShow = NO;
        [UIView animateWithDuration:0.7 delay:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformTranslate(self.transform, -72,0);
        } completion:^(BOOL finished) {

        }];
        
    }
}
- (IBAction)btnShareWeixinOntouch:(id)sender {
    [self weixinShareAction];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:self.shareContent forKey:@"content"];
    [dic setValue:@"0" forKey:@"type"];// 0weix 1 qq 2weibo 3qqweibo
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"share.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start];

    
}

- (IBAction)btnShareWeiboOntouch:(id)sender {
    [self sinaShareAction];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:self.shareContent forKey:@"content"];
    [dic setValue:@"2" forKey:@"type"];// 0weix 1 qq 2weibo 3qqweibo
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"share.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start];
}

- (IBAction)btnShareOntouch:(id)sender;
{
    if (!mIsShow) {
        mIsShow = true;
        [UIView animateWithDuration:0.7 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformTranslate(self.transform, 72,0);
        } completion:^(BOOL finished) {
            
        }];
    }else{
         mIsShow = false;
        [UIView animateWithDuration:0.7 delay:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformTranslate(self.transform, -72,0);
        } completion:^(BOOL finished) {
           
        }];
    }
}
#pragma  mark  Weixin Sina 分享 ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

-(void)weixinShareAction{
    
    NSLog(@"weixin  share");
    
    if ([WXApi isWXAppInstalled]) {
        
        //弹出提示 分享到 朋友圈   等需要注意的是，SendMessageToWXReq的scene成员，如果scene填WXSceneSession，那么消息会发送至微信的会话内。如果scene填WXSceneTimeline，那么消息会发送至朋友圈。如果scene填WXSceneFavorite,那么消息会发送到“我的收藏”中。scene默认值为WXSceneSession。
        AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
        UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles: @"分享到朋友会话",@"分享到朋友圈",@"分享到我的收藏", nil];
        choiceSheet.tag=999;
        [choiceSheet showInView:app.viewController.view];
        
    }else{
        [self showAlertDialog:@"没有安装app,请先安装微信!"];
    }
    
}



#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    /*
     WXSceneSession  = 0,       *< 聊天界面
     WXSceneTimeline = 1,        *< 朋友圈
     WXSceneFavorite = 2,        *< 收藏
     */

//    self.shareContent = @"来自来伊份的分享";
    AppDelegate  *dd=(AppDelegate *)[UIApplication sharedApplication].delegate;
    if (buttonIndex == 0) {
        [dd changeScene:0 ];
        // 发送分享
        [dd sendTextContent:self.shareContent];
    } else if (buttonIndex == 1) {
        
        [dd changeScene:WXSceneTimeline ];
        // 发送分享
        [dd sendTextContent:self.shareContent];
    }else if (buttonIndex == 2){
        [dd changeScene:WXSceneFavorite ];
        // 发送分享
        [dd sendTextContent:self.shareContent];
    }
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}




#pragma  mark  lqh77 微博 分享信息设置

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    //    message.text=_sharedContent;
    message.text = self.shareContent;
    
    return message;
}

-(void)sinaShareAction{
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    request.shouldOpenWeiboAppInstallPageIfNotInstalled = YES;
    [WeiboSDK sendRequest:request];
    
    
}

@end
