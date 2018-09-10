//
//  PayRentViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/9/4.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "PayRentViewController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface PayRentViewController ()

@end

@implementation PayRentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"缴纳租金"];
    
    scr=[LSFUtil add_scollview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view co:CGSizeMake(0, ViewHeight)];
    
    [self createRentInfoView];
    
    [self createPayView];
    
    UIButton * commit =[LSFUtil buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(20, 245, SCREEN_WIDTH-40, 35) title:@"提交" Tag:1 View:scr textColor:white Size:font15];
    commit.backgroundColor=Red;
    commit.layer.cornerRadius=6;
    commit.layer.masksToBounds=YES;
    [commit addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
}

-(void)createRentInfoView{
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, 7, SCREEN_WIDTH, 115) view:scr backgroundColor:white];
    
    [LSFUtil labelName:[NSString stringWithFormat:@"电瓶类型：%@",_dict[@"parameter"]] fontSize:font14 rect:CGRectMake(10, 10, SCREEN_WIDTH-15, 20) View:view Alignment:0 Color:black Tag:1];
    
    [LSFUtil labelName:[NSString stringWithFormat:@"租金：￥%@",_dict[@"rent"]] fontSize:font14 rect:CGRectMake(10, 35, SCREEN_WIDTH-15, 20) View:view Alignment:0 Color:black Tag:1];
    
    [LSFUtil labelName:[NSString stringWithFormat:@"租期：%@年",_dict[@"year"]] fontSize:font14 rect:CGRectMake(10, 60, SCREEN_WIDTH-15, 20) View:view Alignment:0 Color:black Tag:1];

    
    [LSFUtil labelName:[NSString stringWithFormat:@"需支付：￥%zi",[_dict[@"year"] integerValue]*[_dict[@"rent"] integerValue]] fontSize:font14 rect:CGRectMake(10, 85, SCREEN_WIDTH-15, 20) View:view Alignment:0 Color:black Tag:1];

}

-(void)createPayView{
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, 131, SCREEN_WIDTH, 90) view:scr backgroundColor:white];
    
    [LSFUtil labelName:@"请选择支付方式" fontSize:font14 rect:CGRectMake(10, 0, 300, 40) View:view Alignment:0 Color:black Tag:2];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(10, 39, SCREEN_WIDTH-10, 1) view:view];
    
    [LSFUtil addSubviewImage:@"lsf83" rect:CGRectMake(10,50,30,30) View:view Tag:1];
    
    [LSFUtil labelName:@"支付宝" fontSize:font14 rect:CGRectMake(50,40, 100, 50) View:view Alignment:0 Color:black Tag:1];
    
    [LSFUtil addSubviewImage:@"圈orange" rect:CGRectMake(SCREEN_WIDTH-30,55,20,20) View:view Tag:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commit{
    
    NSString * price=[NSString stringWithFormat:@"%zi",[_dict[@"year"] integerValue]*[_dict[@"rent"] integerValue]];
    [self showHudInView:self.view hint:@"加载中"];
    Api * api  =[[Api alloc] init:self tag:@"zfb_pay"];
    [api zfb_pay:price type:@"电瓶租金"];
}

-(void)Failed:(NSString*)message tag:(NSString*)tag{
    
    [self hideHud];
    [self showHint:message];
}

-(void)Sucess:(id)response tag:(NSString*)tag{
    
    [self hideHud];
    if ([tag isEqualToString:@"zfb_pay"]){
        
        [self alipay:response[@"data"]];
        [self initialPayObserver];
    }
    else if ([tag isEqualToString:@"battery_addRent"]){
        
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
    Api * api =[[Api alloc] init:self tag:@"battery_addRent"];
    [api battery_addRent:_dict[@"year"]];
    
}
-(void)paymentFalse{
    
    [self showHint:@"取消支付"];
}


@end
