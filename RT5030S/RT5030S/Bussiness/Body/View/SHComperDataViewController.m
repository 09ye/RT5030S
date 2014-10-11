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
    [mViewWeek reloadData];
    selectWeek = [[[Utility weekDayWithDate:[NSDate date]]objectAtIndex:0]integerValue];
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
    selectWeek = indexPath.row;
    [mViewWeek reloadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
