//
//  SHRealDataViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-26.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHRealDataViewController.h"

@interface SHRealDataViewController ()

@end

@implementation SHRealDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerForMediaPlayerNotifications];
    MPMediaItem *currentItem = [SHMusicPlayerManager.instance.musicPlayer nowPlayingItem];//获得正在播放的项目
    if (currentItem) {
        mLabMusicTitle.text = [currentItem valueForProperty:MPMediaItemPropertyTitle];//歌曲名称
        mTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerUp:) userInfo:Nil repeats:YES];
    }
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:NOTIFICATION_BLUETOOTH_DATA_UPDATE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:NOTIFICATION_BLUETOOTH_DATA_SUBMIT object:nil];
    
    
}
-(void)notification:(NSNotification *) noti
{
    if ([noti.name isEqualToString:NOTIFICATION_BLUETOOTH_DATA_UPDATE]){
        NSDictionary * temp=[noti object];
        mRealData = [temp objectForKey:@"data"];
        [self updateRealData];
        if ([[mRealData objectAtIndex:6]intValue] <=1) {// 剩余时间0
            [self submitData];
        }
        
    }else if ([noti.name isEqualToString:NOTIFICATION_BLUETOOTH_DATA_SUBMIT]){
//        NSDictionary * temp=[noti object];
//        mRealData = [temp objectForKey:@"data"];
//        [self updateRealData];
        if (mRealData) {
             [self submitData];
        }
       
    }
}
-(void) updateRealData
{
    
    mLabCalrio.text = [mRealData objectAtIndex:15];
    int time=   abs([[mRealData objectAtIndex:4]intValue]*60-[[mRealData objectAtIndex:6]intValue]);// 已经使用时间 = 总时间4（单位：分钟） - 剩余时间6（单位：秒）
    
    mLabUserTime.text = [self timeStringWithNumber:time];
    mLabFreq.text = [mRealData objectAtIndex:5];
    
    
    
}
// 当时间结束时 或者蓝牙断开连接时 提交数据
-(void) submitData
{
    int time=   abs([[mRealData objectAtIndex:4]intValue]*60-[[mRealData objectAtIndex:6]intValue]);// 已经使用时间 = 总时间4（单位：分钟） - 剩余时间6（单位：秒）
    
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyyMMdd"];
    //    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    //    [dic setValue:[format stringFromDate:[NSDate date]] forKey:@"dateTime"];
    [dic setValue:[mRealData objectAtIndex:3] forKey:@"type"];// 模式
    [dic setValue:[NSNumber numberWithInt:time] forKey:@"useTime"];// 使用时间
    [dic setValue:[mRealData objectAtIndex:5] forKey:@"deviceFeq"];
    //     [dic setValue:[mRealData objectAtIndex:6] forKey:@""];// 运行剩余时间 s
    [dic setValue:[NSNumber numberWithInt:[[mRealData objectAtIndex:7]intValue]*1000] forKey:@"weight"]; //传来kg去g
    [dic setValue:[mRealData objectAtIndex:8] forKey:@"fat"];
    [dic setValue:[mRealData objectAtIndex:9] forKey:@"muscle"];
    [dic setValue:[mRealData objectAtIndex:10] forKey:@"visceralFat"];
    [dic setValue:[mRealData objectAtIndex:11] forKey:@"basalMetabolism"];
    [dic setValue:[mRealData objectAtIndex:12] forKey:@"water"];
    [dic setValue:[mRealData objectAtIndex:13] forKey:@"protein"];
    [dic setValue:[mRealData objectAtIndex:14] forKey:@"boneWeight"];
    [dic setValue:mLabMusicTitle.text forKey:@"music"];//
    [dic setValue:[mRealData objectAtIndex:15] forKey:@"calorie"];//
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"realTimeData.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
        [task.respinfo show];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnMusSelectOntouch:(id)sender {
    [self selectMusic];
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
    mLabMusicTitle.text = [musicItem valueForProperty:MPMediaItemPropertyTitle];
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
@end
