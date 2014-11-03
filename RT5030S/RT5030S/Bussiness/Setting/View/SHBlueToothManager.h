//
//  SHBlueToothManager.h
//  RT5030S
//
//  Created by yebaohua on 14-9-27.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface SHBlueToothManager : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
{
     NSThread * thread;
     NSTimer *  timerLink;
    
}
@property BOOL cbRun;
//@property BOOL cbReady;
@property(nonatomic) float batteryValue;
@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) CBPeripheral *peripheral;

@property (strong ,nonatomic) CBCharacteristic *writeCharacteristic;

@property (strong,nonatomic) NSMutableArray *devices;
@property (strong,nonatomic) NSMutableArray *services;
@property (strong,nonatomic) NSMutableArray *characteristics;

@property (strong,nonatomic) NSMutableArray *responseData;

+ (SHBlueToothManager *)instance ;
-(void) connetPeripheral:(CBPeripheral *)peripheral connect:(BOOL) connect;// 连接设备
-(void)scanDevinces;
-(void)sendData:(NSData*) data ;
@end
