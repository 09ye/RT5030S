//
//  SHTargetSetViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-22.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTargetSetViewController.h"
#import "SHAmountSelectViewCell.h"

@interface SHTargetSetViewController ()

@end

@implementation SHTargetSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"目标设定";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" target:self action:@selector(saveTarget)];
//    mList = [[NSMutableArray alloc]init];
    mScrollview.datasource = self;
    mScrollview.delegate = self;
    
    mList = [@[@"",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@""] mutableCopy];
    [mScrollview reloadData];
    [mSegment addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
}

-(void)segmentAction:(UISegmentedControl *)Seg{
    [self segmentAction:Seg animation:YES];
}
-(void)segmentAction:(UISegmentedControl *)Seg animation :(BOOL) animation
{
    NSInteger index = Seg.selectedSegmentIndex;
    if(animation){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.0];
    }
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:mImgBg cache:YES];
    switch (index) {
        case 0:
            mLabNowTarget.text = [NSString stringWithFormat:@"当前体重为%@kg",@"65.5"];
            mLabTargetName.text = @"目标体重";
            mLabMount.text = @"65.5kg";
            mLabMount.textColor = [SHSkin.instance colorOfStyle:@"ColorTextGreen"];
            mImgBg.image = [UIImage imageNamed:@"xianshiqu_lvse_bg"];
            img1.image = [UIImage imageNamed:@"lanse_jianbian_wenzi_jiantou"];
            img2.image = [UIImage imageNamed:@"lanse_jianbian_zhixian"];
            mBtnTargetLevel.hidden = NO;
            CGRect rect = mLabNowTarget.frame;
            rect.origin.x = 47;
            mLabNowTarget.frame = rect;
            break;
        case 1:
            mLabNowTarget.text = @"设定每日目标卡路里";
            mLabTargetName.text = @"目标卡路里";
            mLabMount.text = @"1000";
            mLabMount.textColor = [SHSkin.instance colorOfStyle:@"ColorTextOrg"];
            mImgBg.image = [UIImage imageNamed:@"kaluli_xianshiqu_bg"];
            img1.image = [UIImage imageNamed:@"kaluli_huangsejianbian_jiantou"];
            img2.image = [UIImage imageNamed:@"kaluli_huangsejianbian_zhixian"];
            mBtnTargetLevel.hidden = YES;
            CGRect rect2 = mLabNowTarget.frame;
            rect2.origin.x = 76;
            mLabNowTarget.frame = rect2;
            break;
            
        default:
            break;
    }
    if(animation){
        [UIView commitAnimations];
    }
}

- (void) setList:(NSArray *)list_
{
    mList = [list_ mutableCopy];
    [mScrollview reloadData];
}
- (SHTableHorizontalViewCell*) tableView:(SHTableHorizontalView *)tableView cellForColumnAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHTableHorizontalViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"defalut_cell"];
    if(cell == nil){
        NSArray * array = [[NSBundle mainBundle] loadNibNamed:@"SHAmountSelectViewCell" owner:nil options:nil];
        cell = [array objectAtIndex:0];
        cell.identifier = @"defalut_cell";
    }
    ((SHAmountSelectViewCell*)cell).labName.text = [mList objectAtIndex:indexPath.row];
    if(indexPath.row == 0){// 第一个
        ((SHAmountSelectViewCell*)cell).imgLeft.hidden = YES;
    }
    if(indexPath.row == mList.count-1){ //最后一个
        ((SHAmountSelectViewCell*)cell).imgRight.hidden = YES;
    }
    return cell;
    
}
- (NSInteger)tableView:(SHTableHorizontalView *)tableView numberOfColumnInSection:(NSInteger)section
{
    return mList.count;
}

- (void)tableView:(SHTableHorizontalView *)tableView didSelectColumnAtIndexPath:(NSIndexPath *)indexPath
{
    //    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    //    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //滚动视图结束滚动，它只调用一次
//    NSLog(@"%F === %F",scrollView.contentOffset.x,(scrollView.contentOffset.x-70) / 100);
   
    
    [self targetNumberShow:scrollView];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {//手指离开屏幕后ScrollView还会继续滚动一段时间只到停止
    [self targetNumberShow:scrollView];
}

-(void) targetNumberShow:(UIScrollView *) scrollView// 滚动结束后更新 目标值
{
     //0-70 = 1，70 -170 = 2
    int x  = scrollView.contentOffset.x;
    if(x<=70){//
        CGPoint point  = CGPointMake(19, 0);
        [scrollView setContentOffset:point animated:YES];
        mLabMount.text = [mList objectAtIndex:1];
    }else{
        int num = (x-70) / 100+2;
        CGPoint point  = CGPointMake(19+100*(num-1), 0);
        [scrollView setContentOffset:point animated:YES];
        mLabMount.text = [mList objectAtIndex:num];
    }
}
-(void)saveTarget
{
    
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

@end
