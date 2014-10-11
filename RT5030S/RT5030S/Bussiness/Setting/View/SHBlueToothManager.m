//
//  SHBlueToothManager.m
//  RT5030S
//
//  Created by yebaohua on 14-9-27.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHBlueToothManager.h"
#define Server_UUID @"11223344-5566-7788-99AA-BBCCDDEEFF00"
static SHBlueToothManager * _instance;
@implementation SHBlueToothManager

+ (SHBlueToothManager* )instance
{
    if(_instance == nil){
        _instance = [[SHBlueToothManager alloc]init];
        
    }
    return _instance;
}
- (id)init
{
    if(self = [super init]){
        _devices = [[NSMutableArray alloc]init];
        _services = [[NSMutableArray alloc]init];
        _characteristics = [[NSMutableArray alloc]init];
        _cbRun = YES;
        _responseData = [[NSMutableArray alloc]init];
        thread= [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:nil];
        //        [thread start];
        dispatch_queue_t centralQueue = dispatch_queue_create("mycentralqueue", DISPATCH_QUEUE_SERIAL);
        //                 [NSThread sleepForTimeInterval:0.1];
        self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        
//        Byte byte[] = {0xF0, 0x11,0x01 ,0x13 ,0x14 ,0x15 ,0x16 ,0x17 ,0x18,0x19,0x1A,0x1B,0x1C ,0x1D,0x1E,0xF1};
//        NSData * data  =[NSData dataWithBytes:&byte length:16];
//        [self bytesToIntArray:data];
    }
    return self;
}
- (void)run:(NSObject*)sender
{
    while (_cbRun) {
        self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        [NSThread sleepForTimeInterval:0.1];
        _cbRun = NO;
        
    }
}
- (void)showAlertDialog:(NSString*)content
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)scanDevinces
{
    NSArray *uuidArray = [NSArray arrayWithObjects:[CBUUID UUIDWithString:Server_UUID],nil];
    [self.manager scanForPeripheralsWithServices:uuidArray options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @NO }];
    
    //    double delayInSeconds = 30.0;
    //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    //    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    //        [self.manager stopScan];
    //        [self dismissWaitDialog];
    //        [self showAlertDialog:@"扫描超时,停止扫描"];
    //    });
}

//连接

-(void) connetPeripheral:(CBPeripheral *)peripheral connect:(BOOL) connect
{
    if (connect) {
        _peripheral = peripheral;
        [self.manager connectPeripheral:peripheral options:nil];

    }else {
        [self.manager cancelPeripheralConnection:_peripheral];
    }
}

//发送数据
-(void)sendData:(NSData *)data
{
//    Byte byte[] = {0xf0,0x46,0xf1};
//    NSData *data = [NSData dataWithBytes:&byte length:3];
    [_peripheral writeValue:data forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithResponse];
}

//开始查看服务，蓝牙开启
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            //            [self showAlertDialog:@"蓝牙已打开,请扫描外设"];
            [self scanDevinces];
            break;
        default:
            [self showAlertDialog:@"请先打开蓝牙"];
            break;
    }
}

//查到外设后，停止扫描，连接设备
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"didDiscoverPeripheral==%@",peripheral);
    //    [self.manager stopScan];
    BOOL replace = NO;
    // Match if we have this device from before
    for (int i=0; i < _devices.count; i++) {
        CBPeripheral *p = [_devices objectAtIndex:i];
        if ([p isEqual:peripheral]) {
            [_devices replaceObjectAtIndex:i withObject:peripheral];
            replace = YES;
        }
    }
    if (!replace) {
        [_devices addObject:peripheral];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"auto_link_equ"]) {// 自动连接设备
        [self connetPeripheral:peripheral connect:YES];
    }
}
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    
}
//连接外设成功，开始发现服务
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    [self.peripheral setDelegate:self];
    [self.peripheral discoverServices:nil];
    
}
//连接外设失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%@",error);
    [self showAlertDialog:@"连接失败"];
}

-(void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{
    int rssi = abs([peripheral.RSSI intValue]);
    CGFloat ci = (rssi - 49) / (10 * 4.);
    NSString *length = [NSString stringWithFormat:@"发现BLT4.0热点:%@,距离:%.1fm",_peripheral,pow(10,ci)];
    NSLog(@"距离：%@",length);
}
//已发现服务
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    for (CBService *s in peripheral.services) {
        [self.services addObject:s];
        if ([s.UUID  isEqual:[CBUUID UUIDWithString:Server_UUID]]) {// 只关心某个特征值
            [peripheral discoverCharacteristics:nil forService:s];
            break;
        }
        
    }
}

//已搜索到Characteristics 查询服务所带的特征值
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if ([service.UUID  isEqual:[CBUUID UUIDWithString:Server_UUID]]) {
        for (CBCharacteristic *c in service.characteristics) {
            [_characteristics addObject:c];
            if ([c.UUID isEqual:[CBUUID UUIDWithString:@"4A5B"]]) {
                _writeCharacteristic = c;//保存写的特征
                //                [_peripheral readValueForCharacteristic:c];
                //                [_peripheral readRSSI];
                [_peripheral setNotifyValue:YES forCharacteristic:c];// 不停的发送通知
            }
            
        }
    }
}


//获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取。
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"4A5B"]]) {
        NSString *value = [[NSString alloc]initWithData:characteristic.value encoding:NSUTF8StringEncoding];
       _responseData = [[self bytesToIntArray:characteristic.value] mutableCopy];
        NSLog(@"4A5B-==%@",characteristic.value);
    }else{
        NSLog(@"didUpdateValueForCharacteristic%@",[[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding]);
    }
}



//中心读取外设实时数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    // Notification has started
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
        
    } else { // Notification has stopped
        // so disconnect from the peripheral
        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        [self.manager cancelPeripheralConnection:self.peripheral];
    }
}
//用于检测中心向外设写数据是否成功
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"=======%@",error.userInfo);
    }else{
        NSLog(@"发送数据成功");
    }
}
//接受到数据 转成 10进制的数组（16）
-(NSArray *) bytesToIntArray:(NSData *)data
{
    //手机收到十六进制信息（nsdata）：0xF0 11 01 13 14 15 16 17 18 19 1A 1B 1C 1D 1E F1
    NSLog(@"%@",data);
    NSMutableArray * array = [[NSMutableArray alloc]init];
    Byte *bytes = (Byte *)[data bytes];
    for(int i=0;i<[data length];i++){
        NSString *hexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];//10进制转16进制数
        if([hexStr length]==1)
            hexStr = [NSString stringWithFormat:@"0%@",hexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@",hexStr];
        NSString * two = [self hex2Binary:hexStr];
        NSString * ten = [NSString stringWithFormat:@"%d",bytes[i]&0xff];
        if (i==1) {// 字节2 （3-6程序版本，例：值为1时，显示V1.0，；0-2开光状态 0：关，1：开 ）
            ten =  [self two2ten:two  range:NSMakeRange(1, 4)];
            [array addObject:ten];
            ten =  [self two2ten:two  range:NSMakeRange(5, 3)];
            [array addObject:ten];
            
        }else if (i == 2) {//字节3 （4-6模式状态1：手动模式，2：韵律模式; 0-3开光状态 实际设定1-10分钟）
            ten =  [self two2ten:two  range:NSMakeRange(1, 3)];
            [array addObject:ten];
            ten =  [self two2ten:two  range:NSMakeRange(4, 4)];
            [array addObject:ten];
        }else if (i == 4) {//字节5 （低7位） 字节6（高7位） 运行剩余时间 单位秒
            NSString * tenL = [self two2ten:two  range:NSMakeRange(1, 7)];// 低7位
            NSString *hexStrH = [NSString stringWithFormat:@"%x",bytes[5]&0xff];
            NSString * twoH = [NSString stringWithFormat:@"%@00000000",[self hex2Binary:hexStrH]];
            NSString * tenH = [self two2ten:twoH  range:NSMakeRange(1, 15)];// 高7位
            NSString * vlaue = [NSString stringWithFormat:@"%d",tenH.intValue +tenL.intValue];
            [array addObject:vlaue];
        }else if (i == 6) {//字节5 （低7位） 字节6（高7位） 体重0.1kg  单位秒
            NSString * tenL = [self two2ten:two  range:NSMakeRange(1, 7)];// 低7位
            NSString *hexStrH = [NSString stringWithFormat:@"%x",bytes[7]&0xff];
            NSString * twoH = [NSString stringWithFormat:@"%@00000000",[self hex2Binary:hexStrH]];
            NSString * tenH = [self two2ten:twoH  range:NSMakeRange(1, 15)];// 高7位
            NSString * value = [NSString stringWithFormat:@"%0.1f",((tenH.floatValue +tenL.floatValue)*0.1)];
            [array addObject:value];
        }else if(i != 5 && i != 7){
            [array addObject:ten];
        }
        
    }
    NSLog(@"%@",array);
    return array;
}

// 2进制转10进制
-(NSString *) two2ten:(NSString *)two range :(NSRange) range
{
    if (range.length>0) {
        two = [two substringWithRange:range];
    }
    long v = strtol([two UTF8String], NULL, 2);
    return  [NSString stringWithFormat:@"%ld",v];
}
// 10进制转2进制
-(NSString *)tentoBinary:(NSInteger)input
{
    if (input == 1 || input == 0) {
        return [NSString stringWithFormat:@"%d", input];
    }
    else {
        return [NSString stringWithFormat:@"%@%d", [self tentoBinary:input / 2], input % 2];
    }
}
//16进制转2进制
-(NSString*) hex2Binary:(NSString *) str
{
    NSMutableString *binStr = [[NSMutableString alloc] init];
    
    
    for(NSUInteger i=0; i<[str length]; i++)
    {
        [binStr appendString:[self hexToBinary:[str characterAtIndex:i]]];
    }
    return (NSString *)binStr;
}
- (NSString *) hexToBinary:(unichar)myChar
{
    switch(myChar)
    {
        case '0': return @"0000";
        case '1': return @"0001";
        case '2': return @"0010";
        case '3': return @"0011";
        case '4': return @"0100";
        case '5': return @"0101";
        case '6': return @"0110";
        case '7': return @"0111";
        case '8': return @"1000";
        case '9': return @"1001";
        case 'a':
        case 'A': return @"1010";
        case 'b':
        case 'B': return @"1011";
        case 'c':
        case 'C': return @"1100";
        case 'd':
        case 'D': return @"1101";
        case 'e':
        case 'E': return @"1110";
        case 'f':
        case 'F': return @"1111";
    }
    return @"-1"; //means something went wrong, shouldn't reach here!
}


@end
