//
//  SHPKViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-24.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHPKViewController.h"
#import "SHFrienItemCell.h"

@interface SHPKViewController ()

@end

@implementation SHPKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"PK";
    [self request];
}
-(void) request
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    if (type == 1) {
        post.URL = URL_FOR(@"listRemind.jhtml");
    }else{
        post.URL = URL_FOR(@"listPK.jhtml");
    }
 
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        NSDictionary * result = [[task result]mutableCopy];
        mList = [[result objectForKey:@"friends"]mutableCopy];
        [self.tableView reloadData];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
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
    cell.backgroundColor = [UIColor whiteColor];
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    cell.detail= dic;
    cell.labTargetTitle.hidden = NO;
    cell.labTargetCalrio.hidden = NO;
    cell.labTargetCalrio.text = [NSString stringWithFormat:@"%@卡",[dic objectForKey:@"targetCalorie"]];
  
    if ([[dic objectForKey:@"operate"]intValue] == 0 ) {//0-接收，1提醒，-1不显示按钮
        cell.btnPk.hidden = NO;
        cell.btnPk.tag = indexPath.row;
        [cell.btnPk setTitle:@"接受" forState:UIControlStateNormal];
        [cell.btnPk setBackgroundImage:[UIImage imageNamed:@"jieshou_anniu"] forState:UIControlStateNormal];
        [cell.btnPk removeTarget:self action:@selector(btnRemindPKOntouch:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnPk addTarget:self action:@selector(btnComfriePKOntouch:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if ([[dic objectForKey:@"operate"]intValue] == 1 ) {//0-接收，1提醒，-1不显示按钮
        cell.btnPk.hidden = NO;
        cell.btnPk.tag = indexPath.row;
        [cell.btnPk setTitle:@"提醒" forState:UIControlStateNormal];
        [cell.btnPk setBackgroundImage:[UIImage imageNamed:@"haoyoujiandu_tixing_button"] forState:UIControlStateNormal];
        [cell.btnPk removeTarget:self action:@selector(btnComfriePKOntouch:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnPk addTarget:self action:@selector(btnRemindPKOntouch:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        cell.btnPk.hidden = YES;
    }
    
   
   
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!type==1) {
        NSDictionary * dic  =[mList objectAtIndex:indexPath.row];
        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHComparisonViewController";
        intent.container = self.navigationController;
        [intent.args setValue:[dic objectForKey:@"userId"] forKey:@"userId"];
        [[UIApplication sharedApplication] open:intent];
    }
   
}
#pragma  删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
    
}
-(NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {// 删除
    
    [self showWaitDialogForNetWork];
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    NSMutableDictionary * dicDetail = [[NSMutableDictionary alloc]init ];
    [dicDetail setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dicDetail setValue:[dic objectForKey:@"userId"] forKey:@"friendId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    
    if(type == 1){// 监督
        post.URL = URL_FOR(@"deleteRemind.jhtml");
    }else{
        post.URL = URL_FOR(@"deletePK.jhtml");
        
    }
    post.postData = [Utility createPostData:dicDetail];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
        [mList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnTabOntouch:(UIButton *)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.tableView cache:YES];
    type = sender.tag;
    switch (sender.tag) {
        case 0:
            [mbtnTab1 setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
            [mbtnTab2 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            break;
        case 1:
            [mbtnTab1 setBackgroundImage:[SHSkin.instance image:@"xuanxiang_default"] forState:UIControlStateNormal];
            [mbtnTab2 setBackgroundImage:[SHSkin.instance image:@"xuangxiang_selected"] forState:UIControlStateNormal];
            break;            
        default:
            break;
    }
    [self request];
    [UIView commitAnimations];
}

- (IBAction)btnAddOntouch:(UIButton *)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHFriendListViewController";
    [intent.args setValue:@"pk" forKey:@"classType"];
    [intent.args setValue:[NSNumber numberWithInt:type] forKey:@"type"];
    intent.container = self.navigationController;
    intent.delegate = self;
    [[UIApplication sharedApplication] open:intent];
    
}

-(void) btnComfriePKOntouch:(UIButton *)button
{
     NSDictionary * dic  =[mList objectAtIndex:button.tag];
    if(type == 1){// 监督接受
        [self showWaitDialogForNetWork];
        NSMutableDictionary * dicDetail = [[NSMutableDictionary alloc]init ];
        [dicDetail setValue:SHEntironment.instance.userId forKey:@"userId"];
        [dicDetail setValue:[dic objectForKey:@"userId"] forKey:@"friendId"];
        SHPostTaskM * post = [[SHPostTaskM alloc]init];
        post.URL = URL_FOR(@"passRemind.jhtml");
        post.postData = [Utility createPostData:dicDetail];
        post.delegate = self;
        [post start:^(SHTask *task) {
            [self dismissWaitDialog];
//            [task.respinfo show];
             [self showAlertDialog:task.respinfo.message];
            [self request];
        } taskWillTry:^(SHTask *task) {
            
        } taskDidFailed:^(SHTask *task) {
            [self dismissWaitDialog];
//            [task.respinfo show];
             [self showAlertDialog:task.respinfo.message];
        }];
    }else{
       
        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHComparisonViewController";
        intent.container = self.navigationController;
        [intent.args setValue:[dic objectForKey:@"userId"] forKey:@"userId"];
        [[UIApplication sharedApplication] open:intent];
    }
  
}  
-(void) btnRemindPKOntouch:(UIButton *)button// 提醒
{
    NSDictionary * dic  =[mList objectAtIndex:button.tag];
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dicDetail = [[NSMutableDictionary alloc]init ];
    [dicDetail setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dicDetail setValue:[dic objectForKey:@"userId"] forKey:@"friendId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"remindMsg.jhtml");
    post.postData = [Utility createPostData:dicDetail];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
        [self request];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
}
-(void) friendListViewControllerPkAddSuccessful:(SHFriendListViewController *)control type:(int) index
{
    [self request];
}
@end
