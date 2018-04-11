//
//  GetAddressListViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/2/27.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "GetAddressListViewController.h"
#import "addressAddViewController.h"

@interface GetAddressListViewController ()

@end

@implementation GetAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"收货地址管理"];
    
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
    [api goodsAddress_findByUserId];
    
}

-(void)Action:(UIButton *)btn{
    
    addressAddViewController * add =[[addressAddViewController alloc] init];
   
    __weak typeof(self)weakSelf=self;
    add.completeBlockNone=^{
        
        [weakSelf getData];
    };
    add.Dict=nil;
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
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 10, SCREEN_WIDTH-20, 20) View:cell Alignment:0 Color:gray Tag:1];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 40, SCREEN_WIDTH-20, 20) View:cell Alignment:0 Color:gray Tag:2];
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 70, SCREEN_WIDTH, 1) view:cell];
        
        UIButton*btn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-100, 70, 90, 40) title:nil select:@selector(CellDelteAction:) Tag:8888 View:cell textColor:nil Size:font14 background:nil];
        [btn setAttributedTitle:[LSFUtil ButtonAttriSring:@" 删除" color:gray image:@"lsf43" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];
        
        
        UIButton*btn1= [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-210, 70,90, 40) title:nil select:@selector(CellClickAction:) Tag:6666 View:cell textColor:nil Size:font14 background:nil];
        [btn1 setAttributedTitle:[LSFUtil ButtonAttriSring:@" 编辑" color:gray image:@"lsf23" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];

        [LSFUtil setXianTiao:[LSFEasy getColor:@"f2f2f2"] rect:CGRectMake(0, 110, SCREEN_WIDTH, 10) view:cell];
        
        
    }
    
    
    UILabel * name =(UILabel*)[cell viewWithTag:1];
    UILabel * address =(UILabel*)[cell viewWithTag:2];
    
    NSDictionary * dic=dataArray[indexPath.row];
    
    name.text=[NSString stringWithFormat:@"%@   %@",dic[@"name"],dic[@"tel"]];
    address.text=dic[@"address"];
    
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
    
    addressAddViewController * add =[[addressAddViewController alloc] init];
    
    __weak typeof(self)weakSelf=self;
    add.completeBlockNone=^{
        
        [weakSelf getData];
    };
    add.Dict=dic;
    [self.navigationController pushViewController:add animated:YES];
    
    
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
        [api goodsaddress_delete:dic[@"id"]];
        
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
        }
        [tableview reloadData];
        
    }
   else if([tag isEqualToString:@"deleteAddressWithUserId"]){
        
        [self showHint:response[@"msg"]];
        [self getData];
    }
}

@end
