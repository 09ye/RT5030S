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
#import "Utility.h"


#define URL_HEADER @ "http://114.215.151.117:8080/topcms/app"

#define BATA_HEADER @ "http://114.215.151.117:8080/topcms/app"

#define URL_BATA @ "http://114.215.151.117:8080/topcms/app"

#define URL_DEVELOPER @ "http://114.215.151.117:8080/topcms/app"



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
#define USER_CENTER_PASSWORD @"user_center_password"
#define USER_CENTER_NICKNAME @"user_center_nickname"
#define USER_CENTER_PHOTO @"user_center_photo"
//notification
#define NOTIFICATION_LOGIN_SUCCESSFUL @"notification_login_successful"

#define NOTIFICATION_LOGINOUT @"notification_loginout"
#define NOTIFICATION_REGIST_SUCCESSFUL @"notification_regist_successful"
#define NOTIFICATION_BACK_HOME @"notification_back_home"
#define NOTIFICATION_BLUETOOTH_DATA_UPDATE @"notification_bluetooth_data_update"
#define NOTIFICATION_BLUETOOTH_CONNET_SUCCESSFUL @"notification_bluetooth_connet_successful"
#define NOTIFICATION_BLUETOOTH_DATA_SUBMIT @"notification_bluetooth_data_submit"
//#define NOTIFICATION_LOGIN_SUCCESS @"notification_login_success"

#define NOTIFICATION_EditRefrence @"notification_edit_refrence"

#define NOTIFY_SinaAuthon_Success     @"SinaAuthonSuccess"

#define CORE_NOTIFICATION_LOGIN_CHANGE @"core_notification_login_change"

#define NOTIFICATION_APPLY_SUCCESSFUL @"notification_apply_successful"

#define NOTIFICATION_MESSAGE_UPDATE @"notification_message_update"
/* lqh77 add  */

//userdefault
#define AUTOLOGIN @"autologin"

#define SEARCH_ME @"searchme"

#define AUTO_LINK @"autolink"

#define ORIGINAL_MAX_WIDTH 640.0f

#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
 
#define RETAIN ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)


