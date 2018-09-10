//
//  OrderListViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/15.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "OrderListViewController.h"
#import "EvationViewController.h"
@interface OrderListViewController ()

@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"我的订单"];
    
    dataArray=[[NSMutableArray alloc] init];
    
    tableview =[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
    [self getData];
    
    
}

-(void)getData{

    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"orderList"];
    [api orderList];

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
    
    NSDictionary * dic=dataArray[indexPat.row];

    NSInteger status=[dic[@"status"] integerValue];
    if(status==1||status==4||status==3){
        
        return 175;
    }
    return 130;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 10, SCREEN_WIDTH-100, 20) View:cell Alignment:0 Color:gray Tag:1];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(SCREEN_WIDTH-100, 10, 90, 20) View:cell Alignment:2 Color:Red Tag:5];

        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 35, SCREEN_WIDTH-20, 20) View:cell Alignment:0 Color:gray Tag:2];
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 60, SCREEN_WIDTH-20, 20) View:cell Alignment:0 Color:gray Tag:3];
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 85, SCREEN_WIDTH-20, 20) View:cell Alignment:0 Color:gray Tag:4];

        
        UIButton*btn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-100, 80, 90, 35) title:nil select:@selector(OrderStatusAction:) Tag:6666 View:cell textColor:white Size:font14 background:MS_RGB(250,82,2)];
        btn.layer.cornerRadius=4;
        btn.layer.masksToBounds=YES;
        
        
       UILabel *line= [LSFUtil setXianTiao:[LSFEasy getColor:@"f2f2f2"] rect:CGRectMake(0, 120, SCREEN_WIDTH, 10) view:cell];
        line.tag=6;
    }
    
    UILabel * goodsname=(UILabel*)[cell viewWithTag:1];
    UILabel * dateTime=(UILabel*)[cell viewWithTag:2];
    UILabel * price=(UILabel*)[cell viewWithTag:3];
    UILabel * address=(UILabel*)[cell viewWithTag:4];
    UILabel * orderStatus=(UILabel*)[cell viewWithTag:5];

    
    UIButton * btn=(UIButton*)[cell viewWithTag:6666];
    
    UILabel * line =(UILabel*)[cell viewWithTag:6];
    
    btn.hidden=YES;
    
    NSDictionary * dic=dataArray[indexPath.row];
    
    goodsname.text=[NSString stringWithFormat:@"订单名称:%@",dic[@"goodsname"]];
    dateTime.text=[NSString stringWithFormat:@"下单时间:%@",[self getTime:dic[@"servicetime"]]];
    price.text=[NSString stringWithFormat:@"订单价格:%@",dic[@"realprice"]];
    address.text=[NSString stringWithFormat:@"服务地址:%@",dic[@"address"]];
    
    
    NSInteger status=[dic[@"status"] integerValue];
    if(status==1){
        
        orderStatus.text=@"未接单";
        // 取消  确认
        btn.hidden=NO;
        [btn setTitle:@"取消订单" forState:normal];
        btn.frame=CGRectMake(SCREEN_WIDTH-100, 120, 90, 35);
        line.frame=CGRectMake(0,165, SCREEN_WIDTH, 10);
        
    }else if (status==2){
        
        orderStatus.text=@"已取消";
        line.frame=CGRectMake(0,120, SCREEN_WIDTH, 10);

        
    }else if (status==3){
        
        orderStatus.text=@"已接单";
        btn.hidden=NO;
        [btn setTitle:@"确认订单" forState:normal];
        btn.frame=CGRectMake(SCREEN_WIDTH-100, 120, 90, 35);
        line.frame=CGRectMake(0,165, SCREEN_WIDTH, 10);

    }else if (status==4){
        
        orderStatus.text=@"待评论";
        btn.hidden=NO;
        [btn setTitle:@"去点评" forState:normal];
        btn.frame=CGRectMake(SCREEN_WIDTH-100, 120, 90, 35);
        line.frame=CGRectMake(0,165, SCREEN_WIDTH, 10);

    }else if (status==5){
        
        orderStatus.text=@"已评论";
        line.frame=CGRectMake(0,120, SCREEN_WIDTH, 10);

    }
   
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)OrderStatusAction:(UIButton*)btn{

    
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
    
    
    if([btn.titleLabel.text isEqualToString:@"去点评"]){
        
        EvationViewController * e =[[EvationViewController alloc] init];
        e.Dic=dic;
        e.completeBlockNone=^{
            
            Api * api =[[Api alloc] init:self tag:@"orderList"];
            [api orderList];
        };
        [self.navigationController pushViewController:e animated:YES];
        
        
    }else
        
        if([btn.titleLabel.text isEqualToString:@"确认订单"]){
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否确认订单已完成" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            Api * api =[[Api alloc] init:self tag:@"sureOrder"];
            [api sureOrder:dic[@"id"]];
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
        }
        else
    
        {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否取消订单" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            Api * api =[[Api alloc] init:self tag:@"cancelOrder"];
            [api cancelOrder:dic[@"id"]];
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    
}
    
}


#pragma mark - Api回调
- (void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    NSLog(@"apiError=%@",message);
    [self showHint:message];
    
    if([tag isEqualToString:@"orderList"]){
    [emptyView removeFromSuperview];
    emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight-55) view:self.view title:message];
    }
    
}

- (void)Sucess:(id)response tag:(NSString*)tag
{
    [self hideHud];
    if([tag isEqualToString:@"orderList"]){
      
        [emptyView removeFromSuperview];
        [dataArray removeAllObjects];
        dataArray=response[@"data"];
        
        if(dataArray.count==0){
            
            emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:@""];
        }
        [tableview reloadData];
    }
    else{
    
         [self showHint:response[@"msg"]];
         Api * api =[[Api alloc] init:self tag:@"orderList"];
         [api orderList];
    }
}


-(NSString*)getTime:(NSString*)time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return  [LSFEasy isEmpty:time]?@" ":confromTimespStr;
    
}

@end
