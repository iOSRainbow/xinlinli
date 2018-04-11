//
//  Mine_SexViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "Mine_SexViewController.h"

@interface Mine_SexViewController ()

@end

@implementation Mine_SexViewController


-(void)actNavRightBtn{
 
    
    NSString * str =dataArray[sex];
    
    if([str isEqual:_SexStr]){
    
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
    
        [self showHudInView:self.view hint:@"加载中"];
        Api * api =[[Api alloc] init:self tag:@"changeGender"];
        [api changeGender:[NSString stringWithFormat:@"%zi",sex]];
    
    }
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"性别"];
    [self addNavRightBtnWithTitle:@"保存"];

    dataArray=[[NSMutableArray alloc] initWithObjects:@"女",@"男", nil];
    gouArray=[[NSMutableArray alloc] init];
    
    if([_SexStr isEqualToString:@"男"]){
    
        [gouArray addObject:@"0"];
        [gouArray addObject:@"1"];
        sex=1;
    }
    else{
    
        [gouArray addObject:@"1"];
        [gouArray addObject:@"0"];
        sex=0;
    }

    tableview=[LSFUtil add_tableview:CGRectMake(0,NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
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
        
        
        [LSFUtil addSubviewImage:nil rect:CGRectMake(SCREEN_WIDTH-40, 15, 20, 20) View:cell Tag:1];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(20, 0, SCREEN_WIDTH-50, 50) View:cell Alignment:0 Color:black Tag:2];
        
        UILabel*line=[LSFUtil setXianTiao:ColorHUI rect:CGRectMake(20, 49, SCREEN_WIDTH, 1) view:cell];
        line.tag=3;
        
    }
    
    
    UIImageView * img =(UIImageView*)[cell viewWithTag:1];
    UILabel * lable =(UILabel*)[cell viewWithTag:2];
    UILabel *line =(UILabel*)[cell viewWithTag:3];
    
    NSInteger a = [gouArray[indexPath.row] integerValue];
    
    img.image=[UIImage imageNamed:a==0?@"":@"lsf28"];
    
    lable.text=dataArray[indexPath.row];
    line.hidden=(indexPath.row==1)?YES:NO;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    gouArray=[[NSMutableArray alloc] initWithObjects:@"0",@"0", nil];
    
    [gouArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
    
    sex=indexPath.row;
    
    [tableView reloadData];
    
}

-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    
    [self showHint:response[@"msg"]];
    
    self.completeBlockNSString([response[@"data"][@"gender"] integerValue]==1?@"男":@"女");
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
