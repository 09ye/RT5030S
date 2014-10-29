//
//  SHMusicPlayerManager.h
//  RT5030S
//
//  Created by yebaohua on 14/10/24.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MPMediaPickerController.h>
#import <MediaPlayer/MediaPlayer.h>
@interface SHMusicPlayerManager : NSObject
{
    MPMusicPlayerController     *musicPlayer;            //播放器
    MPMediaItemCollection       *mediaCollection;   //放置音乐的容器
}

@property   (nonatomic,retain) MPMusicPlayerController      *musicPlayer;
@property   (nonatomic,retain) MPMediaItemCollection        *mediaCollection;

+ (SHMusicPlayerManager *)instance ;
- (id)  initWithPlayerType:(NSInteger)PlayerType LoadSong:(NSArray *)SongList;
@end
