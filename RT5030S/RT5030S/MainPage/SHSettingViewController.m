//
//  SHSettingViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHSettingViewController.h"
#import "SHPhotoImgCell.h"

@interface SHSettingViewController ()

@end

@implementation SHSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.tableView.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorSettingBackGround"];
    [imgPhoto setCircleStyle:nil];
   
    [imgPhoto setUrl: [[NSUserDefaults standardUserDefaults]objectForKey:USER_CENTER_PHOTO]];
    labName.text =  [[NSUserDefaults standardUserDefaults]objectForKey:USER_CENTER_NICKNAME];
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return CELL_GENERAL_HEIGHT3;
}
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
    
}
- (SHTableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    SHTableViewTitleImageCell * cell  = [[[NSBundle mainBundle]loadNibNamed:@"SHTableViewTitleImageCell2" owner:nil options:nil]objectAtIndex:0];
    cell.labTitle.userstyle = @"labmidmilk";
    if(indexPath.row==0){
        
        cell.imgIcon.image = [UIImage imageNamed:@"shouye_icon"];
        cell.labTitle.text = @"首页";
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 600, 1)];
        view.backgroundColor = [UIColor whiteColor];
        [cell addSubview:view];

    }else if(indexPath.row==1){
        cell.imgIcon.image = [UIImage imageNamed:@"lianjieshebei_icon"];
        cell.labTitle.text = @"连接设备";


    }else if(indexPath.row==2){
        cell.imgIcon.image = [UIImage imageNamed:@"shezhi_icon"];
        cell.labTitle.text = @"设置";
    }else if(indexPath.row==3){
        cell.imgIcon.image = [UIImage imageNamed:@"lipin_icon"];
        cell.labTitle.text = @"送她/他一台5030S";
        cell.labTitle.textColor = [SHSkin.instance colorOfStyle:@"ColorTextRed"];
    }
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 60, 600, 1)];
    view.backgroundColor = [UIColor whiteColor];
    [cell addSubview:view];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell ;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(settingViewControllerDelegateDidBackHome:)]) {
            [self.delegate settingViewControllerDelegateDidBackHome:self];
        }

    }else if(indexPath .row == 1){
        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHFindEquipmentViewController";
        intent.container = self.navController;
        [[UIApplication sharedApplication] open:intent];
    }else if(indexPath .row == 2){
        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHSettingDetailViewController";
        intent.container = self.navController;
        [[UIApplication sharedApplication] open:intent];
    }else if(indexPath .row == 3){
        NSURL * url = [NSURL URLWithString:@"http://detail.tmall.com/item.htm?spm=a1z10.3.w4011-2535793592.129.GjJZ2g&id=39471402846&rn=ddb8a938288b3de540fe1fc129b882c0&abbucket=10"];
       [[UIApplication sharedApplication] openURL:url];
    }
}

- (IBAction)btnLoginOutOntouch:(id)sender {
   
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingViewControllerDelegateDidBackHome:)]) {
        [self.delegate settingViewControllerDelegateDidBackHome:self];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:CORE_NOTIFICATION_LOGIN_RELOGIN object:nil];
}


- (IBAction)btnFeedBackOntouch:(id)sender {
    
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHFeedBackViewController";
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}
- (IBAction)btnMyinfoOntouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHSelfInfoViewController";
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}
@end
