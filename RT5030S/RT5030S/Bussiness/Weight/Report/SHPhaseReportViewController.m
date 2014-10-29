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
    tabType = 1;//
    mSegment.selectedSegmentIndex = 0;
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"MM月dd日"];
    mLabCalendarDate.text = [format stringFromDate:[NSDate date]];
    [self request];
}

-(void) request
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
   
    [dic setValue:[NSNumber numberWithInt:tabType] forKey:@"itemType"];//1卡路里，2:使用时长，3：使用频次
    [dic setValue:[NSNumber numberWithInt:mSegment.selectedSegmentIndex+1] forKey:@"dateType"];//1最近，2：周
    if(tabType == 4){
        [dic setValue:@"1" forKey:@"dateType"];
    }
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"healthQuery.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        mResult = [[task result]mutableCopy];
        [lineChart removeFromSuperview];
        lineChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0)];
        lineChart.backgroundColor = [UIColor clearColor];
        switch (tabType) {
            case 1:
                [mbtnTab1 setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
                [mbtnTab2 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
                [mbtnTab3 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
                [mbtnTab4 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
                imgTitle.image = [UIImage imageNamed:@"ic_calrio"];
                mLabTitle.text = @"卡路里";
                mLabTitle.textColor = [SHSkin.instance colorOfStyle:@"ColorTextOrg"];
                
                mLabCriLeftTitle.text = @"总卡路里";
                mLabCriLeftContent.text = [NSString stringWithFormat:@"%d卡",[[mResult objectForKey:@"totalCalories"]intValue]];
                mLabCriMidTitle.text = @"单次最高";
                mLabCriMidContent.text = [NSString stringWithFormat:@"%d卡",[[mResult objectForKey:@"maxCaloriie"]intValue]];
                mLabCriRightTitle.text = @"使用天数";
                mLabCriRightContent1.text = [[mResult objectForKey:@"useDays"]stringValue];
                mLabCriRightContent2.text = [[mResult objectForKey:@"totalDays"]stringValue];
                
                [lineChart setXLabels:[mResult objectForKey:@"x-time"]];
                [lineChart setYValues:[mResult objectForKey:@"y-data"]];
                [lineChart  setStrokeColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"]];
                [lineChart strokeChart];
                [mViewChart addSubview:lineChart];
                
                mViewContain.hidden = NO;
                self.tableView.hidden = YES;
                
                break;
            case 2:
                [mbtnTab1 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
                [mbtnTab2 setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
                [mbtnTab3 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
                [mbtnTab4 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
                imgTitle.image = [UIImage imageNamed:@"ic_time_shichang"];
                mLabTitle.text = @"使用时长";
                mLabTitle.textColor = [SHSkin.instance colorOfStyle:@"ColorTextBlue"];
                
                mLabCriLeftTitle.text = @"总时长";
                mLabCriLeftContent.text = [NSString stringWithFormat:@"%d小时",[[mResult objectForKey:@"totalUseTime"]intValue]];
                mLabCriMidTitle.text = @"平均时长";
                mLabCriMidContent.text = [NSString stringWithFormat:@"%d分钟",[[mResult objectForKey:@"avgUseTime"]intValue]];;
                mLabCriRightTitle.text = @"使用天数";
                mLabCriRightContent1.text = [[mResult objectForKey:@"useDays"]stringValue];
                mLabCriRightContent2.text = [[mResult objectForKey:@"totalDays"]stringValue];
                
                [lineChart setXLabels:[mResult objectForKey:@"x-time"]];
                [lineChart setYValues:[mResult objectForKey:@"y-data"]];
                [lineChart  setStrokeColor:[SHSkin.instance colorOfStyle:@"ColorTextBlue"]];
                [lineChart strokeChart];
                [mViewChart addSubview:lineChart];
                mViewContain.hidden = NO;
                self.tableView.hidden = YES;
                break;
            case 3:
                [mbtnTab1 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
                [mbtnTab2 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
                [mbtnTab3 setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
                [mbtnTab4 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
                imgTitle.image = [UIImage imageNamed:@"ic_shichang"];
                mLabTitle.text = @"使用频次";
                mLabTitle.textColor = [SHSkin.instance colorOfStyle:@"ColorTextGreen"];
                
                mLabCriLeftTitle.text = @"总频次";
                mLabCriLeftContent.text = [NSString stringWithFormat:@"%d次",[[mResult objectForKey:@"totalUseCount"]intValue]];
                mLabCriMidTitle.text = @"单次最高";
                mLabCriMidContent.text = [NSString stringWithFormat:@"%d次",[[mResult objectForKey:@"maxUseCount"]intValue]];
                mLabCriRightTitle.text = @"使用天数";
                mLabCriRightContent1.text = [[mResult objectForKey:@"useDays"]stringValue];
                mLabCriRightContent2.text = [[mResult objectForKey:@"totalDays"]stringValue];
                
                [lineChart setXLabels:[mResult objectForKey:@"x-time"]];
                [lineChart setYValues:[mResult objectForKey:@"y-data"]];
                [lineChart  setStrokeColor:[SHSkin.instance colorOfStyle:@"ColorTextGreen"]];
                [lineChart strokeChart];
                [mViewChart addSubview:lineChart];
                mViewContain.hidden = NO;
                self.tableView.hidden = YES;
                break;
            case 4:
                [mbtnTab1 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
                [mbtnTab2 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
                [mbtnTab3 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
                [mbtnTab4 setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
                mViewContain.hidden = YES;
                self.tableView.hidden = NO;
                mList = [mResult objectForKey:@"musicList"];
                [self.tableView reloadData];
                break;
                
            default:
                break;
        }
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
        [task.respinfo show];
    }];
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return CELL_GENERAL_HEIGHT3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mList.count;
}

-(SHTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHModeMusicCell * cell = [tableView dequeueReusableCellWithIdentifier:@"table_mode_music_cell"];
    if(cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHModeMusicCell" owner:nil options:nil] objectAtIndex:0];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.backgroundColor = [UIColor whiteColor];
//    {"index":2,"musicName":"a","useCount":1,"useTime":0
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    cell.labIndex.text = [[dic objectForKey:@"index"]stringValue];
    cell.labName.text = [dic objectForKey:@"musicName"];
    cell.labCount.text = [NSString stringWithFormat:@"%@次",[dic objectForKey:@"useCount"]];
    cell.labTime.text = [NSString stringWithFormat:@"%@小时",[dic objectForKey:@"useTime"]];
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
  
    tabType = sender.tag +1;
    [self request];
}   

- (IBAction)segmentOntouch:(id)sender {
    [self request];
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
