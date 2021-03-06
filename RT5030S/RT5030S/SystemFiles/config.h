//
//  config.h
//  Zambon
//
//  Created by sheely on 13-9-23.
//  Copyright (c) 2013年 zywang. All rights reserved.
//


#import "Core.h"
#import "common.h"
#import "SHAppDelegate.h"


#define URL_HEADER @ "http://mobile.9191offer.com"

#define BATA_HEADER @ "http://route.9191offer.com:8181"

#define URL_BATA @ "http://192.168.1.200/api"

#define URL_DEVELOPER @ "http://mobile.9191offer.com/"



#define URL_FOR(a) [NSString stringWithFormat:@"%@/%@",URL_HEADER,a]

#define DEVICE_TOKEN @"DeviceTokenStringKEY"

#define STORE_USER_INFO @"userinfo"

 

#define RECT_RIGHTSHOW CGRectMake(87, 23, 930, 730)
#define RECT_RIGHTNAVIGATION CGRectMake(0, 0, 930, 44)
#define RECT_RIGHTLIST CGRectMake(0, 44, 240, 678)
#define RECT_RIGHTCONTENT CGRectMake(240, 0, 687  , 730)
#define RECT_RIGHTCONTENT2 CGRectMake(667, 23, 350  , 730)
#define CELL_GENERAL_HEIGHT 110
#define CELL_GENERAL_HEIGHT2 44
#define CELL_GENERAL_HEIGHT3 60
#define CELL_SECTION_HEADER_GENERAL_HEIGHT 38
#define RECT_MAIN_LANDSCAPE_RIGHT CGRectMake(-20, 0, 768, 1004)
#define RECT_MAIN_LANDSCAPE_LEFT CGRectMake(20, 0, 768, 1004)
#define LIST_PAGE_SIZE 10

//config
#define USER_CENTER_LOGINNAME @"user_center_loginname"

//notification
#define NOTIFICATION_LOGIN_SUCCESSFUL @"notification_login_successful"

#define NOTIFICATION_LOGINOUT @"notification_loginout"
#define NOTIFICATION_REGIST_SUCCESSFUL @"notification_regist_successful"

#define NOTIFICATION_CITY_SELECT @"notification_city_select"
#define NOTIFICATION_ADVANCE_SELECT @"notification_advance_select"

#define NOTIFICATION_RELSASETIME_SELECT @"notification_releasetime_select"
#define NOTIFICATION_INTERVIEW_HANDLE @"notification_interview_handle"

#define NOTIFICATION_EDIT_SELFINFO_SUCCESSFUL @"notification_edit_selfinfo_successful"
#define NOTIFICATION_EDIT_SELFINFO @"notification_edit_selfinfo"

#define NOTIFICATION_LOCATION_DISTRICT @"notification_location_district"
#define NOTIFICATION_LOCATION_CITY @"notification_location_city"
#define NOTIFICATION_VIDEO_UPLOADER_SUCCESSFUL @"notification_video_uploader_successful"

#define NOTIFICATION_JOBLIST_STORE_CHANGE @"notification_joblist_store_change"
//#define NOTIFICATION_LOGIN_SUCCESS @"notification_login_success"

#define NOTIFICATION_EditRefrence @"notification_edit_refrence"

#define NOTIFY_SinaAuthon_Success     @"SinaAuthonSuccess"

#define CORE_NOTIFICATION_LOGIN_CHANGE @"core_notification_login_change"

#define NOTIFICATION_APPLY_SUCCESSFUL @"notification_apply_successful"

#define NOTIFICATION_MESSAGE_UPDATE @"notification_message_update"
/* lqh77 add  */
#define ORIGINAL_MAX_WIDTH 640.0f

#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
 
#define RETAIN ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)


