//
//  SHComperDataViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-26.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHComperDataViewController.h"
#import "SHWeekDayCell.h"

@interface SHComperDataViewController ()

@end

@implementation SHComperDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    mViewWeek.columnWidth = 300/7;
    mList = [@[@"一",@"二",@"三",@"四",@"五",@"六",@"七"] mutableCopy];
    mViewWeek.datasource = self;
    mViewWeek.delegate = self;
   
    mListWeek = [[NSDate date] arrayCurWeek];
    selectWeek = [[[Utility weekDayWithDate:[NSDate date]]objectAtIndex:0]integerValue];
    mLabOtherDay.text = [[Utility weekDayWithDate:[NSDate date]]objectAtIndex:1];
    [mViewWeek reloadData];
//    [self request];
}
- (SHTableHorizontalViewCell*) tableView:(SHTableHorizontalView *)tableView cellForColumnAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHTableHorizontalViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"defalut_cell"];
    if(cell == nil){
        NSArray * array = [[NSBundle mainBundle] loadNibNamed:@"SHWeekDayCell" owner:nil options:nil];
        cell = [array objectAtIndex:0];
        cell.identifier = @"defalut_cell";
    }
    ((SHWeekDayCell*)cell).labTitle.text = [mList objectAtIndex:indexPath.row];
    NSArray * week =[Utility weekDayWithDate:[NSDate date]];
    if ([[week objectAtIndex:0]integerValue] == indexPath.row) {
         ((SHWeekDayCell*)cell).img.image = [UIImage imageNamed:@"diburiqi_jinri"];
    }
    if (selectWeek == indexPath.row) {
        ((SHWeekDayCell*)cell).img.image = [UIImage imageNamed:@"diburiqi_selected"];
    }
    return cell;
    
}
- (NSInteger)tableView:(SHTableHorizontalView *)tableView numberOfColumnInSection:(NSInteger)section
{
    return mList.count;
}

- (void)tableView:(SHTableHorizontalView *)tableView didSelectColumnAtIndexPath:(NSIndexPath *)indexPath
{
   
    int today =  [[[Utility weekDayWithDate:[NSDate date]]objectAtIndex:0]integerValue];
    if (indexPath.row >= today) {
        [self showAlertDialog:@"只能对比当天之前的数据"];
        return;
    }
    selectWeek = indexPath.row;
    mLabOtherDay.text = [[Utility weekDayWithDate:[mListWeek objectAtIndex:selectWeek]]objectAtIndex:1];
    [mViewWeek reloadData];
    [self request];
}
-(void) request
{
    NSDate * date = [mListWeek objectAtIndex:selectWeek];
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyyMMdd"];
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:[format stringFromDate:date] forKey:@"compareDate"];
    [dic setValue:[format stringFromDate:[NSDate date]] forKey:@"currentDate"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"sculptCompare.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        mResult = [[task result]mutableCopy];
        NSDictionary * today = [mResult objectForKey:@"today"];
        mLabWeightToday.text = [NSString stringWithFormat:@"%dKg",[[today objectForKey:@"weight"]intValue]/1000];
        mLabCalrioToday.text = [[today objectForKey:@"calorie"]stringValue];
        NSDictionary * otherday = [mResult objectForKey:@"otherDay"];
        mLabCalrioWeek.text = [[otherday objectForKey:@"calorie"]stringValue];
        mLabWegithWeek.text = [NSString stringWithFormat:@"%dKg",[[otherday objectForKey:@"weight"]intValue]/1000];
        mLabFreq.text = [NSString stringWithFormat:@"%@/%@",[[today objectForKey:@"iterval"]stringValue],[[today objectForKey:@"iterval"]stringValue]];
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
        [task.respinfo show];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCreateDataReportOntouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc]init];
    intent.target = @"SHDataReportViewController";
    if (self.navigationController) {
         intent.container = self.navigationController;
    }else{
         intent.container = self.navigationCont;
    }
    [[UIApplication sharedApplication] open:intent];
}
@end
