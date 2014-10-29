//
//  SHMusicPlayerManager.m
//  RT5030S
//
//  Created by yebaohua on 14/10/24.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHMusicPlayerManager.h"
static SHMusicPlayerManager * _instance;

@implementation SHMusicPlayerManager

+ (SHMusicPlayerManager* )instance
{
    if(_instance == nil){
        _instance = [[SHMusicPlayerManager alloc]init];
        
    }
    return _instance;
}
- (id)init
{
    if(self = [super init]){
        self.musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
        [self.musicPlayer setShuffleMode:MPMusicShuffleModeSongs];
        [self.musicPlayer setRepeatMode:MPMusicRepeatModeAll];
    }
    return self;
}

@end
