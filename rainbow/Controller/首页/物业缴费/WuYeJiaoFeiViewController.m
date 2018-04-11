//
//  WuYeJiaoFeiViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/23.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "WuYeJiaoFeiViewController.h"

@interface WuYeJiaoFeiViewController ()

@end

@implementation WuYeJiaoFeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"缴费记录"];

    dataArray=[[NSMutableArray alloc] init];
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"cellpayList"];
    [api cellpayList];
    
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
    
    return 115;
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
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(15, 10, SCREEN_WIDTH-20, 20) View:cell Alignment:0 Color:gray Tag:1];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(15,35, SCREEN_WIDTH-20, 20) View:cell Alignment:0 Color:gray Tag:5];

        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(15,60, SCREEN_WIDTH-20, 20) View:cell Alignment:0 Color:gray Tag:2];

        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(15,85, SCREEN_WIDTH/2, 20) View:cell Alignment:0 Color:gray Tag:3];

        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(SCREEN_WIDTH/2,85, SCREEN_WIDTH/2-10, 20) View:cell Alignment:2 Color:gray Tag:4];

        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 114, SCREEN_WIDTH, 1) view:cell];
        
    }
    
    UILabel * name =(UILabel *)[cell viewWithTag:1];
    UILabel * price =(UILabel *)[cell viewWithTag:2];
    UILabel * cellName =(UILabel *)[cell viewWithTag:3];
    UILabel * date =(UILabel *)[cell viewWithTag:4];
    UILabel * month =(UILabel *)[cell viewWithTag:5];


    NSDictionary * dic=dataArray[indexPath.row];
    
    /*
     
     data{ id缴费ID;addressId地址ID;userId用户id months缴费月数 price缴费价格
     downtime缴费时间userName用户名cellName小区名building楼号roomname房间号}
     */
    
    name.text=[NSString stringWithFormat:@"用户名: %@",dic[@"userName"]];
    month.text=[NSString stringWithFormat:@"缴费月数: %@",dic[@"months"]];

    price.text=[NSString stringWithFormat:@"缴费金额: %@",dic[@"price"]];
    cellName.text=[NSString stringWithFormat:@"%@小区",dic[@"cellName"]];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dic[@"downtime"] integerValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    date.text=confromTimespStr;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    [emptyView removeFromSuperview];

    [dataArray removeAllObjects];
    dataArray=response[@"data"];
    if(dataArray.count==0){
        
        emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:@""];
        return;
    }
    [tableview reloadData];
    
}


@end
