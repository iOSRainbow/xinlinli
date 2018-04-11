//
//  Mine_RlistViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/10.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "Mine_RlistViewController.h"
#import "Mine_infoViewController.h"
#import "Mine_accountListViewController.h"
#import "WuYeWXViewController.h"
#import "FriendListViewController.h"
@interface Mine_RlistViewController ()

@end

@implementation Mine_RlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"积分任务"];
    gouArray=[[NSMutableArray alloc] init];
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
    UIView * view=[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, 40) view:nil backgroundColor:white];
    
    [LSFUtil labelName:@"日期" fontSize:font14 rect:CGRectMake(0, 0, SCREEN_WIDTH/3, 40) View:view Alignment:1 Color:gray Tag:1];
    
    [LSFUtil labelName:@"积分" fontSize:font14 rect:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 40) View:view Alignment:1 Color:gray Tag:1];
    
    
    [LSFUtil labelName:@"任务" fontSize:font14 rect:CGRectMake(2*(SCREEN_WIDTH/3), 0, SCREEN_WIDTH/3, 40) View:view Alignment:1 Color:gray Tag:1];

    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 39, SCREEN_WIDTH, 1) view:view];
    
    tableview.tableHeaderView=view;
    
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"assignList"];
    [api assignList];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        
        
        [LSFUtil labelName:[LSFEasy getNowDate] fontSize:font14 rect:CGRectMake(0, 0, SCREEN_WIDTH/3, 50) View:cell Alignment:1 Color:gray Tag:1];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3,50) View:cell Alignment:1 Color:MS_RGB(250,82,2) Tag:2];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake((SCREEN_WIDTH/3)*2, 0, SCREEN_WIDTH/3, 50) View:cell Alignment:1 Color:gray Tag:3];
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 49, SCREEN_WIDTH, 1) view:cell];
        
    }
    
    UILabel * lb1 =(UILabel *)[cell viewWithTag:2];

    UILabel * lb =(UILabel *)[cell viewWithTag:3];
    
    lb1.text=[NSString stringWithFormat:@"%@",scoreArray[indexPath.row]];
    
    NSInteger  a =[gouArray[indexPath.row] integerValue];
    
    [lb setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@"%@ ",dataArray[indexPath.row]] color:gray image:a==0?@"lsf44":@"lsf28" type:2 rect:CGRectMake(0, -5, 20, 20)]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger a =[gouArray[indexPath.row] integerValue];
    if(a==1){
    
        return;
    }
    
    
    if(indexPath.row==0){
    
        [self.navigationController popViewControllerAnimated:YES];
    
    }
    else if (indexPath.row==1){
    
        FriendListViewController * my =[[FriendListViewController alloc] init];
        [self.navigationController pushViewController:my animated:YES];
    
    }
    else if (indexPath.row>=2&&indexPath.row<=5){
    
        Mine_infoViewController * my =[[Mine_infoViewController alloc] init];
        [self.navigationController pushViewController:my animated:YES];
        
    }
    else if (indexPath.row==6){
    
        WuYeWXViewController * list =[[WuYeWXViewController alloc] init];
        [self.navigationController pushViewController:list animated:YES];
    }


}
-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    [self hideHud];
    
    dataArray=[[NSMutableArray alloc] initWithObjects:@"每日签到",@"每日发帖",@"完善头像",@"完善昵称",@"完善性别",@"完善生日",@"物业保修",nil];

    scoreArray=[[NSMutableArray alloc] initWithObjects:@"+1",@"+1",@"+5",@"+5",@"+5",@"+5",@"+5",nil];

    NSDictionary * dic=response[@"data"];
    
    [gouArray addObject:[NSString stringWithFormat:@"%@",dic[@"isSign"]]];
    [gouArray addObject:[NSString stringWithFormat:@"%@",dic[@"lin"]]];
    [gouArray addObject:[NSString stringWithFormat:@"%@",dic[@"top"]]];
    [gouArray addObject:[NSString stringWithFormat:@"%@",dic[@"name"]]];
    [gouArray addObject:[NSString stringWithFormat:@"%@",dic[@"sex"]]];
    [gouArray addObject:[NSString stringWithFormat:@"%@",dic[@"birthday"]]];
    [gouArray addObject:[NSString stringWithFormat:@"%@",dic[@"bao"]]];
    
    [tableview reloadData];
    
}
@end
