//
//  SHMessageViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-10-15.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHMessageViewController.h"

@interface SHMessageViewController ()

@end

@implementation SHMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void) request
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:@"" forKey:@"type"];
    [dic setValue:@"0" forKey:@"read"];
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"listMsg.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        NSDictionary * result = [[task result]mutableCopy];
        mList = [[result objectForKey:@"msgs"]mutableCopy];
        [self.tableView reloadData];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self request];
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
    NSDictionary * obj = [ mList objectAtIndex:indexPath.row];
    SHTableViewGeneralCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shtabview_general_cell"];
    if(cell == nil){
        cell = (SHTableViewGeneralCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHTableViewGeneralCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.labTitle.text = [obj valueForKey:@"content"];
    [cell alternate:indexPath];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSDictionary * detail = [mList objectAtIndex:indexPath.row];
    if([detail objectForKey:@"type"]== 0)//
    {
        [self readMessage:indexPath];
    }else{
        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHFriendDetailViewController";
        intent.container = self.navigationController;
        [intent.args setValue:@"message" forKey:@"classType"];
        [intent.args setValue:[detail objectForKey:@"sendId"] forKey:@"userId"];
        [intent.args setValue:[detail objectForKey:@"msgId"] forKey:@"msgId"];
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
    
    [self readMessage:indexPath];
    
}
-(void) readMessage:(NSIndexPath *)indexPath
{
    NSDictionary * detail = [mList objectAtIndex:indexPath.row];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:[detail objectForKey:@"msgId" ] forKey:@"msgId"];
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"readMsg.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [mList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
}

@end
