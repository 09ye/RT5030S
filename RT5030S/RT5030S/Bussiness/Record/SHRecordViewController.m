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
    [self requestHistory];
}
-(void) requestHistory
{
    
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:@"2" forKey:@"type"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"querySculptHistory.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        mResult = [[task result]mutableCopy];
        mList = [[mResult objectForKey:@"items"]mutableCopy];
        totalDays = [mResult objectForKeyedSubscript:@"totalDays"];
        [self.tableView reloadData];
 
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
}
-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 100;
    }
    return 69;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mList.count+1;
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
        [cell.imgPhoto setUrl: [[NSUserDefaults standardUserDefaults]objectForKey:USER_CENTER_PHOTO]];
        cell.labName.text = [NSString stringWithFormat:@"使用%@天",totalDays];
        return cell;
    }else{
        SHRecordViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"table_record_cell"];
        if(cell == nil){
            NSArray* array = [[NSBundle mainBundle]loadNibNamed:@"SHRecordViewCell" owner:nil options:nil];
            cell = [array objectAtIndex:0];
            cell.backgroundColor = [UIColor clearColor];
        }
        NSDictionary * dic = [mList objectAtIndex:indexPath.row-1];
        if (indexPath.row == 1) {// 有年
            cell.viewLine.hidden = YES;
            cell.viewLine2.hidden = NO;
            cell.labYear.hidden = NO;
        }else{
            cell.viewLine.hidden = NO;
            cell.viewLine2.hidden = YES;
            cell.labYear.hidden = YES;
        }
        NSDateFormatter * format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyyMMdd"];
        NSDate * date = [format dateFromString:[dic objectForKey:@"date"]];
        [format setDateFormat:@"yyyy-MM-dd"];
        cell.labYear.text = [format stringFromDate:date];
        [format setDateFormat:@"MM月dd日"];
        cell.labTime.text = [format stringFromDate:date];
        cell.labWeight.text = [NSString stringWithFormat:@"体重%dKg",[[dic objectForKey:@"weight"]intValue]/1000];
        cell.labCalorie.text = [NSString stringWithFormat:@"卡路里%@卡",[dic objectForKey:@"calorie"]];
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
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"deleteSculptHistory.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
        totalDays = @"0";
        [mList removeAllObjects];
        [self.tableView reloadData];
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
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
