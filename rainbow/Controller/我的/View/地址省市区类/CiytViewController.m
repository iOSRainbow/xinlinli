//
//  CiytViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/11.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "CiytViewController.h"

@interface CiytViewController ()

@end

@implementation CiytViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"选择所在城市"];
    dataArray=[[NSMutableArray alloc] init];
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"findCitysByProvinceId"];
    [api findCitysByProvinceId:self.proviceId];
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
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(15, 0, SCREEN_WIDTH-25, 50) View:cell Alignment:0 Color:gray Tag:1];
        
        
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 49, SCREEN_WIDTH, 1) view:cell];
        
    }
    
    UILabel * lb1 =(UILabel *)[cell viewWithTag:1];
    
    NSDictionary * dic=dataArray[indexPath.row];
    
    lb1.text=dic[@"name"];
    

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.completeBlockNSDictionary(dataArray[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
    
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
        
        emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:@""] ;
        return;
    }
    [tableview reloadData];
    
}

@end
