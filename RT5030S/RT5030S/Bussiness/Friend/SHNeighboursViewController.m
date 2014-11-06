//
//  SHNeighboursViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-9-21.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHNeighboursViewController.h"
#import "SHFrienItemCell.h"

@interface SHNeighboursViewController ()

@end
// classType N = 附件好友 。 A = 搜索好友添加
@implementation SHNeighboursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   NSString * type =  [self.intent.args objectForKey:@"classType"];// classType = N 附件的人  A 添加好友
    if([type isEqualToString:@"N"]){
         self.title = @"附近的人";
         mSearch.hidden = YES;
        self.tableView.frame = self.view.bounds;
        [self requestNeighbour];
    }else  if([type isEqualToString:@"A"]){
         self.title = @"添加好友";
        [mSearch becomeFirstResponder];

    }
   
}
-(void) requestNeighbour
{
    [self showWaitDialogForNetWork];
    AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
   
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:[NSNumber numberWithDouble: app.myLocation.location.coordinate.longitude] forKey:@"longitude"];
    [dic setValue:[NSNumber numberWithDouble: app.myLocation.location.coordinate.latitude] forKey:@"latitude"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"locateNear.jhtml");
    post.postData = [Utility createPostData:dic];
    post.delegate = self;
    [post start:^(SHTask *task) {
        [self dismissWaitDialog];
        NSDictionary * result = [[task result]mutableCopy];
        mList = [[result objectForKey:@"persons"]mutableCopy];
        [self.tableView reloadData];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self dismissWaitDialog];
//        [task.respinfo show];
         [self showAlertDialog:task.respinfo.message];
    }];
}
-(void) requestSearch
{
    [mSearch resignFirstResponder];
    [self showWaitDialogForNetWork];//搜索好友
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
    [dic setValue:SHEntironment.instance.userId forKey:@"userId"];
    [dic setValue:mSearch.text forKey:@"nickName"];//(mSearchView.text == nil ? @"" : mSearchView.text )
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"searchFriend.jhtml");
//    post.cachetype = CacheTypeTimes;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    cell.detail = dic;
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
    [intent.args setValue:@"Done" forKey:@"classType"];
    [intent.args setValue:[dic objectForKey:@"userId"] forKey:@"userId"];
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
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
     [self requestSearch];
}

@end
