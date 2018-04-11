//
//  CommentListViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/6/20.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "CommentListViewController.h"

@interface CommentListViewController ()

@end

@implementation CommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"全部评论"];
    
    dataArray=[[NSMutableArray alloc] init];
    
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"comment_list"];
    [api comment_list:_goodsId];
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
    
    return 80;
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
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 10, SCREEN_WIDTH-20, 20) View:cell Alignment:0 Color:Red Tag:1];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(0, 10, SCREEN_WIDTH-10, 20) View:cell Alignment:2 Color:gray Tag:2];
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 30, SCREEN_WIDTH-20, 40) View:cell Alignment:0 Color:gray Tag:3];
        
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 79, SCREEN_WIDTH, 1) view:cell];
        
    }
    
    UILabel * lb1 =(UILabel *)[cell viewWithTag:1];
    UILabel * lb2 =(UILabel *)[cell viewWithTag:2];
    UILabel * lb3 =(UILabel *)[cell viewWithTag:3];

    
    NSDictionary * dic=dataArray[indexPath.row];
   
    NSString* str=[NSString stringWithFormat:@"%@   %@",dic[@"username"],dic[@"satis"]];
    
    NSMutableAttributedString *attri =[[NSMutableAttributedString alloc] initWithString:str];
    
    
    [attri addAttribute:NSForegroundColorAttributeName
     
                  value:gray
     
                  range:NSMakeRange(0, [dic[@"username"] length])];
    
    
    lb1.attributedText=attri;

    
    lb2.text=[self getTime:dic[@"entrytime"]];
    lb3.text=dic[@"detail"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(NSString*)getTime:(NSString*)time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time integerValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return  [LSFEasy isEmpty:time]?@" ":confromTimespStr;
    
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
