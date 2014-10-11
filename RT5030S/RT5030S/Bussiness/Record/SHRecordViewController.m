//
//  SHRecordViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHRecordViewController.h"
#import "SHRecordViewCell.h"
#import "SHPhotoImgCell.h"

@interface SHRecordViewController ()

@end

@implementation SHRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"记录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"清除记录" target:self action:@selector(clearRecord)];
}
-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 150;
    }
    return 69;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(SHTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   
    if(indexPath.row == 0){
        SHPhotoImgCell * cell = [tableView dequeueReusableCellWithIdentifier:@"table_photo_img"];
        if(cell == nil){
            NSArray* array = [[NSBundle mainBundle]loadNibNamed:@"SHPhotoImgCell" owner:nil options:nil];
            cell = [array objectAtIndex:0];
            cell.backgroundColor = [UIColor clearColor];
        }
        
        return cell;
    }else{
        SHRecordViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"table_record_cell"];
        if(cell == nil){
            NSArray* array = [[NSBundle mainBundle]loadNibNamed:@"SHRecordViewCell" owner:nil options:nil];
            cell = [array objectAtIndex:0];
            cell.backgroundColor = [UIColor clearColor];
        }
        if (indexPath.row == 1) {// 有年
            CGRect rect =  cell.viewLine.frame;
            rect.origin.y = 19;
            rect.size.height = 30;
            cell.viewLine.frame = rect;
        }else{
            CGRect rect = CGRectMake(44, -19, 1, 69);
            cell.viewLine.frame = rect;
            cell.labYear.hidden = YES;
        }
            return cell;
    }


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clearRecord
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
