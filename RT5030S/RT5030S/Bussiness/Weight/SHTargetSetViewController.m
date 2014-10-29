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
    [mScrollview reloadData];
    [mSegment addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    [self request];
}
-(void) request
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:[NSNumber numberWithInt:mSegment.selectedSegmentIndex+1] forKey:@"type"];// 1体重
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"targetQuery.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        mResult = [[task result]mutableCopy];
        mList = [[NSMutableArray alloc]init];
        if (mSegment.selectedSegmentIndex==1) {
            mLabMount.text = [NSString stringWithFormat:@"%@卡",[[mResult objectForKey:@"targetCalorie"]stringValue]];
//            [mList addObject:@""];
//            int start = [[mResult objectForKey:@"targetCalorie"]intValue]<500?500:[[mResult objectForKey:@"targetCalorie"]intValue]-10*50;
//            for (int i =0; i<30; i++) {
//                start +=50;
//                [mList addObject:[NSString stringWithFormat:@"%d",start]];
//            }
//            [mList addObject:@""];
            mList = [@[@"",@"1000",@"2000",@"3000",@"4000",@"5000",@"6000",@"7000",@"8000",@"9000",@"10000",@"11000",@"12000",@"13000",@"14000",@"15000",@"16000",@"17000",@"18000",@"19000",@"20000"] mutableCopy];
            [mScrollview reloadData];
        }else{
            mLabMount.text = [NSString stringWithFormat:@"%@Kg",[mResult objectForKey:@"targetWeight"]];// 单位g
            mLabNowTarget.text =  [NSString stringWithFormat:@"当前体重为%dKg",[[mResult objectForKey:@"currentWeight"]intValue]/1000];// 单位g
            [mBtnTargetLevel setTitle:[mResult objectForKey:@"statusName"] forState:UIControlStateNormal];
//            [mList addObject:@""];
//            int start = [[mResult objectForKey:@"currentWeight"]intValue]/1000-10;
//            for (int i =0; i<20; i++) {
//                start++;
//                [mList addObject:[NSString stringWithFormat:@"%dKg",start]];
//            }
//            [mList addObject:@""];
             mList = [@[@"",@"40Kg",@"42Kg",@"44Kg",@"46Kg",@"48Kg",@"50Kg",@"52Kg",@"54Kg",@"56Kg",@"58Kg",@"60Kg",@"62Kg",@"64Kg",@"66Kg",@"68Kg",@"70Kg",@"72Kg",@"74Kg",@"76Kg",@"78Kg",@""] mutableCopy];
            [mScrollview reloadData];
        }
      
        
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
        [task.respinfo show];
         mList = [[NSMutableArray alloc]init];
        if (mSegment.selectedSegmentIndex ==1) {
               mList = [@[@"",@"1000",@"2000",@"3000",@"4000",@"5000",@"6000",@"7000",@"8000",@"9000",@"10000",@"11000",@"12000",@"13000",@"14000",@"15000",@"16000",@"17000",@"18000",@"19000",@"20000"] mutableCopy];
        }else{
             mList = [@[@"",@"40Kg",@"42Kg",@"44Kg",@"46Kg",@"48Kg",@"50Kg",@"52Kg",@"54Kg",@"56Kg",@"58Kg",@"60Kg",@"62Kg",@"64Kg",@"66Kg",@"68Kg",@"70Kg",@"72Kg",@"74Kg",@"76Kg",@"78Kg",@""] mutableCopy];
        }
        [mScrollview reloadData];
    }];
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
            mLabNowTarget.text = [NSString stringWithFormat:@"当前体重为%@kg",@"0"];
            mLabTargetName.text = @"目标体重";
//            mLabMount.text = @"65.5kg";
            mLabMount.textColor = [SHSkin.instance colorOfStyle:@"ColorTextGreen"];
            mImgBg.image = [UIImage imageNamed:@"xianshiqu_lvse_bg"];
            img1.image = [UIImage imageNamed:@"lanse_jianbian_wenzi_jiantou"];
            img2.image = [UIImage imageNamed:@"lanse_jianbian_zhixian"];
            mBtnTargetLevel.hidden = NO;
            break;
        case 1:
            mLabNowTarget.text = @"设定每日目标卡路里";
            mLabTargetName.text = @"目标卡路里";
//            mLabMount.text = @"1000";
            mLabMount.textColor = [SHSkin.instance colorOfStyle:@"ColorTextOrg"];
            mImgBg.image = [UIImage imageNamed:@"kaluli_xianshiqu_bg"];
            img1.image = [UIImage imageNamed:@"kaluli_huangsejianbian_jiantou"];
            img2.image = [UIImage imageNamed:@"kaluli_huangsejianbian_zhixian"];
            mBtnTargetLevel.hidden = YES;
            break;
            
        default:
            break;
    }
    [self request];

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
    if (mSegment.selectedSegmentIndex==1) {
        ((SHAmountSelectViewCell*)cell).imgLeft.image = [UIImage imageNamed:@"kaluli_huangse_wenzi_fenge"];
        ((SHAmountSelectViewCell*)cell).imgRight.image = [UIImage imageNamed:@"kaluli_huangse_wenzi_fenge"];
        ((SHAmountSelectViewCell*)cell).labName.textColor = [SHSkin.instance colorOfStyle:@"ColorTextOrg"];
    }else{
        ((SHAmountSelectViewCell*)cell).imgLeft.image = [UIImage imageNamed:@"lvse_wenzi_fengexian"];
        ((SHAmountSelectViewCell*)cell).imgRight.image = [UIImage imageNamed:@"lvse_wenzi_fengexian"];
        ((SHAmountSelectViewCell*)cell).labName.textColor = [SHSkin.instance colorOfStyle:@"ColorTextGreen"];
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
        if(mSegment.selectedSegmentIndex ==1){
            mLabMount.text = [NSString stringWithFormat:@"%@卡",[mList objectAtIndex:1]];
        }else {
            mLabMount.text = [NSString stringWithFormat:@"%@",[mList objectAtIndex:1]];
        }
    }else{
        int num = (x-70) / 100+2;
        CGPoint point  = CGPointMake(19+100*(num-1), 0);
        [scrollView setContentOffset:point animated:YES];
        if(mSegment.selectedSegmentIndex ==1){
            mLabMount.text = [NSString stringWithFormat:@"%@卡",[mList objectAtIndex:num]];
        }else {
            mLabMount.text = [NSString stringWithFormat:@"%@",[mList objectAtIndex:num]];
        }
        
    }
}
-(void)saveTarget
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    if (mSegment.selectedSegmentIndex==1) {
        [dic setValue:@"2" forKey:@"type"];//
        [dic setValue:[NSNumber numberWithInt:[[mLabMount.text substringToIndex:mLabMount.text.length-1]intValue]]  forKey:@"value"];
    }else{
        [dic setValue:@"1" forKey:@"type"];// 1体重
        [dic setValue: [NSNumber numberWithInt:[[mLabMount.text substringToIndex:mLabMount.text.length-2]intValue]*1000] forKey:@"value"];
    }
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"targetSet.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        [task.respinfo show];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
