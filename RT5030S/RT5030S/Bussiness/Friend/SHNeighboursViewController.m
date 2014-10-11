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

@implementation SHNeighboursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   NSString * type =  [self.intent.args objectForKey:@"classType"];// classType = N 附件的人  A 添加好友
    if([type isEqualToString:@"N"]){
         self.title = @"附近的人";
         mSearch.hidden = YES;
        self.tableView.frame = self.view.bounds;
    }else  if([type isEqualToString:@"A"]){
         self.title = @"添加好友";

    }
   
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
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHFriendDetailViewController";
    intent.container = self.navigationController;
    [intent.args setValue:@"Done" forKey:@"classType"];
    [[UIApplication sharedApplication] open:intent];
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
