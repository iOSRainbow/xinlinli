//
//  Mine_addressListViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "Mine_addressListViewController.h"
#import "Mine_add_addressViewController.h"

@interface Mine_addressListViewController ()

@end

@implementation Mine_addressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"社区地址管理"];
    
    dataArray=[[NSMutableArray alloc] init];
    
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight-50) Tag:1 View:self.view delegate:self dataSource:self];
    
    
    [self getData];
    
    UIButton*add=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(40,BottomHeight,SCREEN_WIDTH-80, 40) title:@"+添加地址" select:@selector(Action:) Tag:3 View:self.view textColor:white Size:font14 background:MS_RGB(250,82,2)];
    add.layer.cornerRadius=5;
    add.layer.masksToBounds=YES;
    
}

-(void)getData{

    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"address_findByUserId"];
    [api address_findByUserId];

}

-(void)Action:(UIButton *)btn{

    Mine_add_addressViewController * add =[[Mine_add_addressViewController alloc] init];
    
    add.completeBlockNone=^{
    
        [self getData];
    };
    [self.navigationController pushViewController:add animated:YES];

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
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(15, 10, SCREEN_WIDTH-100, 20) View:cell Alignment:0 Color:gray Tag:1];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(0, 10, SCREEN_WIDTH-10, 20) View:cell Alignment:2 Color:Red Tag:2];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(15, 35, SCREEN_WIDTH-20, 20) View:cell Alignment:0 Color:gray Tag:3];

        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 60, SCREEN_WIDTH, 1) view:cell];
        
        UIButton*btn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-100, 70, 90, 30) title:nil select:@selector(CellDelteAction:) Tag:8888 View:cell textColor:nil Size:font14 background:nil];
        [btn setAttributedTitle:[LSFUtil ButtonAttriSring:@" 删除" color:gray image:@"lsf43" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];
        
        
        UIButton*btn1= [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(15, 70,130, 30) title:nil select:@selector(CellClickAction:) Tag:6666 View:cell textColor:nil Size:font14 background:nil];
        btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 105, SCREEN_WIDTH, 10) view:cell];

        
    }
    
    
    UILabel * name =(UILabel*)[cell viewWithTag:1];
    UILabel * status =(UILabel*)[cell viewWithTag:2];
    UILabel * address =(UILabel*)[cell viewWithTag:3];
    UIButton * change =(UIButton *)[cell viewWithTag:6666];
    
    NSDictionary * dic=dataArray[indexPath.row];
    
    name.text=[NSString stringWithFormat:@"%@ %@",dic[@"user"][@"realname"],dic[@"user"][@"username"]];
    address.text=[NSString stringWithFormat:@"%@%@%@%@%@栋%@",dic[@"province"][@"name"],dic[@"city"][@"name"],dic[@"region"][@"name"],dic[@"cell"][@"name"],dic[@"buildingname"],dic[@"roomname"]];
    
    status.text=[dic[@"isenable"] integerValue]==0?@"未认证":@"已认证";
    change.hidden=[dic[@"isenable"] integerValue]==0?YES:NO;

    [change setAttributedTitle:[LSFUtil ButtonAttriSring:@" 默认地址" color:MS_RGB(250,82,2) image:[dic[@"state"] integerValue]==0?@"lsf44":@"lsf28" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)CellClickAction:(UIButton*)btn{

    if(IOS8_OR_LATER)
    {
        UITableViewCell * cell = (UITableViewCell *)btn.superview;
        NSIndexPath *indexPath = [tableview  indexPathForCell:cell];
        cellTag=indexPath.row;
    }
    else
    {
        UITableViewCell * cell = (UITableViewCell *)btn.superview.superview;
        NSIndexPath *indexPath = [tableview  indexPathForCell:cell];
        cellTag=indexPath.row;

    }
    
    NSDictionary * dic=dataArray[cellTag];
   
    if([dic[@"state"] integerValue]==0){

    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否更改默认地址" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        
        Api * api =[[Api alloc] init:self tag:@"updateDefaultAddress"];
        [api updateDefaultAddress:dic[@"id"]];
        
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
    }
    
}
-(void)CellDelteAction:(UIButton*)btn{

    if(IOS8_OR_LATER)
    {
        UITableViewCell * cell = (UITableViewCell *)btn.superview;
        NSIndexPath *indexPath = [tableview  indexPathForCell:cell];
        cellTag=indexPath.row;

    }
    else
    {
        UITableViewCell * cell = (UITableViewCell *)btn.superview.superview;
        NSIndexPath *indexPath = [tableview  indexPathForCell:cell];
        cellTag=indexPath.row;

    }
    
    
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否删除此地址" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        NSDictionary * dic=dataArray[cellTag];
        
        Api * api =[[Api alloc] init:self tag:@"deleteAddressWithUserId"];
        [api deleteAddressWithUserId:dic[@"id"]];
        
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if([_fromView isEqualToString:@"JZPayView"]){
    
        self.completeBlockNSDictionary(dataArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }


}
-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    if([tag isEqualToString:@"address_findByUserId"]){
        
        [emptyView removeFromSuperview];
        emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:message];

    }
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    
    if([tag isEqualToString:@"address_findByUserId"]){
    
        [dataArray removeAllObjects];
        [emptyView removeFromSuperview];

        dataArray=response[@"data"];
        if(dataArray.count==0){
            
            emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:@""];
            return;
        }
        [tableview reloadData];
        
        [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            NSInteger isenable =[obj[@"isenable"] integerValue];
            NSInteger state =[obj[@"state"] integerValue];
            if(isenable==1&&state==1){
            
                [myUserDefaults setObject:[LSFEasy isEmpty:obj[@"cellId"]]?@"":obj[@"cellId"] forKey:@"cellId"];
                [myUserDefaults synchronize];
                *stop=YES;
            }

        }];
        
    
    }
    if([tag isEqualToString:@"deleteAddressWithUserId"]||[tag isEqualToString:@"updateDefaultAddress"]){
    
        [self showHint:response[@"msg"]];
        [self getData];
    }
}
@end
