//
//  DoorCardRecordViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/5/11.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "DoorCardRecordViewController.h"

@interface DoorCardRecordViewController ()

@end

@implementation DoorCardRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"绑定记录"];
    dataArray=[[NSMutableArray alloc] init];
    
    tableView=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    tableView.rowHeight=50;
    
    [self getData];
    
}
-(void)getData{
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"usercard_list"];
    [api usercard_list];
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
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 0, SCREEN_WIDTH-160, 50) View:cell Alignment:0 Color:black Tag:1];
        
        UILabel* lb= [LSFUtil labelName:@"已绑定" fontSize:font14 rect:CGRectMake(SCREEN_WIDTH-140, 10, 60, 30) View:cell Alignment:1 Color:white Tag:2];
        lb.backgroundColor=orange;
        lb.layer.cornerRadius=4;
        lb.layer.masksToBounds=YES;
        
        UIButton*btn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-70, 10, 60, 30) title:nil select:@selector(CellDelteAction:) Tag:8888 View:cell textColor:white Size:font14 background:orange];
        btn.layer.cornerRadius=4;
        btn.layer.masksToBounds=YES;
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 49, SCREEN_WIDTH, 1) view:cell];
        
    }
    
    
    UILabel * name =(UILabel*)[cell viewWithTag:1];
    UIButton * btn =(UIButton*)[cell viewWithTag:8888];
    NSDictionary * dic =dataArray[indexPath.row];
    
    NSInteger status =[dic[@"status"] integerValue];
    [btn setTitle:status==1?@"挂失":@"已挂失" forState:normal];
    btn.userInteractionEnabled=status==1?YES:NO;
    
    name.text=[NSString stringWithFormat:@"卡号:%@",dic[@"cardno2"]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)CellDelteAction:(UIButton*)btn{
    
    if(IOS8_OR_LATER)
    {
        UITableViewCell * cell = (UITableViewCell *)btn.superview;
        NSIndexPath *indexPath = [tableView  indexPathForCell:cell];
        cellTag=indexPath.row;
    }
    else
    {
        UITableViewCell * cell = (UITableViewCell *)btn.superview.superview;
        NSIndexPath *indexPath = [tableView  indexPathForCell:cell];
        cellTag=indexPath.row;
        
    }
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否挂失此门禁卡" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSDictionary * dic=dataArray[cellTag];
        Api * api =[[Api alloc] init:self tag:@"deleteSubUser"];
        [api usercard_loss:dic[@"id"]];
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    [self hideHud];
    
    if([tag isEqualToString:@"usercard_list"]){
        
        [dataArray removeAllObjects];
        dataArray=response[@"data"];
        [tableView reloadData];
    }
    else{
        
        [self showHint:@"挂失成功"];
        [self getData];
    }
}

@end
