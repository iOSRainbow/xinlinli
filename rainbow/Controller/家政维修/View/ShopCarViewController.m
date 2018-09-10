//
//  ShopCarViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/8/13.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "ShopCarViewController.h"

@interface ShopCarViewController ()

@end

@implementation ShopCarViewController

-(void)actNavRightBtn{
    
    if(!navRightBtn.selected){
        
        [navRightBtn setTitle:@"完成" forState:normal];
        navRightBtn.selected=YES;
        [self addComplteView];
    
    }else{
        
        [navRightBtn setTitle:@"管理" forState:normal];
        navRightBtn.selected=NO;
        [self addBottomView];
        [self getCountMoney];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"购物车"];
    [self addNavRightBtnWithTitle:@"管理" color:orange rect:CGRectMake(SCREEN_WIDTH-60, StatusHeight, 60, 44)];
 
    dataArray=[[NSMutableArray alloc] init];
    
    tableview =[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight-50) Tag:1 View:self.view delegate:self dataSource:self];
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"shoppingcar_carList"];
    [api shoppingcar_carList];
    
    
    [self addBottomView];

}

-(void)addBottomView{
    
    [bottomView removeFromSuperview];
    [complteView removeFromSuperview];

    bottomView=[LSFUtil viewWithRect:CGRectMake(0, BottomHeight, SCREEN_WIDTH, 50) view:self.view backgroundColor:white];
    
    priceLb=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 0, SCREEN_WIDTH-140, 50) View:bottomView Alignment:0 Color:Red Tag:1];
    
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-120, 0, 120, 50) title:@"去结算" select:@selector(bottomAction:) Tag:1 View:bottomView textColor:white Size:font15 background:Red];
}


-(void)addComplteView{
    
    [complteView removeFromSuperview];
    [bottomView removeFromSuperview];
    complteView=[LSFUtil viewWithRect:CGRectMake(0, BottomHeight, SCREEN_WIDTH, 50) view:self.view backgroundColor:white];
    
    
    NSInteger sum=0;
    for (ShopCarModel*model in dataArray) {
        
        sum+=model.isSeleted;
    }
   
    
    allBtn= [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(20,15,60, 20) title:nil select:@selector(bottomAction:) Tag:3 View:complteView textColor:nil Size:nil background:nil];
    
    if(sum==dataArray.count){
        
        allBtn.selected=YES;
    }
    else{
        
        allBtn.selected=NO;
    }
    
    [allBtn setAttributedTitle:[LSFEasy ButtonAttriSring:@" 全选" color:black image: allBtn.selected?@"圈orange":@"圈gray" type:1 rect:CGRectMake(0,-3, 20, 20)] forState:normal];
    
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-120, 0, 120, 50) title:@"删除" select:@selector(bottomAction:) Tag:2 View:complteView textColor:white Size:font15 background:Red];
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
    
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    ShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    
    if (cell == nil) {
        
        cell = [[ShopCarCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    
    
    ShopCarModel * model =dataArray[indexPath.row];
    
    cell.model=model;
    
    cell.line.hidden=(dataArray.count-1==indexPath.row)?YES:NO;
    
    [cell.addBtn addTarget:self action:@selector(addGoodsNum:) forControlEvents:UIControlEventTouchUpInside];
    cell.addBtn.tag=indexPath.row;
    
    [cell.removeBtn addTarget:self action:@selector(removeGoodsNum:) forControlEvents:UIControlEventTouchUpInside];
    cell.removeBtn.tag=indexPath.row;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCarModel * model =dataArray[indexPath.row];
    model.isSeleted=model.isSeleted?NO:YES;
    [dataArray replaceObjectAtIndex:indexPath.row withObject:model];
    TABLERELOAD(tableview, indexPath.row, 0);
    
    
    NSInteger sum=0;
    for (ShopCarModel*model in dataArray) {
        
        sum+=model.isSeleted;
    }
    
    if(sum==dataArray.count){
        
        allBtn.selected=YES;
    }
    else{
        
        allBtn.selected=NO;
    }
    
    [allBtn setAttributedTitle:[LSFEasy ButtonAttriSring:@" 全选" color:black image: allBtn.selected?@"圈orange":@"圈gray" type:1 rect:CGRectMake(0,-3, 20, 20)] forState:normal];
    
    
    [self getCountMoney];
}


-(void)addGoodsNum:(UIButton*)btn{
  
    cellTag=btn.tag;
    ShopCarModel * model=dataArray[cellTag];
    model.shopNum=[NSString stringWithFormat:@"%zi",model.shopNum.integerValue+1];
    [self potGoodNumData:model.shopId count:model.shopNum.integerValue];
    [dataArray replaceObjectAtIndex:cellTag withObject:model];
    TABLERELOAD(tableview, btn.tag, 0);
    
    [self getCountMoney];

}

-(void)removeGoodsNum:(UIButton*)btn{
 
    cellTag=btn.tag;
    ShopCarModel * model=dataArray[cellTag];
    model.shopNum=[NSString stringWithFormat:@"%zi",model.shopNum.integerValue-1];
    [self potGoodNumData:model.shopId count:model.shopNum.integerValue];
    [dataArray replaceObjectAtIndex:cellTag withObject:model];
    TABLERELOAD(tableview, btn.tag, 0);
    
    [self getCountMoney];
}

-(void)potGoodNumData:(NSString*)goodId count:(NSInteger)count{
    
    Api * api =[[Api alloc] init:self tag:@""];
    [api shoppingcar_updateCar:goodId message:@"" count:count];
}

-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    
    if([tag isEqualToString:@"shoppingcar_carList"]){
    
        [dataArray removeAllObjects];
        
        NSArray * ary =response[@"data"];
        
        for(NSInteger i=0;i<ary.count;i++){
            
            NSDictionary * dic =ary[i];
        
            ShopCarModel * model =[[ShopCarModel alloc] initWithSubDict:dic];
            
            [dataArray addObject:model];
        }
        
        [tableview reloadData];
    }
    else if ([tag isEqualToString:@"shoppingcar_deleteCar"]){
        
        [self showHint:response[@"msg"]];
        priceLb.text=@"";
        Api * api =[[Api alloc] init:self tag:@"shoppingcar_carList"];
        [api shoppingcar_carList];
    }
}


-(void)getCountMoney{
    
    double count =0.0;
    
    for(ShopCarModel * model in dataArray){
        
        if(model.shopNum.integerValue!=0&&model.isSeleted){
            
            count+=(model.shopPrice.doubleValue*model.shopNum.integerValue);
        }
    }
    
    priceLb.text=count==0?@"":[NSString stringWithFormat:@"合计：￥%.2f",count];
}

-(void)bottomAction:(UIButton*)btn{
    
    //去结算
    if(btn.tag==1){
        
        
       
        
    }
    //删除
    else if (btn.tag==2){
        
        
        NSMutableArray * array =[[NSMutableArray alloc] init];
        
        for(ShopCarModel * model in dataArray){
            
            if(model.isSeleted){
                
                [array addObject:model.shopId];
            }
        }
        
        if(array.count==0){
            
            return;
        }
        
        [self showHudInView:self.view hint:@"加载中"];
        Api * api =[[Api alloc] init:self tag:@"shoppingcar_deleteCar"];
        [api shoppingcar_deleteCar:[array componentsJoinedByString:@","]];
        
        
    }
    //全选
    else{
        
        //全选状态
        if(allBtn.selected){
            
            for(NSInteger i=0;i<dataArray.count;i++){
                
                ShopCarModel * model =dataArray[i];
                model.isSeleted=NO;
                [dataArray replaceObjectAtIndex:i withObject:model];
            }
            
            [tableview reloadData];
            allBtn.selected=NO;

        }
        else{
            
            
            for(NSInteger i=0;i<dataArray.count;i++){
                
                ShopCarModel * model =dataArray[i];
                model.isSeleted=YES;
                [dataArray replaceObjectAtIndex:i withObject:model];
            }
            
            [tableview reloadData];
            allBtn.selected=YES;

        }
        
        [allBtn setAttributedTitle:[LSFEasy ButtonAttriSring:@" 全选" color:black image: allBtn.selected?@"圈orange":@"圈gray" type:1 rect:CGRectMake(0,-3, 20, 20)] forState:normal];

    }
    
}
@end
