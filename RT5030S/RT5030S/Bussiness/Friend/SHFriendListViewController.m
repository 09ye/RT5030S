//
//  SHFriendListViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-21.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHFriendListViewController.h"
#import "SHFrienItemCell.h"

@interface SHFriendListViewController ()

@end
// classType  comper =比一比 好友选择   friendlist= 主页好友类列   familylist= 家庭管理 pk = PK
@implementation SHFriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
   
    if([[self.intent.args objectForKey:@"classType"] isEqualToString:@"familylist"]){
        self.title = @"家庭管理";
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"删除" target:self action:@selector(sss)];
        [self requestFamily];
    }else if([[self.intent.args objectForKey:@"classType"] isEqualToString:@"comper"]||[[self.intent.args objectForKey:@"classType"] isEqualToString:@"pk"]){
        self.title = @"好友列表";
        btnButtomAdd.hidden = YES;
        self.tableView.frame = self.view.bounds;
        [self requestFriends];
        
    }else{
        self.title = @"好友列表";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_addres_title"] target:self action:@selector(goNeighbour)];
        [self requestFriends];
    }
}
-(void) requestFriends
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"listFriend.jhtml");
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
        [task.respinfo show];
    }];
}
-(void) requestFamily
{
    [self showWaitDialogForNetWork];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"listFamily.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        NSDictionary * result = [[task result]mutableCopy];
        mList = [[result objectForKey:@"families"]mutableCopy];
        [self.tableView reloadData];
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
    SHFrienItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"table_friends_cell"];
    if(cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHFrienItemCell" owner:nil options:nil] objectAtIndex:0];
        cell.backgroundColor = [UIColor clearColor];
    }
//    cell.backgroundColor = [UIColor whiteColor];
//    NSDictionary * dic = [[NSDictionary alloc]init];
    cell.detail= [mList objectAtIndex:indexPath.row];
    cell.btnAddFriend.hidden = YES;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    if([[self.intent.args objectForKey:@"classType"] isEqualToString:@"comper"])// 比一比
    {
        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHComparisonViewController";
        intent.container = self.navigationController;
        [intent.args setValue:[dic objectForKey:@"userId"] forKey:@"userId"];
        [[UIApplication sharedApplication] open:intent];
    }else if([[self.intent.args objectForKey:@"classType"] isEqualToString:@"pk"])// pk
    {
        NSMutableDictionary * dicData = [[NSMutableDictionary alloc]init ];
        [dicData setValue:SHEntironment.instance.userId forKey:@"userId"];
        [dicData setValue:[dic objectForKey:@"userId"] forKey:@"friendId"];
        [self showWaitDialogForNetWork];
        SHPostTaskM * post = [[SHPostTaskM alloc]init];
        if([[self.intent.args objectForKey:@"type"]intValue] ==0 ){
            post.URL = URL_FOR(@"applyPK.jhtml");
        }else{
            post.URL = URL_FOR(@"applyRemind.jhtml");
        }
      
        post.postData = [Utility createPostData:dicData];
        post.delegate = self;
        [post start:^(SHTask *task) {
            [self dismissWaitDialog];
            [task.respinfo show];
            if (self.delegate && [self.delegate respondsToSelector:@selector(friendListViewControllerPkAddSuccessful:type:)]) {
                [self.delegate friendListViewControllerPkAddSuccessful:self type:[[self.intent.args objectForKey:@"type"]intValue]];
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        } taskWillTry:^(SHTask *task) {
            
        } taskDidFailed:^(SHTask *task) {
            [self dismissWaitDialog];
            [task.respinfo show];
        }];
    }else if([[self.intent.args objectForKey:@"classType"] isEqualToString:@"familylist"]){
        
       
        if ([[self.intent.args objectForKey:@"type"]isEqualToString:@"switch"]) {
            SHEntironment.instance.userId = [dic valueForKey:@"userId"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            SHIntent * intent = [[SHIntent alloc ]init];
            intent.target = @"SHFamilyDetailViewController";
            intent.container = self.navigationController;
            [intent.args setValue:[dic objectForKey:@"userId"] forKey:@"userId"];
            [[UIApplication sharedApplication] open:intent];
        }
        
    }else{
        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHFriendDetailViewController";
        intent.container = self.navigationController;
        [intent.args setValue:[dic objectForKey:@"userId"] forKey:@"userId"];
        [intent.args setValue:@"Done" forKey:@"classType"];
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
    NSDictionary * detail = [mList objectAtIndex:indexPath.row];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
   
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
  
    if([[self.intent.args objectForKey:@"classType"] isEqualToString:@"familylist"]){
        post.URL = URL_FOR(@"deleteFamily.jhtml");
         [dic setValue:[detail objectForKey:@"userId"] forKey:@"familyId"];
    }else{
        post.URL = URL_FOR(@"deleteFriend.jhtml");
         [dic setValue:[detail objectForKey:@"userId"] forKey:@"friendId"];
        
    }
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        [task.respinfo show];
        [mList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
        [task.respinfo show];
    }];
    
//    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) familyAddViewControllerAddSuccessful:(SHFamilyAddViewController *)control
{
    [self requestFamily];
}

- (IBAction)btnBottomAddOntouch:(id)sender {
    if([[self.intent.args objectForKey:@"classType"] isEqualToString:@"familylist"]){
        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHFamilyAddViewController";
        intent.delegate = self;
        intent.container = self.navigationController;
        
        [[UIApplication sharedApplication] open:intent];
    }else{
        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHNeighboursViewController";
        intent.container = self.navigationController;
        [intent.args setValue:@"A" forKey:@"classType"];
        [[UIApplication sharedApplication] open:intent];
    }
  
}
-(void) goNeighbour
{
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHNeighboursViewController";
    intent.container = self.navigationController;
    [intent.args setValue:@"N" forKey:@"classType"];
    [[UIApplication sharedApplication] open:intent];
}
@end
