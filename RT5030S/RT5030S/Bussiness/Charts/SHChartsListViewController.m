//
//  SHChartsListViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-24.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHChartsListViewController.h"
#import "SHFrienItemCell.h"

@interface SHChartsListViewController ()

@end

@implementation SHChartsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排行榜";
    type = 1;
    [imgPhoto setCircleStyle:nil];
    [imgPhoto setUrl: [[NSUserDefaults standardUserDefaults]objectForKey:USER_CENTER_PHOTO]];
    [self request];
}
- (void)request {
    
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:[NSNumber numberWithInt:type] forKey:@"type"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"rankQuery.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        NSDictionary * result = [[task result]mutableCopy];
        mLabRank.text = [[result objectForKey:@"myRank"]stringValue];
        mList = [[result objectForKey:@"ranks"]mutableCopy];
        [self.tableView reloadData];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
        mList =[[NSMutableArray alloc]init ];
        mLabRank.text = @"0";
        [self.tableView reloadData];
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
    SHFrienItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"table_friends_cell"];
    if(cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHFrienItemCell" owner:nil options:nil] objectAtIndex:0];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSDictionary * dic =[mList objectAtIndex:indexPath.row];
    cell.detail= dic;
    cell.labRank.hidden = NO;
    if(type==3){// 好友列表
        cell.btnAddFriend.hidden = YES;
    }
    cell.btnAddFriend.tag = [[dic objectForKey:@"userId"]integerValue];
    [cell.btnAddFriend addTarget:self action:@selector(btnAddFriend:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHFriendDetailViewController";
    intent.container = self.navigationController;
    [intent.args setValue:[dic objectForKey:@"userId"] forKey:@"userId"];
    [intent.args setValue:@"Done" forKey:@"classType"];
    [[UIApplication sharedApplication] open:intent];
    
}

-(void) btnAddFriend:(UIButton *)button
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:[NSNumber numberWithInt:button.tag] forKey:@"friendId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"applyFriend.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
}


- (IBAction)btnTopTabOntohc:(UIButton *)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.tableView cache:YES];
    type = sender.tag +1;
    switch (sender.tag) {
        case 0:
            [mbtnTab1 setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
            [mbtnTab2 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnTab3 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            break;
        case 1:
            [mbtnTab1 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnTab2 setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
            [mbtnTab3 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            break;
        case 2:
            [mbtnTab1 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnTab2 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnTab3 setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    [self request];
    [UIView commitAnimations];
}
@end
