//
//  SHPhaseReportViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-24.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHPhaseReportViewController.h"
#import "SHModeMusicCell.h"

@interface SHPhaseReportViewController ()

@end

@implementation SHPhaseReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"阶段报告";
    // Do any additional setup after loading the view from its nib.
    
    UIButton * button = [[UIButton alloc]init];
    button.tag = 0;
    [self btnTopTabOntohc:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return CELL_GENERAL_HEIGHT3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(SHTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHModeMusicCell * cell = [tableView dequeueReusableCellWithIdentifier:@"table_mode_music_cell"];
    if(cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHModeMusicCell" owner:nil options:nil] objectAtIndex:0];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self.intent.args objectForKey:@"classType"] isEqualToString:@"comper"])// 比一比
    {
        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHComparisonViewController";
        intent.container = self.navigationController;
        [[UIApplication sharedApplication] open:intent];
    }else{
        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHFriendDetailViewController";
        intent.container = self.navigationController;
        [intent.args setValue:@"Done" forKey:@"classType"];
        [[UIApplication sharedApplication] open:intent];
    }
    
}

- (IBAction)btnTopTabOntohc:(UIButton *)sender {
    [lineChart removeFromSuperview];
    lineChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0)];
    lineChart.backgroundColor = [UIColor clearColor];
    switch (sender.tag) {
        case 0:
            [mbtnTab1 setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
            [mbtnTab2 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnTab3 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnTab4 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            imgTitle.image = [UIImage imageNamed:@"ic_calrio"];
            mLabTitle.text = @"卡路里";
            mLabTitle.textColor = [SHSkin.instance colorOfStyle:@"ColorTextOrg"];
            
            mLabCriLeftTitle.text = @"总卡路里";
            mLabCriLeftContent.text = @"20000卡";
            mLabCriMidTitle.text = @"单次最高";
            mLabCriMidContent.text = @"200000卡";
            mLabCriRightTitle.text = @"使用天数";
            mLabCriRightContent1.text = @"1";
            mLabCriRightContent2.text = @"10";
            
            [lineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]];
            [lineChart setYValues:@[@"1",@"10",@"2",@"6",@"300",@"10",@"100"]];
            [lineChart  setStrokeColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"]];
            [lineChart strokeChart];
            [mViewChart addSubview:lineChart];
            mViewContain.hidden = NO;
            self.tableView.hidden = YES;
            
            break;
        case 1:
            [mbtnTab1 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnTab2 setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
            [mbtnTab3 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnTab4 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            imgTitle.image = [UIImage imageNamed:@"ic_time_shichang"];
            mLabTitle.text = @"使用时长";
            mLabTitle.textColor = [SHSkin.instance colorOfStyle:@"ColorTextBlue"];
            
            mLabCriLeftTitle.text = @"总时长";
            mLabCriLeftContent.text = @"20000小时";
            mLabCriMidTitle.text = @"平均时长";
            mLabCriMidContent.text = @"568分钟";
            mLabCriRightTitle.text = @"使用天数";
            mLabCriRightContent1.text = @"1";
            mLabCriRightContent2.text = @"10";
            
            [lineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]];
            [lineChart setYValues:@[@"10",@"10",@"20",@"6",@"300",@"10",@"100"]];
            [lineChart  setStrokeColor:[SHSkin.instance colorOfStyle:@"ColorTextBlue"]];
            [lineChart strokeChart];
            [mViewChart addSubview:lineChart];
            mViewContain.hidden = NO;
            self.tableView.hidden = YES;
            break;
        case 2:
            [mbtnTab1 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnTab2 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnTab3 setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
            [mbtnTab4 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            imgTitle.image = [UIImage imageNamed:@"ic_shichang"];
            mLabTitle.text = @"使用时长";
            mLabTitle.textColor = [SHSkin.instance colorOfStyle:@"ColorTextGreen"];
            
            mLabCriLeftTitle.text = @"总频次";
            mLabCriLeftContent.text = @"20000次";
            mLabCriMidTitle.text = @"单次最高";
            mLabCriMidContent.text = @"200000次";
            mLabCriRightTitle.text = @"使用天数";
            mLabCriRightContent1.text = @"1";
            mLabCriRightContent2.text = @"10";
            
            [lineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5"]];
            [lineChart setYValues:@[@"1",@"100",@"2",@"6",@"30"]];
            [lineChart  setStrokeColor:[SHSkin.instance colorOfStyle:@"ColorTextGreen"]];
            [lineChart strokeChart];
            [mViewChart addSubview:lineChart];
            mViewContain.hidden = NO;
            self.tableView.hidden = YES;
            break;
        case 3:
            [mbtnTab1 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnTab2 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnTab3 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnTab4 setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
            mViewContain.hidden = YES;
            self.tableView.hidden = NO;
            break;
            
        default:
            break;
    }
}

- (IBAction)segmentOntouch:(id)sender {
}

- (IBAction)btnCalender:(UIButton *)sender {
    mStartDatecontroller  = [[SHCalendarViewController alloc]init];
    mStartDatecontroller.delegate = self;
    [mStartDatecontroller show];
}
-(void)calendarViewController:(SHCalendarViewController *)controller dateSelected:(NSDate *)date
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat: @"MM月dd日"];
    mLabCalendarDate.text  =[dateFormatter stringFromDate:date];
    [mStartDatecontroller close];
    
}
@end
