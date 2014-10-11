//
//  SHImageCropperViewController.h
//  crowdfunding-arcturus
//
//  Created by lqh77 on 14-5-7.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "SHViewController.h"
#import <UIKit/UIKit.h>

@class SHImageCropperViewController;



@protocol SHImageCropperDelegate;

@protocol SHImageCropperDelegate <NSObject>

@optional

- (void)imageCropper:(SHImageCropperViewController *)cropperController didFinished:(UIImage *)editedImage;
- (void)imageCropperDidCancel:(SHImageCropperViewController *)cropperController;

@end


@interface SHImageCropperViewController : SHViewController

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) id<SHImageCropperDelegate> delegate;
@property (nonatomic, assign) CGRect cropFrame;
@property (nonatomic, assign) bool isCamera;// iphone4 前置摄像头 手机照相反 头像 方向（）


- (id)initWithImage:(UIImage *)originalImage cropFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio;

@end
