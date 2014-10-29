//
//  SHRealDataViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-26.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import <MediaPlayer/MPMediaPickerController.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SHMusicPlayerManager.h"
@interface SHRealDataViewController : SHTableViewController<SHTaskDelegate,MPMediaPickerControllerDelegate>
{
    __weak IBOutlet UILabel *mLabMusicTime;
    __weak IBOutlet UILabel *mLabMusicTitle;
    __weak IBOutlet UILabel *mLabCalrio;
    __weak IBOutlet UILabel *mLabUserTime;
    __weak IBOutlet UILabel *mLabFreq;
    NSMutableArray * mRealData;
    NSTimer * mTimer;
//    int songTime;
//    NSString *mSongTitle;
//    NSString *mSongArtist;
}
@property(nonatomic,retain) UINavigationController *navController; // If this view controller has been pushed onto a navigation controller, return it.
- (IBAction)btnMusSelectOntouch:(id)sender;

@end
