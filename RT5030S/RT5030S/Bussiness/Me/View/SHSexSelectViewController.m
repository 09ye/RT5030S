//
//  SHSexSelectViewController.m
//  RT5030S
//
//  Created by yebaohua on 14-10-8.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHSexSelectViewController.h"

@interface SHSexSelectViewController ()

@end

@implementation SHSexSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"性别选择";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" target:self action:@selector(confirme)];
    self.sex = [self.intent.args objectForKey:@"sex"];
    // Do any additional setup after loading the view from its nib.
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_GENERAL_HEIGHT2;
}
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
    
}
- (SHTableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHTableViewGeneralCell * cell  = [[[NSBundle mainBundle]loadNibNamed:@"SHTableViewGeneralCell" owner:nil options:nil]objectAtIndex:0];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor whiteColor];
    if(indexPath.row==0){
        cell.labTitle.text = @"男";
        if ([self.sex isEqualToString:@"M"]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }else if(indexPath.row==1){
        cell.labTitle.text = @"女";
        if ([self.sex isEqualToString:@"F"]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    return cell ;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        self.sex = @"M";
    }else if (indexPath.row == 1){
        self.sex = @"F";
    }
    [self.tableView reloadData];
}
-(void) confirme
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sexSelectViewControllerDidSelect:sex:)]) {
        [self.delegate sexSelectViewControllerDidSelect:self sex:self.sex];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
