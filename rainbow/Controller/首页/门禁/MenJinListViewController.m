//
//  MenJinListViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/7/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "MenJinListViewController.h"
#import "OpenDoorViewController.h"
@interface MenJinListViewController ()

@end

@implementation MenJinListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"门禁"];
    dataArray=[[NSMutableArray alloc] init];
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"address_findDoorinfo"];
    [api address_findDoorinfo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
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
        
        [LSFUtil addSubviewImage:@"lsf93" rect:CGRectMake(10,17, 27/2, 16) View:cell Tag:1];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(30, 0, SCREEN_WIDTH-70, 50) View:cell Alignment:0 Color:black Tag:2];
        
        [LSFUtil addSubviewImage:@"lsf27" rect:CGRectMake(SCREEN_WIDTH-30,15, 20, 20) View:cell Tag:3];
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 49, SCREEN_WIDTH, 1) view:cell];
        
    }
    
    UILabel * address =(UILabel*)[cell viewWithTag:2];
    
    NSDictionary * dic=dataArray[indexPath.row];
    
    address.text=[NSString stringWithFormat:@"%@ %@",dic[@"cellName"],dic[@"buildingName"]]
    ;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OpenDoorViewController * door =[[OpenDoorViewController alloc] init];
    
    door.Dic=dataArray[indexPath.row];
    
    [self.navigationController pushViewController:door animated:YES];

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
