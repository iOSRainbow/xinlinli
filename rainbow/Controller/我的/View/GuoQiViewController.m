//
//  GuoQiViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "GuoQiViewController.h"

@interface GuoQiViewController ()

@end

@implementation GuoQiViewController


-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    self.completeBlockNone();

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setNavTitle:@"已使用"];
    dataArray=[[NSMutableArray alloc] init];
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
    [self showHudInView:self.view hint:@"加载中"];
    
    Api * api =[[Api alloc] init:self tag:@"couporderList"];
    
    [api couporderList:_fromView];

    
    
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
        
        UIImageView *img=[LSFUtil addSubviewImage:@"lsf70" rect:CGRectMake(10, 5, SCREEN_WIDTH-20,80) View:cell Tag:111];
        
        [LSFUtil labelName:nil fontSize:font18 rect:CGRectMake(20,10, img.frame.size.width-70,50) View:cell Alignment:0 Color:white Tag:1];
        
        [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(img.frame.size.width-100, 10, 100, 50) title:nil select:nil Tag:4 View:cell textColor:white Size:font16 background:nil];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(20,70, img.frame.size.width-20, 25) View:cell Alignment:0 Color:gray Tag:2];
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(20,90, img.frame.size.width-20, 25) View:cell Alignment:0 Color:gray Tag:3];
        
    }
    
    UILabel * name =(UILabel *)[cell viewWithTag:1];
    UILabel * expired =(UILabel *)[cell viewWithTag:2];
    UILabel * requires =(UILabel *)[cell viewWithTag:3];
    UIButton * btn=(UIButton*)[cell viewWithTag:4];
    
    NSDictionary * dic=dataArray[indexPath.row];
    name.text=dic[@"coupname"];
    
    
    NSString * state =[LSFEasy isEmpty:dic[@"state"]]?@"0":dic[@"state"];
    
    [btn setTitle:[state integerValue]==0?@"已过期":@"已使用" forState:normal];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970: [dic[@"newTime"] integerValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    [expired setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@"使用时间: %@",confromTimespStr] color:gray image:@"lsf68" type:1 rect:CGRectMake(0,-5,20,20)]];
    
    [requires setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" 使用门槛:%@",@"无"] color:gray image:@"lsf69" type:1 rect:CGRectMake(0,-5,20,20)]];
    
    
    /*
     data{id优惠券id，name优惠券名，expired到期时间，
     downtime使用时间，requires使用门槛，state “1”代表已使用}
     */
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
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

    if([tag isEqualToString:@"couporderList"]){
        
        if(![response[@"data"] isKindOfClass:[NSString class]]){
        
            [dataArray removeAllObjects];
            dataArray=response[@"data"];
            if(dataArray.count==0){
                
                emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:@""];
                return;
            }
            [tableview reloadData];
        }
        
      
    }
  
}



@end
