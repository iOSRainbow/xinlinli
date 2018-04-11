//
//  BusLockViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "BusLockViewController.h"
#import "AddLockViewController.h"

@interface BusLockViewController ()

@end

@implementation BusLockViewController
-(void)actNavRightBtn{

    AddLockViewController * add =[[AddLockViewController alloc] init];
    add.completeBlockNSDictionary=^(NSDictionary*dic){
    
        [self getData];
    };
    [self.navigationController pushViewController:add animated:YES];
 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"车位锁"];
    
    [self addNavRightBtnWithTitle:@"添加车位锁" rect:CGRectMake(SCREEN_WIDTH-100,StatusHeight+2,90,40)];
    dataArray=[[NSMutableArray alloc] init];
    tableview =[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH,ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
    
    [self getData];
    
}


-(void)getData{

    NSArray *array=[myUserDefaults objectForKey:@"data_bus"];
    
    if (array.count!=0) {
        dataArray=[array mutableCopy];
    }
    
    if(dataArray.count!=0){
        
        
        [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            if(![obj[@"phone"] isEqual:UserName]){
                
                [dataArray removeAllObjects];
                
                [myUserDefaults setObject: dataArray forKey:@"data_bus"];
                
                [myUserDefaults synchronize];
                
                *stop=YES;
            }
            
        }];
        
        
        
        
    }
 
    [tableview reloadData];

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
        
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(15, 0, SCREEN_WIDTH-20, 50) View:cell Alignment:0 Color:black Tag:1];
        
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 49, SCREEN_WIDTH, 1) view:cell];
        
    }
    
    UILabel * lb1 =(UILabel *)[cell viewWithTag:1];
    
    NSDictionary * dic=dataArray[indexPath.row];
    
    lb1.text=dic[@"name"];
  
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic=dataArray[indexPath.row];
    self.completeBlockNSDictionary(dic);
    [self.navigationController popViewControllerAnimated:YES];

}


@end
