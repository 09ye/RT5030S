//
//  SHEquipmentListViewController.h
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface SHEquipmentListViewController : SHTableViewController
{
    CBPeripheral *selectPeripheral;
}


@end
