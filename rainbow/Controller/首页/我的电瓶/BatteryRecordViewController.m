//
//  BatteryRecordViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/9/5.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "BatteryRecordViewController.h"

@interface BatteryRecordViewController ()

@end

@implementation BatteryRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"更换记录"];
    
    dataArray=[[NSMutableArray alloc] init];
    
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
    
    [self getData];
    
}


-(void)getData{
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"battery_getOldBatteryList"];
    [api battery_getOldBatteryList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 5,SCREEN_WIDTH-15, 20) View:cell Alignment:0 Color:black Tag:1];

        
        [LSFUtil labelName:nil fontSize:font12 rect:CGRectMake(0, 25,SCREEN_WIDTH-10, 20) View:cell Alignment:2 Color:gray Tag:2];
        
        UILabel*line= [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(10, 49, SCREEN_WIDTH-10, 1) view:cell];
        line.tag=3;
    }
    
    UILabel * title =(UILabel*)[cell viewWithTag:1];
    UILabel * time =(UILabel*)[cell viewWithTag:2];
    UILabel * line =(UILabel*)[cell viewWithTag:3];
    
    NSDictionary * dic =dataArray[indexPath.row];
    
    title.text=[NSString stringWithFormat:@"%@ (%@)",dic[@"parameter"],indexPath.row==0?@"新的信息":@"旧的信息"];
    
    time.text=[self getTime:dic[@"date"]];
    
    line.hidden=(dataArray.count-1==indexPath.row)?YES:NO;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)Failed:(NSString*)message tag:(NSString*)tag{
    
    [self hideHud];
    [self showHint:message];
}

-(void)Sucess:(id)response tag:(NSString*)tag{
    
    [self hideHud];
    [dataArray removeAllObjects];
    dataArray=response[@"data"];
    [tableview reloadData];
}

-(NSString*)getTime:(NSString*)time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return  [LSFEasy isEmpty:time]?@" ":confromTimespStr;
    
}
@end
