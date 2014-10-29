//
//  SHBodyModeViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-25.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHBodyModeViewController.h"
#import "SHBlueToothManager.h"

@interface SHBodyModeViewController ()

@end

@implementation SHBodyModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForMediaPlayerNotifications];
    MPMediaItem *currentItem = [SHMusicPlayerManager.instance.musicPlayer nowPlayingItem];//获得正在播放的项目
    if (currentItem) {
        mLabMusicTitle.text = [currentItem valueForProperty:MPMediaItemPropertyTitle];//歌曲名称
        mTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerUp:) userInfo:Nil repeats:YES];
    }
}

-(void) selectMusic
{
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc]
                                            initWithMediaTypes:MPMediaTypeMusic];
    if (mediaPicker != nil)
    {
        mediaPicker.delegate = self;
        mediaPicker.allowsPickingMultipleItems = NO;
        [self.navController presentModalViewController:mediaPicker animated:YES];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"媒体选择器"
                                    message:@"媒体选择器初始化失败!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil]show];
    }
}
- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker{
    [mediaPicker dismissModalViewControllerAnimated:YES];
}
- (void)mediaPicker:(MPMediaPickerController *)mediaPicker
  didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection{
    

    MPMediaItem * musicItem = [[mediaItemCollection items] objectAtIndex:0];
    [SHMusicPlayerManager.instance.musicPlayer setQueueWithItemCollection:mediaItemCollection];
    [SHMusicPlayerManager.instance.musicPlayer play];
    
    [mediaPicker dismissModalViewControllerAnimated: YES];//释放选择器
    mLabMusicTitle.text = [musicItem valueForProperty:MPMediaItemPropertyTitle];;
    mTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerUp:) userInfo:Nil repeats:YES];

}
- (void)timerUp:(NSTimer *) timer
{
    
    if(SHMusicPlayerManager.instance.musicPlayer.playbackState==MPMusicPlaybackStateStopped){
        [mTimer invalidate];
        mTimer = nil;
    }else{
        int timeGoes = SHMusicPlayerManager.instance.musicPlayer.currentPlaybackTime;
        mLabMusicTime.text = [self timeStringWithNumber:timeGoes];
    }
    
}
-(NSString*)timeStringWithNumber:(int)theTime
{
    NSString *minutes= [NSString stringWithFormat:@"%d",theTime/60];
    NSString *seconds= [NSString stringWithFormat:@"%d",theTime%60];
    if (minutes.length<2) {
        minutes=[NSString stringWithFormat:@"0%d",theTime/60];
    }
    if (seconds.length<2) {
        seconds=[NSString stringWithFormat:@"0%d",theTime%60];
    }
    return [NSString stringWithFormat:@"%@:%@",minutes,seconds];
}
- (void) registerForMediaPlayerNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_NowPlayingItemChanged)
                               name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                             object: SHMusicPlayerManager.instance.musicPlayer];
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_PlaybackStateChanged)
                               name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
                             object: SHMusicPlayerManager.instance.musicPlayer];
    [SHMusicPlayerManager.instance.musicPlayer beginGeneratingPlaybackNotifications];
}
- (void)handle_NowPlayingItemChanged
{
    MPMediaItem *currentItem = [SHMusicPlayerManager.instance.musicPlayer nowPlayingItem];//获得正在播放的项目
    if (currentItem) {
        mLabMusicTitle.text = [currentItem valueForProperty:MPMediaItemPropertyTitle];//歌曲名称
  
    }
}

- (void)handle_PlaybackStateChanged
{
    MPMusicPlaybackState playbackState = [SHMusicPlayerManager.instance.musicPlayer playbackState];
    if (playbackState == MPMusicPlaybackStatePlaying) {
        mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                        target:self
                                                      selector:@selector(timerUp:)
                                                      userInfo:nil
                                                       repeats:YES];
    } else if (playbackState == MPMusicPlaybackStateStopped) {
        [mTimer invalidate];
        mTimer = nil;
        mLabMusicTime.text = @"00:00";
        [SHMusicPlayerManager.instance.musicPlayer stop];
    }
}


- (IBAction)switchOntouch:(UISwitch *)sender {// 韵律模式 04(自行设置时间） 自动模式03（自行设置时间和频率）
    if(sender.on){
        if(sender == mSwitchYun){
            [mSwitchHand setOn:NO animated:YES];
            [mBtnModeName setTitle:@"韵律模式" forState:UIControlStateNormal];
        }
        else if(sender == mSwitchHand){
            [mSwitchYun setOn:NO animated:YES];
            [mBtnModeName setTitle:@"自动模式" forState:UIControlStateNormal];
        }
    }else {
        if(sender == mSwitchYun){
            [mSwitchHand setOn:YES animated:YES];
            [mBtnModeName setTitle:@"自动模式" forState:UIControlStateNormal];
        }
        else if(sender == mSwitchHand){
            [mSwitchYun setOn:YES animated:YES];
            [mBtnModeName setTitle:@"韵律模式" forState:UIControlStateNormal];
        }
    }
    if (mSwitchYun.on) {
        Byte byte [] = {0xf0,0x04,0xf1};
        NSData * data =  [NSData dataWithBytes:&byte length:3];
        [SHBlueToothManager.instance sendData:data];
    }else{
        Byte byte [] = {0xf0,0x03,0xf1};
        NSData * data =  [NSData dataWithBytes:&byte length:3];
        [SHBlueToothManager.instance sendData:data];
    }
  
}

- (IBAction)btnStartOntouch:(id)sender {
}
- (IBAction)btnMusSelectOntouch:(id)sender
{
    [self selectMusic];
}
- (IBAction)btnReduceOntouch:(UIButton *)sender {
    if(sender.tag == 0){
        NSString * timeTitle = mBtnTimeSet.titleLabel.text;
        if ([timeTitle isEqualToString:@"1"]) {
            return;
        }
        [mBtnTimeSet setTitle:[NSString stringWithFormat:@"%d",timeTitle.intValue-1] forState:UIControlStateNormal];
    }else{
        NSString * timeTitle = mBtnFrequencySet.titleLabel.text;
        if ([timeTitle isEqualToString:@"1"]) {
            return;
        }
        [mBtnFrequencySet setTitle:[NSString stringWithFormat:@"%d",timeTitle.intValue-1] forState:UIControlStateNormal];
        
    }
}

- (IBAction)btnIncreaseOntouch:(UIButton *)sender {
    if(sender.tag == 0){
        NSString * timeTitle = mBtnTimeSet.titleLabel.text;
        if ([timeTitle isEqualToString:@"10"]) {
            return;
        }
        [mBtnTimeSet setTitle:[NSString stringWithFormat:@"%d",timeTitle.intValue+1] forState:UIControlStateNormal];
    }else{
        NSString * timeTitle = mBtnFrequencySet.titleLabel.text;
        if ([timeTitle isEqualToString:@"1"]) {
            return;
        }
        [mBtnFrequencySet setTitle:[NSString stringWithFormat:@"%d",timeTitle.intValue+1] forState:UIControlStateNormal];
    }
}



@end
