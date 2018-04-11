//
//  WXListViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/12.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "WXListViewController.h"
#import "WXDetailViewController.h"
@interface WXListViewController ()

@end

@implementation WXListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"报修记录"];
    dataArray=[[NSMutableArray alloc] init];
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
    [self getData];
    
}
-(void)getData{

    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"findPropertyCustomsByUserId"];
    [api findPropertyCustomsByUserId];
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
    
    return 120;
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
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(15, 35, SCREEN_WIDTH-25, 40) View:cell Alignment:0 Color:gray Tag:2];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(15, 80, SCREEN_WIDTH/2, 20) View:cell Alignment:0 Color:Red Tag:3];

        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(0, 80, SCREEN_WIDTH-10, 20) View:cell Alignment:2 Color:gray Tag:4];

        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 110, SCREEN_WIDTH, 10) view:cell];
        
    }
    
    UILabel * lb1 =(UILabel *)[cell viewWithTag:1];
    UILabel * lb2 =(UILabel *)[cell viewWithTag:2];
    UILabel * lb3 =(UILabel *)[cell viewWithTag:3];
    UILabel * lb4 =(UILabel *)[cell viewWithTag:4];
    
    

    NSDictionary * dic=dataArray[indexPath.row];
    
    lb1.text=dic[@"propertytype"][@"name"];
    
    lb2.text=dic[@"content"];
    
    NSInteger status =[dic[@"status"] integerValue];
    
    lb3.text=status==0?@"未处理":@"已处理";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dic[@"date"] integerValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    lb4.text=confromTimespStr;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WXDetailViewController * d =[[WXDetailViewController alloc] init];
    NSDictionary * dic=dataArray[indexPath.row];
    d.wxId=dic[@"id"];
    d.completeBlockNone=^{
    
        [self getData];
    };
    [self.navigationController pushViewController:d animated:YES];

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
