//
//  DiscountListViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/7/28.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "DiscountListViewController.h"

@interface DiscountListViewController ()

@end

@implementation DiscountListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"抵用卷"];
    dataArray=[[NSMutableArray alloc] init];
    
    if([LSFEasy isEmpty:_price]){
       
        [self showHudInView:self.view hint:@"加载中"];
        Api * api =[[Api alloc] init:self tag:@"app_offset_list"];
        [api app_offset_list];
    }else{
        
      
        for(NSDictionary * dic in _array1){
            
            DHModel * dh =[[DHModel alloc] init];
            dh.fullprice=dic[@"fullprice"];
            dh.subprice=dic[@"subprice"];
            dh.begintime=dic[@"begintime"];
            dh.endtime=dic[@"endtime"];
            dh.type=dic[@"type"];
            dh.voucherId=@"";
            dh.vouchercellId=dic[@"id"];
            if(_price.floatValue<dh.fullprice.floatValue){
                
                dh.tag=0;
            }else{
                
                dh.tag=1;
            }
            
            [dataArray addObject:dh];
            
        }
        for(NSDictionary * dic in _array2){
            
            DHModel * dh =[[DHModel alloc] init];
            dh.fullprice=dic[@"fullprice"];
            dh.subprice=dic[@"subprice"];
            dh.begintime=dic[@"begintime"];
            dh.endtime=dic[@"endtime"];
            dh.type=dic[@"type"];
            dh.voucherId=dic[@"id"];
            dh.vouchercellId=@"";
            
            if(_price.floatValue<dh.fullprice.floatValue){
                
                dh.tag=0;

                
            }else{
                
                dh.tag=1;

            }
            [dataArray addObject:dh];
            
        }
    }
    
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];

    
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
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(20,70, img.frame.size.width-30, 20) View:cell Alignment:0 Color:gray Tag:2];
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(20,90, img.frame.size.width-30, 20) View:cell Alignment:0 Color:gray Tag:3];
        
        
    }
    
    UIImageView * img=(UIImageView *)[cell viewWithTag:11];
    UILabel * name =(UILabel *)[cell viewWithTag:1];
    UILabel * expired =(UILabel *)[cell viewWithTag:2];
    UILabel * requires =(UILabel *)[cell viewWithTag:3];
    
    
    DHModel * dh=dataArray[indexPath.row];

    img.image=[UIImage imageNamed:dh.tag==1?@"lsf67":@"lsf70"];
    
    name.text=[NSString stringWithFormat:@"满%@减%@    %@",dh.fullprice,dh.subprice,dh.type];
    
    [expired setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" 使用时间:自%@起至%@",[self getTime:dh.begintime],[self getTime:dh.endtime]] color:gray image:@"lsf68" type:1 rect:CGRectMake(0,-5,20,20)]];
    
    [requires setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" 使用门槛:%@",dh.type] color:gray image:@"lsf69" type:1 rect:CGRectMake(0,-5,20,20)]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(![LSFEasy isEmpty:_price]){
        
        self.completeBlockModel(dataArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    
    }

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
    NSArray*redeemcells =response[@"data"][@"redeemcells"];
    NSArray * voucherCustoms =response[@"data"][@"voucherCustoms"];
    
    for(NSDictionary * dic in redeemcells){
        
        DHModel * dh =[[DHModel alloc] init];
        dh.fullprice=dic[@"fullprice"];
        dh.subprice=dic[@"subprice"];
        dh.begintime=dic[@"begintime"];
        dh.endtime=dic[@"endtime"];
        dh.type=dic[@"type"];
        dh.voucherId=@"";
        dh.vouchercellId=dic[@"id"];
      
            
        dh.tag=1;
        
        
        [dataArray addObject:dh];
        
    }
    for(NSDictionary * dic in voucherCustoms){
        
        DHModel * dh =[[DHModel alloc] init];
        dh.fullprice=dic[@"fullprice"];
        dh.subprice=dic[@"subprice"];
        dh.begintime=dic[@"begintime"];
        dh.endtime=dic[@"endtime"];
        dh.type=dic[@"type"];
        dh.voucherId=dic[@"id"];
        dh.vouchercellId=@"";
        dh.tag=1;
        [dataArray addObject:dh];
        
    }
    
    if(dataArray.count==0){
        
        emptyView=[LSFUtil addEmptyView:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) view:self.view title:@""];
    }
    

    [tableview reloadData];
 
}

-(NSString *)getTime:(NSString*)time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time integerValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

@end
