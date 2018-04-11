//
//  GetUserAddressViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/12.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "GetUserAddressViewController.h"

@interface GetUserAddressViewController ()

@end

@implementation GetUserAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"可用地址"];
    dataArray=[[NSMutableArray alloc] init];
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"findCanUseByuserId"];
    [api findCanUseByuserId];
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
    
    lb1.text=[NSString stringWithFormat:@"%@%@%@%@%@栋%@",dic[@"province"][@"name"],dic[@"city"][@"name"],dic[@"region"][@"name"],dic[@"cell"][@"name"],dic[@"buildingname"],dic[@"roomname"]];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cellTag=indexPath.row;
    
    NSDictionary * dic=dataArray[indexPath.row];

    
    if([_fromView isEqualToString:@"物业缴费"])
    {
        [self showHudInView:self.view hint:@"加载中"];
        Api * api =[[Api alloc] init:self tag:@"cellpayDetail"];
        [api cellpayDetail:dic[@"buildingname"] cellId:dic[@"cellId"]];
        
        return;
    }
    self.completeBlockNSDictionary(dic);
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    if(![tag isEqualToString:@"cellpayDetail"]){
        
        [emptyView removeFromSuperview];

        emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:message];

    }
    
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    
    if([tag isEqualToString:@"cellpayDetail"]){
    
        
        NSDictionary * dic1=dataArray[cellTag];
        
        
        NSMutableArray * ary=response[@"data"];
        if(ary.count==0){
            return;
        }
        NSDictionary * dic2=ary[0];
        
        
        NSDictionary * dic=@{@"address":[NSString stringWithFormat:@"%@小区 %@栋%@室",dic1[@"cell"][@"name"],dic1[@"buildingname"],dic1[@"roomname"]],@"name":[NSString stringWithFormat:@"业主姓名: %@",dic1[@"user"][@"realname"]],@"cityName":dic1[@"city"][@"name"],@"bulidingId":dic1[@"buildingname"],@"addressId":dic1[@"id"],@"cellId":dic1[@"cellId"],@"price":dic2[@"price"]};

      
        self.completeBlockNSDictionary(dic);

        [self.navigationController popViewControllerAnimated:YES];

    
    }else{
    
    
        [dataArray removeAllObjects];
        [emptyView removeFromSuperview];

        dataArray=response[@"data"];
        if(dataArray.count==0){
            
            emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:@""];
            return;
        }
        [tableview reloadData];
    
    }

    
}


@end
