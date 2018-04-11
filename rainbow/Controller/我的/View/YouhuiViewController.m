//
//  YouhuiViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "YouhuiViewController.h"
#import "GuoQiViewController.h"
#import "GetUserAddressViewController.h"
@interface YouhuiViewController ()

@end

@implementation YouhuiViewController


-(void)actNavRightBtn{
  
    GuoQiViewController * g =[[GuoQiViewController alloc] init];
    
    g.fromView=_fromView;
    
    __weak typeof(self) weakSelf=self;
    g.completeBlockNone=^{
    
        Api * api =[[Api alloc] init:weakSelf tag:@"couponList"];
        
        [api couponList:_fromView];
    };
    [self.navigationController pushViewController:g animated:YES];

}
-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
 

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:_fromView];
    [self addNavRightBtnWithTitle:@"已使用"];
    dataArray=[[NSMutableArray alloc] init];
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
    [self getData];
}

-(void)getData{

    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"couponList"];
    
    [api couponList:_fromView];
    
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
        
        UIImageView *img=[LSFUtil addSubviewImage:@"lsf67" rect:CGRectMake(10, 10, SCREEN_WIDTH-20,80) View:cell Tag:11];
        
        [LSFUtil labelName:nil fontSize:font18 rect:CGRectMake(20,10, img.frame.size.width-70,50) View:cell Alignment:0 Color:white Tag:1];
        
        [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(img.frame.size.width-100,10, 100, 50) title:@"点击使用" select:@selector(CellAction:) Tag:12345 View:cell textColor:white Size:font16 background:nil];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(20,70, img.frame.size.width-30, 20) View:cell Alignment:0 Color:gray Tag:2];
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(20,90, img.frame.size.width-30, 20) View:cell Alignment:0 Color:gray Tag:3];
        
        
        
    }
    
    UILabel * name =(UILabel *)[cell viewWithTag:1];
    UILabel * expired =(UILabel *)[cell viewWithTag:2];
    UILabel * requires =(UILabel *)[cell viewWithTag:3];
    
    
    NSDictionary * dic=dataArray[indexPath.row];
    name.text=dic[@"name"];
    
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-dd"];
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dic[@"expired"] integerValue]/1000];
//    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    [expired setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" 使用时间:即日起至%@",@"~"] color:gray image:@"lsf68" type:1 rect:CGRectMake(0,-5,20,20)]];
    
    
    
    [requires setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" 使用门槛:%@", dic[@"content"]] color:gray image:@"lsf69" type:1 rect:CGRectMake(0,-5,20,20)]];
    
    
  /*
   data{id优惠券id，name优惠券名，expired到期时间，
   downtime使用时间，requires使用门槛，state “1”代表已使用}
   */
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)CellAction:(UIButton*)btn{

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
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否确认使用此优惠卷" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        GetUserAddressViewController * get =[[GetUserAddressViewController alloc] init];
        
        get.completeBlockNSDictionary=^(NSDictionary*dic){
        
            [self showHudInView:self.view hint:@"加载中"];
            Api * api =[[Api alloc] init:self tag:@"coupon_insert"];
            [api coupon_insert:dic[@"id"] couponId:dataArray[cellTag][@"id"] fromView:_fromView];
        
        };
        
        [self.navigationController pushViewController:get animated:YES];
        
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
    


}
-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    if([tag isEqualToString:@"couponList"]){

        [emptyView removeFromSuperview];

        emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:message];

    }
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    
    if([tag isEqualToString:@"couponList"]){
    [dataArray removeAllObjects];
        [emptyView removeFromSuperview];

    dataArray=response[@"data"];
        if(dataArray.count==0){
            
            emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:@""];
            return;
        }
    [tableview reloadData];
    }
    else{
       
        [self actNavRightBtn];
    }
}


@end
