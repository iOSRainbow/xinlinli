//
//  Mine_accountListViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "Mine_accountListViewController.h"
#import "Mine_add_accountViewController.h"
#import "Mine_modfy_accountViewController.h"

@interface Mine_accountListViewController ()

@end

@implementation Mine_accountListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"管理子账户"];
    
    dataArray=[[NSMutableArray alloc] init];
    
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight-50) Tag:1 View:self.view delegate:self dataSource:self];
    
    
    [self getData];
    
    UIButton*add=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(40,BottomHeight,SCREEN_WIDTH-80, 40) title:@"添加子账户" select:@selector(Action:) Tag:3 View:self.view textColor:white Size:font14 background:MS_RGB(250,82,2)];
    add.layer.cornerRadius=5;
    add.layer.masksToBounds=YES;
}

-(void)getData{
   
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"findSubUsers"];
    [api findSubUsers];

}
-(void)Action:(UIButton*)btn{

    Mine_add_accountViewController * add =[[Mine_add_accountViewController alloc] init];
    add.completeBlockNone=^{
    
        [self getData];
    
    };
    [self.navigationController pushViewController: add animated:YES];

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
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(15, 10, SCREEN_WIDTH-20, 20) View:cell Alignment:0 Color:black Tag:1];

        [LSFUtil labelName:@"子账户密码: ******" fontSize:font14 rect:CGRectMake(15, 35, SCREEN_WIDTH-20, 20) View:cell Alignment:0 Color:black Tag:2];
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 60, SCREEN_WIDTH, 1) view:cell];
        
        UIButton*btn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-100, 70, 90, 30) title:nil select:@selector(CellDelteAction:) Tag:8888 View:cell textColor:nil Size:font14 background:nil];
        [btn setAttributedTitle:[LSFUtil ButtonAttriSring:@" 删除" color:gray image:@"lsf43" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 110, SCREEN_WIDTH, 10) view:cell];
       
        
    }
    
    UILabel *lb =(UILabel *)[cell viewWithTag:1];
    
    NSDictionary * dic=dataArray[indexPath.row];

    lb.text=[NSString stringWithFormat:@"子账户名: %@",dic[@"username"]];
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
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否删除此子账户" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        NSDictionary * dic=dataArray[cellTag];
        
        Api * api =[[Api alloc] init:self tag:@"deleteSubUser"];
        [api deleteSubUser:dic[@"id"]];
        
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    

    
}

-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    if([tag isEqualToString:@"findSubUsers"]){
        [emptyView removeFromSuperview];
        emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:message];

    }
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    
    if([tag isEqualToString:@"findSubUsers"]){
        [emptyView removeFromSuperview];
        [dataArray removeAllObjects];
         dataArray=response[@"data"];
        if(dataArray.count==0){
            
            emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:@""];
            return;
        }
        [tableview reloadData];
        
    }
    if([tag isEqualToString:@"deleteSubUser"]){
    
        [self showHint:response[@"msg"]];
        [self getData];

    }
    
    
}

@end
