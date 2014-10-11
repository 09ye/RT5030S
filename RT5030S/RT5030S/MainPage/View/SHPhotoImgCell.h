//
//  SHPhotoImgCell.h
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHPhotoImgCell : SHTableViewCell
@property (weak, nonatomic) IBOutlet SHImageView *imgPhoto;
@property (weak, nonatomic) IBOutlet UILabel *labName;

@end
