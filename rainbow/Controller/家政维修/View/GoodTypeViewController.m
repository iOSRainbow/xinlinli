//
//  GoodTypeViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/2/26.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "GoodTypeViewController.h"

@interface GoodTypeViewController ()

@end

@implementation GoodTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"请选择商品类型"];
    dataArray=[[NSMutableArray alloc] init];
    
    [self addNavRightBtnWithTitle:@"完成" color:orange rect:CGRectMake(SCREEN_WIDTH-60, StatusHeight, 60, 44)];
    
    for(NSInteger i=0;i<_array.count;i++){
        
        NSDictionary * dic =_array[i];
        SeletedGoodsModel * model = [[SeletedGoodsModel alloc] init];
        model.goodName=dic[@"name"];
        model.goodNum=@"0";
        model.goodId=dic[@"id"];
        model.lowprice=dic[@"lowprice"];
        [dataArray addObject:model];
    }
    
    tableview =[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view delegate:self dataSource:self];
    
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
    
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    SeletedGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    
    if (cell == nil) {
        
        cell = [[SeletedGoodsCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    
    
    SeletedGoodsModel * model =dataArray[indexPath.row];
    
    cell.model=model;
    
    [cell.addBtn addTarget:self action:@selector(addGoodsNum:) forControlEvents:UIControlEventTouchUpInside];
    cell.addBtn.tag=indexPath.row;
    
    [cell.removeBtn addTarget:self action:@selector(removeGoodsNum:) forControlEvents:UIControlEventTouchUpInside];
    cell.removeBtn.tag=indexPath.row;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)addGoodsNum:(UIButton*)btn{
    
    SeletedGoodsModel * model =dataArray[btn.tag];
    model.goodNum=[NSString stringWithFormat:@"%zi",model.goodNum.integerValue+1];
    [dataArray replaceObjectAtIndex:btn.tag withObject:model];
    TABLERELOAD(tableview, btn.tag, 0);
    
}

-(void)removeGoodsNum:(UIButton*)btn{
    
    SeletedGoodsModel * model =dataArray[btn.tag];
    model.goodNum=[NSString stringWithFormat:@"%zi",model.goodNum.integerValue-1];
    [dataArray replaceObjectAtIndex:btn.tag withObject:model];
    TABLERELOAD(tableview, btn.tag, 0);
}

-(void)actNavRightBtn{
    
    NSMutableArray * array =[[NSMutableArray alloc] init];
    
    for(SeletedGoodsModel * model in dataArray){
        
        if(model.goodNum.integerValue!=0){
            
            [array addObject:model];
        }
    }
    
    if(array.count==0){
        
        [self showHint:@"请选择商品购买数量"];
        return;
    }
    if(array.count>1){
        
        [self showHint:@"一次只能购买一种类型的商品"];
        return;
    }
    
    self.completeBlock(array[0]);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
