//
//  ReplactBatteryViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/9/5.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "ReplactBatteryViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "MyPoorViewController.h"
@interface ReplactBatteryViewController ()

@end

@implementation ReplactBatteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"更换电池"];
    
    rent=@"";
    installation=@"";
    deposit=@"";
    
    [self createBatteryView];
    [self createPayView];
    [self createBottomView];
    
    [self getData];
}

-(void)createBatteryView{
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight+7, SCREEN_WIDTH, 45) view:self.view backgroundColor:white];
    
    labBatteryPrice=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 0, SCREEN_WIDTH-15, 45) View:view Alignment:0 Color:gray Tag:1];
    
}

-(void)createPayView{
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight+52, SCREEN_WIDTH, 130) view:self.view backgroundColor:white];
    
    [LSFUtil labelName:@"请选择支付方式" fontSize:font14 rect:CGRectMake(10, 0, 300, 40) View:view Alignment:0 Color:black Tag:2];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(10, 39, SCREEN_WIDTH-10, 1) view:view];
    
    [LSFUtil addSubviewImage:@"lsf83" rect:CGRectMake(10,50,30,30) View:view Tag:1];
    
    [LSFUtil labelName:@"支付宝" fontSize:font14 rect:CGRectMake(50,40, 100, 50) View:view Alignment:0 Color:black Tag:1];
    
    [LSFUtil addSubviewImage:@"圈orange" rect:CGRectMake(SCREEN_WIDTH-30,55,20,20) View:view Tag:1];
    
    btnDiscount=[LSFUtil buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(10, 100, SCREEN_WIDTH-20, 30) title:nil Tag:1 View:view textColor:black Size:font14];
    [btnDiscount addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [btnDiscount setAttributedTitle:[LSFEasy ButtonAttriSring:@" 电瓶低第一年租金" color:black image:@"圈gray" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];
    
}

-(void)createBottomView{
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, BottomHeight, SCREEN_WIDTH, 50) view:self.view backgroundColor:white];
    
    labCountPrice=[LSFUtil labelName:nil fontSize:font15 rect:CGRectMake(10, 0, SCREEN_WIDTH-110, 50) View:view Alignment:0 Color:Red Tag:1];
    
    UIButton * commit =[LSFUtil buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-100, 0, 100, 50) title:@"提交" Tag:1 View:view textColor:white Size:font15];
    commit.backgroundColor=Red;
    [commit addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)action{
    
    
    if(!btnDiscount.selected){
        
      countPrice=deposit.integerValue+installation.integerValue;

        btnDiscount.selected=YES;
        [btnDiscount setAttributedTitle:[LSFEasy ButtonAttriSring:@" 电瓶低第一年租金" color:black image:@"圈orange" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];

    }else{
        
      countPrice=deposit.integerValue+rent.integerValue+installation.integerValue;

        btnDiscount.selected=NO;
        [btnDiscount setAttributedTitle:[LSFEasy ButtonAttriSring:@" 电瓶低第一年租金" color:black image:@"圈gray" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];
    }
    
    
    labCountPrice.text=[NSString stringWithFormat:@"总计：￥%zi",countPrice];
    
}

-(void)commit{
    
    if(countPrice==0){
        
        [self showHint:@"您无需在补交费用"];
        return;
    }
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api  =[[Api alloc] init:self tag:@"zfb_pay"];
    [api zfb_pay:[NSString stringWithFormat:@"%zi",countPrice] type:@"更换电池补交费用"];
    
    
}

-(void)getData{
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"battery_scan"];
    [api battery_scan:_number year:_year];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)Failed:(NSString*)message tag:(NSString*)tag{
    
    [self hideHud];
    [self showHint:message];
}

-(void)Sucess:(id)response tag:(NSString*)tag{
    
    [self hideHud];
    if([tag isEqualToString:@"battery_scan"]){
        
        NSDictionary * dic =response[@"data"];
        deposit=dic[@"deposit"];
        rent=dic[@"rent"];
        installation=dic[@"installation"];
        labBatteryPrice.text=[NSString stringWithFormat:@"押金：%@ 租金：%@，安装费：%@",deposit,rent,installation];
        
    countPrice=deposit.integerValue+rent.integerValue+installation.integerValue;
        
        labCountPrice.text=[NSString stringWithFormat:@"总计：￥%zi",countPrice];
        
    }
    else if ([tag isEqualToString:@"zfb_pay"]){
        
        [self alipay:response[@"data"]];
        [self initialPayObserver];
    }
    else if ([tag isEqualToString:@"battery_exchange"]){
        
        [self showHint:response[@"msg"]];
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MyPoorViewController class]]) {
                MyPoorViewController *A =(MyPoorViewController *)controller;
                [self.navigationController popToViewController:A animated:YES];
            }
        }
      
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
    Api * api =[[Api alloc] init:self tag:@"battery_exchange"];
    [api battery_exchange:_number year:_year];
    
}
-(void)paymentFalse{
    
    [self showHint:@"取消支付"];
}


@end
