//
//  SHSelfInfoViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "SHImageCropperViewController.h"
#import "SHSexSelectViewController.h"

@interface SHSelfInfoViewController : SHTableViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,SHImageCropperDelegate,SHSexSelectViewControllerDelegate,SHTaskDelegate>
{
    BOOL edit;
//    NSString * mSexName;
//    NSMutableDictionary * detail;

    NSMutableDictionary * mResult;
}

@end
