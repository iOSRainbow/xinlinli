//
//  VipPayViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/6/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "VipPayViewController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface VipPayViewController ()

@end

@implementation VipPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"充值"];
    
    dataArray=[[NSMutableArray alloc] initWithObjects:@"100",@"200",@"300",@"500", nil];
    gouArray=[[NSMutableArray alloc] initWithObjects:@"1",@"0",@"0",@"0", nil];
    
    [self mainviewClass];
    
}

-(void)mainviewClass{

    UIView * view =[LSFUtil viewWithRect:CGRectMake(0,NavigationHeight,SCREEN_WIDTH, 100) view:self.view backgroundColor:white];
    
    [LSFUtil addSubviewImage:@"lsf88" rect:CGRectMake(SCREEN_WIDTH-30, 15, 20, 20) View:view Tag:1];
    
    text=[LSFUtil addTextFieldView:CGRectMake(10, 0, SCREEN_WIDTH-50, 50) Tag:1 textColor:gray Alignment:0 Text:UserName placeholderStr:@"请输入充值账号" View:view font:font16];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(10, 50, SCREEN_WIDTH, 1) view:view];
    
    
    [LSFUtil labelName:@"充值金额" fontSize:font16 rect:CGRectMake(10,60, 200, 30) View:view Alignment:0 Color:gray Tag:1];
    
    
    payview=[LSFUtil viewWithRect:CGRectMake(0, view.frame.size.height+65, SCREEN_WIDTH, 70) view:self.view backgroundColor:white];
    
    [self addPayBtn];
    
    
    UIButton*loginBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(30,BottomHeight,SCREEN_WIDTH-60, 40) title:@"立即付款" select:@selector(PayAction) Tag:3 View:self.view textColor:white Size:font14 background:MS_RGB(250,82,2)];
    loginBtn.layer.cornerRadius=5;
    loginBtn.layer.masksToBounds=YES;
    
    
}
-(void)PayAction{
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"zfb_pay"];
    [api zfb_pay:dataArray[Tag] type:@"会员充值"];
}
-(void)addPayBtn{

   [payview.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       [obj removeFromSuperview];
   }];
    
    for(int i=0;i<dataArray.count;i++){
        
        @autoreleasepool {
            
            
            NSInteger index=i%4;
            NSInteger page=i/4;
            NSInteger a=[gouArray[i] integerValue];
            
            UIView * view =[LSFUtil viewWithRect:CGRectMake((SCREEN_WIDTH/4)*index, 60*page, SCREEN_WIDTH/4, 60) view:payview backgroundColor:white];
         
            
            UIButton * btn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake((view.frame.size.width-70)/2, 10, 70, 40) title:[NSString stringWithFormat:@"%@",dataArray[i]] select:@selector(BtnAction:) Tag:i View:view textColor:gray Size:font14 background:a==1?MS_RGB(254,233,204):white];
            
         
            btn.layer.cornerRadius=5;
            btn.layer.masksToBounds=YES;
            btn.layer.borderWidth=1;
            btn.layer.borderColor=a==1?[MS_RGB(250,82,2) CGColor]:[ColorHUI CGColor];
            
        }
        
    }

}

-(void)BtnAction:(UIButton*)btn{

    
    Tag=btn.tag;
    gouArray=[[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0", nil];
    
    [gouArray replaceObjectAtIndex:btn.tag withObject:@"1"];
    
    [self addPayBtn];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Api回调
- (void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    NSLog(@"apiError=%@",message);
    [self showHint:message];
}

- (void)Sucess:(id)response tag:(NSString*)tag
{
    [self hideHud];

    if([tag isEqualToString:@"vip_recharge"]){
    
        [self.navigationController popToRootViewControllerAnimated:YES];
    
    }
    else{
    
    [self alipay:response[@"data"]];
    [self initialPayObserver];
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
    
    [self showHint:@"充值成功"];
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"vip_recharge"];
    [api vip_recharge:dataArray[Tag] sn:@"12122" addition:@"0"];
    
}
-(void)paymentFalse{
    
    [self showHint:@"取消支付"];
}

@end
