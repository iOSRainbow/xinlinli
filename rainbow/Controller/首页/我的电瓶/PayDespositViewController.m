//
//  PayDespositViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/9/4.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "PayDespositViewController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface PayDespositViewController ()

@end

@implementation PayDespositViewController

-(void)actNavRightBtn{
    
    
    __weak typeof(self)weakSelf=self;
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"退押金" message:@"退押金因在工作人员在场时，归还电池后，方可当场退押金，否则后果自负，您确定继续该操作吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf getReturnDesposit];
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)getReturnDesposit{
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"battery_returnDeposit"];
    [api battery_returnDeposit];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"缴纳押金"];
    dataArray=[[NSMutableArray alloc] init];
    gouArray=[[NSMutableArray alloc] init];
    cellTag=-1;
    
    [self addNavRightBtnWithTitle:@"退押金"];
    
    tableview=[LSFUtil add_tableview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight-50) Tag:1 View:self.view delegate:self dataSource:self];
    tableview.tableFooterView=[self tableViewfootView];
    
    [self createBottomView];
    
    [self getData];
}

-(UIView*)tableViewfootView{
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, 90) view:nil backgroundColor:white];
    
    [LSFUtil labelName:@"请选择支付方式" fontSize:font14 rect:CGRectMake(10, 0, 300, 40) View:view Alignment:0 Color:black Tag:2];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(10, 39, SCREEN_WIDTH-10, 1) view:view];
    
    [LSFUtil addSubviewImage:@"lsf83" rect:CGRectMake(10,50,30,30) View:view Tag:1];
    
    [LSFUtil labelName:@"支付宝" fontSize:font14 rect:CGRectMake(50,40, 100, 50) View:view Alignment:0 Color:black Tag:1];
    
    [LSFUtil addSubviewImage:@"圈orange" rect:CGRectMake(SCREEN_WIDTH-30,55,20,20) View:view Tag:1];
    
    return view;
    
}

-(void)createBottomView{
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, BottomHeight, SCREEN_WIDTH, 50) view:self.view backgroundColor:white];
    
    labPrice=[LSFUtil labelName:nil fontSize:font15 rect:CGRectMake(10, 0, SCREEN_WIDTH-110, 50) View:view Alignment:0 Color:Red Tag:1];
    
    UIButton * commit =[LSFUtil buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-100, 0, 100, 50) title:@"提交" Tag:1 View:view textColor:white Size:font15];
    commit.backgroundColor=Red;
    [commit addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)getData{
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"battery_getbatteryTypeList"];
    [api battery_getbatteryTypeList];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        [LSFUtil addSubviewImage:nil rect:CGRectMake(10, 15, 20, 20) View:cell Tag:1];
        
        [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(40, 0,SCREEN_WIDTH-45, 50) View:cell Alignment:0 Color:gray Tag:2];
        
        UILabel*line= [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(10, 49, SCREEN_WIDTH-10, 1) view:cell];
        line.tag=3;
    }
    
    UIImageView * imageView =(UIImageView*)[cell viewWithTag:1];
    UILabel * title =(UILabel*)[cell viewWithTag:2];
    UILabel * line =(UILabel*)[cell viewWithTag:3];
    
    NSDictionary * dic =dataArray[indexPath.row];
    NSInteger  isSeleted =[gouArray[indexPath.row] integerValue];
    
    imageView.image=[UIImage imageNamed:isSeleted==1?@"圈orange":@"圈gray"];
    title.text=[NSString stringWithFormat:@"%@  押金%@（可退）",dic[@"parameter"],dic[@"deposit"]];
    line.hidden=(dataArray.count-1==indexPath.row)?YES:NO;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    cellTag=indexPath.row;
    NSDictionary * dic=dataArray[indexPath.row];
    
    NSString * price = dic[@"deposit"];
    
    if(price.integerValue<=_deposit.integerValue){
        
        [self showHint:@"您当前不可选择此电瓶类型"];
        return;
    }
    
    
    [gouArray removeAllObjects];
    for (NSInteger i=0;i<dataArray.count;i++){
        
        [gouArray addObject:@"0"];
    }
    
    [gouArray replaceObjectAtIndex:cellTag withObject:@"1"];
    
    labPrice.text=[NSString stringWithFormat:@"押金：￥%zi",[dic[@"deposit"] integerValue]-_deposit.integerValue];
    
    [tableview reloadData];
}

-(void)commit{
    
    if(cellTag==-1){
        
        [self showHint:@"您还未选择押金类型"];
        return;
    }
    NSDictionary * dic =dataArray[cellTag];

    NSInteger count =[dic[@"deposit"] integerValue]-_deposit.integerValue;
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api  =[[Api alloc] init:self tag:@"zfb_pay"];
    [api zfb_pay:[NSString stringWithFormat:@"%zi",count] type:[NSString stringWithFormat:@"%@  押金%@（可退）",dic[@"parameter"],dic[@"deposit"]]];
    
}
-(void)Failed:(NSString*)message tag:(NSString*)tag{
    
    [self hideHud];
    [self showHint:message];
}

-(void)Sucess:(id)response tag:(NSString*)tag{
    
    [self hideHud];
    if([tag isEqualToString:@"battery_getbatteryTypeList"]){
        
        [dataArray removeAllObjects];
        [gouArray removeAllObjects];
        
        dataArray=response[@"data"];
        
        for (NSInteger i=0;i<dataArray.count;i++){
            
            [gouArray addObject:@"0"];
        }
        
        [tableview reloadData];
        
    }else if ([tag isEqualToString:@"zfb_pay"]){
        
        [self alipay:response[@"data"]];
        [self initialPayObserver];
    }
    else if ([tag isEqualToString:@"battery_addDeposit"]||[tag isEqualToString:@"battery_returnDeposit"]){
        
        [self showHint:response[@"msg"]];

        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)alipay:(NSString*)data
{
    NSString *appScheme = @"xinlinli";
    
    [[AlipaySDK defaultService] payOrder:data fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        //支付宝支付完成以后的工作
        NSNumber* resultStatus = [resultDic objectForKey:@"resultStatus"];
        
        if(resultStatus && [resultStatus intValue]==9000) {
            
            NSLog(@"wap端支付-支付成功");
            [self postNotification:@"payment.done"];
        }
        else
        {
            NSLog(@"wap端-支付失败");
            [self postNotification:@"payment.false"];
        }
    }];
}


#pragma mark - 通知的相关方法
-(void)postNotification:(NSString*)notificationName
{
    NSLog(@"notification:%@", notificationName);
    NSNotificationCenter * notifyCenter = [NSNotificationCenter defaultCenter];
    NSNotification *nnf = [NSNotification notificationWithName:notificationName object:nil];
    [notifyCenter postNotification:nnf];
}
//支付前添加 观察者
- (void)initialPayObserver
{
    NSLog(@"initialPayObserver");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paymentDone) name:@"payment.done" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paymentFalse) name:@"payment.false" object:nil];
}
-(void)paymentDone{
    
    [self showHudInView:self.view hint:@"加载中"];
    
    NSDictionary * dic =dataArray[cellTag];
    
    Api * api =[[Api alloc] init:self tag:@"battery_addDeposit"];
    [api battery_addDeposit:dic[@"deposit"]];

}
-(void)paymentFalse{
    
    [self showHint:@"取消支付"];
}


@end
