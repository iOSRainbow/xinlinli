//
//  Mine_DuiHuanListViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/10.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "Mine_DuiHuanListViewController.h"
#import "Mine_DuiHuanHLViewController.h"
#import "AddGoodViewController.h"

@interface Mine_DuiHuanListViewController ()

@end

@implementation Mine_DuiHuanListViewController

-(void)actNavRightBtn{

    Mine_DuiHuanHLViewController * hl=[[Mine_DuiHuanHLViewController alloc] init];
    [self.navigationController pushViewController:hl animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"积分商城"];
    [self addNavRightBtnWithTitle:@"兑换记录"];

    dataArray=[[NSMutableArray alloc] init];
    
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    UIView * view=[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, 40) view:nil backgroundColor:white];
    
    intergalLb=[LSFUtil labelName:[NSString stringWithFormat:@"我的积分: %@",@"0"] fontSize:font14 rect:CGRectMake(15, 0, SCREEN_WIDTH-30, 40) View:view Alignment:0 Color:gray Tag:1];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 39, SCREEN_WIDTH, 1) view:view];
    
    tableview.tableHeaderView=view;
    
    
    Api * api1 =[[Api alloc] init:self tag:@"pointsCountByUserId"];
    [api1 pointsCountByUserId];
    
    [self getData];
    
 
}

-(void)getData{

    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"getGifts"];
    [api getGifts];
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
    
    return 90;
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
        
        
        [LSFUtil addSubviewImage:nil rect:CGRectMake(10, 10, 70, 70) View:cell Tag:1];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(90, 10, SCREEN_WIDTH-95, 20) View:cell Alignment:0 Color:gray Tag:2];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(90, 35, SCREEN_WIDTH-95, 20) View:cell Alignment:0 Color:gray Tag:3];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(90, 60, SCREEN_WIDTH-95, 20) View:cell Alignment:0 Color:gray Tag:4];

        
       UIButton*btn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-90, 40, 80, 30) title:@"兑换" select:@selector(CellDelteAction:) Tag:8888 View:cell textColor:white Size:font14 background:orange];
        btn.layer.cornerRadius=4;
        btn.layer.masksToBounds=YES;

        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 89, SCREEN_WIDTH, 1) view:cell];
    }
    
    UIImageView * img =(UIImageView*)[cell viewWithTag:1];
    UILabel * lb1=(UILabel*)[cell viewWithTag:2];
    UILabel * lb2=(UILabel*)[cell viewWithTag:3];
    UILabel * lb3=(UILabel*)[cell viewWithTag:4];
    UIButton * btn =(UIButton *)[cell viewWithTag:8888];
    
    NSDictionary * dic=dataArray[indexPath.row];
    
    
    
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=g",urlStr,dic[@"photourl"]]] placeholderImage:nil];

    lb1.text=[NSString stringWithFormat:@"商品名称: %@",dic[@"name"]];
    lb2.text=[NSString stringWithFormat:@"商品价格: %@",dic[@"points"]];
    lb3.text=[NSString stringWithFormat:@"商品库存: %@",dic[@"stock"]];
    
    NSInteger a =[dic[@"stock"]  integerValue];
    
    [btn setTitle:a==0?@"已兑完":@"兑换" forState:normal];
    btn.backgroundColor=a==0?gray:orange;
    
    /*
     data{id礼品id，name礼品名
     photourl图片名，points积分
     stock 剩余量，isenable可用状态
     selleruserid商家id，
     selleruser商家信息}
     */
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
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
    
    NSDictionary * dic =dataArray[cellTag];

    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否兑换该商品" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self showHudInView:self.view hint:@"加载中"];
        Api * api =[[Api alloc] init:self tag:@"giftExchange"];
        [api giftExchange:dic[@"id"]];

        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
    

    
    
}



-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    if([tag isEqualToString:@"getGifts"]){
        [emptyView removeFromSuperview];
        emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:message];

    }
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    if([tag isEqualToString:@"getGifts"]){
        [emptyView removeFromSuperview];

        [dataArray removeAllObjects];
        dataArray=response[@"data"];
        if(dataArray.count==0){
            
            emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:@""];
            return;
        }
        [tableview reloadData];
    }
    
    if([tag isEqualToString:@"giftExchange"]){
    
        
        NSDictionary * dic=dataArray[cellTag];
        AddGoodViewController * add =[[AddGoodViewController alloc] init];
        add.gifId=dic[@"id"];
        add.completeBlockNone=^{
            
            [self getData];
        };
        
        [self.navigationController pushViewController:add animated:YES];
        
    }
    if([tag isEqualToString:@"pointsCountByUserId"]){
    
        NSDictionary * dic=response[@"data"];
    
        intergalLb.text=[NSString stringWithFormat:@"我的积分: %@",dic[@"points"]];

    }
}


@end
