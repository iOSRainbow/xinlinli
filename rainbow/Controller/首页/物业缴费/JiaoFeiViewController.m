//
//  JiaoFeiViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/23.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "JiaoFeiViewController.h"
#import "GetUserAddressViewController.h"
#import "WuYeJiaoFeiViewController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface JiaoFeiViewController ()

@end

@implementation JiaoFeiViewController

-(void)actNavRightBtn{

    WuYeJiaoFeiViewController * w =[[WuYeJiaoFeiViewController alloc] init];
    
    [self.navigationController pushViewController:w animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"物业缴费"];
    
    [self addNavRightBtnWithTitle:@"缴费记录"];
    
    addressId=@"";
    countPay=0.0;
    priceDouble=0.0;
    
    scr=[LSFUtil add_scollview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH,ViewHeight) Tag:1 View:self.view co:CGSizeMake(0, 350+TabbarHeight)];
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, 265) view:scr backgroundColor:white];
    
    addressLb=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 10, SCREEN_WIDTH/2, 20) View:view Alignment:0 Color:gray Tag:1];
    
    nameLb=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 35, SCREEN_WIDTH/2, 20) View:view Alignment:0 Color:gray Tag:2];
    
    cityLb=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(SCREEN_WIDTH/2,0, SCREEN_WIDTH/2-40, 65) View:view Alignment:2 Color:gray Tag:3];
    
    [LSFUtil addSubviewImage:@"lsf27" rect:CGRectMake(SCREEN_WIDTH-20,(65-20)/2, 20, 20) View:view Tag:1];
    
    tipLb=[LSFUtil labelName:@"请选择您要缴费的小区" fontSize:font16 rect:CGRectMake(10, 0, SCREEN_WIDTH-20, 65) View:view Alignment:0 Color:gray Tag:4];
    
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, SCREEN_WIDTH, 65) title:nil select:@selector(Action:) Tag:1 View:view textColor:nil Size:nil background:nil];
    
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 65, SCREEN_WIDTH, 1) view:view];
    
    payLb=[LSFUtil labelName:@"收费标准: 0元/平" fontSize:font14 rect:CGRectMake(10, 65,SCREEN_WIDTH-30, 50) View:view Alignment:0 Color:gray Tag:5];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 115, SCREEN_WIDTH, 1) view:view];

    
    [LSFUtil labelName:@"住房面积: " fontSize:font14 rect:CGRectMake(10, 115,80, 50) View:view Alignment:0 Color:gray Tag:5];

    numText=[LSFUtil addTextFieldView:CGRectMake(90,115,SCREEN_WIDTH-100, 50) Tag:1 textColor:gray Alignment:0 Text:nil placeholderStr:@"输入住房面积" View:view font:font14];
    numText.keyboardType = UIKeyboardTypeDecimalPad;
    [numText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 165, SCREEN_WIDTH, 1) view:view];

    [LSFUtil labelName:@"缴费月份: " fontSize:font14 rect:CGRectMake(10, 165,80, 50) View:view Alignment:0 Color:gray Tag:5];

    
    monthText=[LSFUtil addTextFieldView:CGRectMake(100, 165,100, 50) Tag:1 textColor:gray Alignment:0 Text:@"6" placeholderStr:@"月数" View:view font:font14];
    monthText.keyboardType = UIKeyboardTypeNumberPad;
    [monthText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 215, SCREEN_WIDTH, 1) view:view];

    moneyLb=[LSFUtil labelName:@"合计: ￥0" fontSize:font14 rect:CGRectMake(10, 215,SCREEN_WIDTH-20, 50) View:view Alignment:0 Color:gray Tag:5];
    
    
    
    
    UIButton*loginBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(20, 300,SCREEN_WIDTH-40, 40) title:@"确认支付" select:@selector(Action:) Tag:3 View:scr textColor:white Size:font15 background:MS_RGB(250,82,2)];
    loginBtn.layer.cornerRadius=5;
    loginBtn.layer.masksToBounds=YES;

    

}

-(void)Action:(UIButton*)btn{

    if(btn.tag==1){
    GetUserAddressViewController * get =[[GetUserAddressViewController alloc] init];
        
    get.fromView=@"物业缴费";
        
    get.completeBlockNSDictionary=^(NSDictionary*dic){
    
        tipLb.hidden=YES;
        addressLb.text=dic[@"address"];
        
        nameLb.text=dic[@"name"];
        
        cityLb.text=dic[@"cityName"];
        bulidingId=dic[@"bulidingId"];
        
        addressId=dic[@"addressId"];
        cellId=dic[@"cellId"];
        
        
        payLb.text=[NSString stringWithFormat:@"收费标准: %@元/平",dic[@"price"]];
        priceDouble=[dic[@"price"] doubleValue];
        
        countPay =priceDouble*[numText.text floatValue]*[monthText.text integerValue];
        
        moneyLb.text=[NSString stringWithFormat:@"合计 :%.2f元",countPay];
        

    };
    
    [self.navigationController pushViewController:get animated:YES];
    }
    else{
    
        if([LSFEasy isEmpty:addressId]){
        
            [self showHint:@"请选择您要缴费的小区"];
            return;
            
        }
        if([numText.text integerValue]==0){
        
            [self showHint:@"请输入您真实住房面积"];
            return;
        
        }
        if([monthText.text integerValue]==0){
        
            [self showHint:@"请选择您要缴纳的月数"];
            return;
        }
        if(countPay==0){
        
            [self showHint:@"缴费总金额不能为0"];
            return;
        
        }
        
        [self showHudInView:self.view hint:@"加载中"];
        Api * api =[[Api alloc] init:self tag:@"zfb_cellpay"];
        [api zfb_cellpay:[NSString stringWithFormat:@"%.2f",countPay] cellId:cellId];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldDidChange:(UITextField *)textField{
    
    countPay =priceDouble*[numText.text floatValue]*[monthText.text integerValue];
        
    moneyLb.text=[NSString stringWithFormat:@"合计 :%.2f元",countPay];
    
}


-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];

}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    
   if ([tag isEqualToString:@"cellpay_insert"]){
    
        [self actNavRightBtn];
    
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
    
    [self showHudInView:self.view hint:@"加载中"];
    
    Api * api =[[Api alloc] init:self tag:@"cellpay_insert"];
    [api cellpay_insert:addressId price:[NSString stringWithFormat:@"%.2f",countPay] months:monthText.text];
    
}
-(void)paymentFalse{
    
    [self showHint:@"取消支付"];
}

//13585022396   123456
@end
