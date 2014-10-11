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
// classType  comper =比一比 好友选择
@implementation SHFriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"好友列表";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_addres_title"] target:self action:@selector(goNeighbour)];
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
    SHFrienItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"table_friends_cell"];
    if(cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHFrienItemCell" owner:nil options:nil] objectAtIndex:0];
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
    

    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    [self.tableView reloadData];
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

- (IBAction)btnBottomAddOntouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHNeighboursViewController";
    intent.container = self.navigationController;
    [intent.args setValue:@"A" forKey:@"classType"];
    [[UIApplication sharedApplication] open:intent];
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
