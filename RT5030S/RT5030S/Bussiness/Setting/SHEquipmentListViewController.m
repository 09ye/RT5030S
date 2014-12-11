//
//  SHEquipmentListViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHEquipmentListViewController.h"
#import "SHBlueToothManager.h"

#define Server_UUID @"11223344-5566-7788-99AA-BBCCDDEEFF00"

@interface SHEquipmentListViewController ()

@end

@implementation SHEquipmentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"搜索列表";
    self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundGray"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"清除记录" target:self action:@selector(clearRecord)];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:NOTIFICATION_BLUETOOTH_CONNET_SUCCESSFUL object:nil];
}
//-(void)notification:(NSNotification *) noti
//{
//    if ([noti.name isEqualToString:NOTIFICATION_BLUETOOTH_CONNET_SUCCESSFUL]){
//        NSDictionary * temp=[noti object];
//        selectPeripheral = [temp objectForKey:@"selectDevice"];
//        [self.tableView reloadData];
//        
//    }
//}
-(void) clearRecord
{

//    Byte byte [] = {0xf0,0x51,0xf1};
//    NSData * data =  [NSData dataWithBytes:&byte length:3];
//    [SHBlueToothManager.instance sendData:data];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SHBlueToothManager.instance.devices count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identified = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identified];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    CBPeripheral *p = [SHBlueToothManager.instance.devices objectAtIndex:indexPath.row];
    cell.textLabel.text = p.name;
    if (p.state !=CBPeripheralStateDisconnected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   CBPeripheral * peripheral = [SHBlueToothManager.instance.devices objectAtIndex:indexPath.row];
    [SHBlueToothManager.instance connetPeripheral:peripheral connect:YES];
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
