//
//  Mine_DuiHuanHLViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/10.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "Mine_DuiHuanHLViewController.h"

@interface Mine_DuiHuanHLViewController ()

@end

@implementation Mine_DuiHuanHLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"兑换记录"];
    dataArray=[[NSMutableArray alloc] init];
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"giftRecord"];
    [api giftRecord];
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
    
    return 90;
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
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(15, 10, SCREEN_WIDTH-25, 20) View:cell Alignment:0 Color:gray Tag:1];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(15, 35, SCREEN_WIDTH-25, 20) View:cell Alignment:0 Color:gray Tag:2];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(15, 60, SCREEN_WIDTH-25, 20) View:cell Alignment:0 Color:gray Tag:3];
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 89, SCREEN_WIDTH, 1) view:cell];
        
    }
    
    UILabel * lb1 =(UILabel *)[cell viewWithTag:1];
    UILabel * lb2 =(UILabel *)[cell viewWithTag:2];
    UILabel * lb3 =(UILabel *)[cell viewWithTag:3];
    
    NSDictionary * dic=dataArray[indexPath.row];
    
    lb1.text=dic[@"reason"];
    
    lb2.text=[NSString stringWithFormat:@"消费积分: %@",dic[@"points"]];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dic[@"date"] integerValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    lb3.text=confromTimespStr;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}


-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    [emptyView removeFromSuperview];

    emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:message];

}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    
    [dataArray removeAllObjects];
    [emptyView removeFromSuperview];

    dataArray=response[@"data"];
    if(dataArray.count==0){
        
        emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:@""];
        return;
    }
    [tableview reloadData];
    
}
@end
