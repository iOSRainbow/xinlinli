//
//  WuYeTipViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/12.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "WuYeTipViewController.h"
#import "WXTipDetailViewController.h"

@interface WuYeTipViewController ()

@end

@implementation WuYeTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"物业公告"];
    dataArray=[[NSMutableArray alloc] init];
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
 
    
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"cellInfo"];
    [api cellInfo];
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
    
    WuYeTipModel * model =dataArray[indexPat.row];

    return 90+model.picView_height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    WuYeTipCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    
    if (cell == nil) {
        cell = [[WuYeTipCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    
    WuYeTipModel * model =dataArray[indexPath.row];
    [cell updataWithModel:model];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WuYeTipModel * model =dataArray[indexPath.row];

    WXTipDetailViewController * t =[[WXTipDetailViewController alloc] init];
    t.model=model;
    [self.navigationController pushViewController:t animated:YES];
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

    NSArray * ary=response[@"data"];
    for(NSDictionary * dic in ary){
        
        WuYeTipModel * model =[[WuYeTipModel alloc] initWithDictionary:dic];
        [dataArray addObject:model];
    }
    if(dataArray.count==0){
        
        emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:@""];
        return;
    }
    [tableview reloadData];
}

@end
