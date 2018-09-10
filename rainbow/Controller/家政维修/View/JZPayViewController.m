//
//  JZPayViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/6/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "JZPayViewController.h"
#import "GetAddressListViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "OrderListViewController.h"
#import "DiscountListViewController.h"
#import "DHModel.h"
@interface JZPayViewController ()

@end

@implementation JZPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"确认订单"];
    
    scr=[LSFUtil add_scollview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight-50) Tag:1 View:self.view co:CGSizeMake(0, 380)];
    
    payType=1;
    offsetcount=0;
    vouchercellId=@"";
    voucherId=@"";
    subprice=@"";

    
    [self addAddressView];
    
    [self getData];

    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, BottomHeight, SCREEN_WIDTH, 50) view:self.view backgroundColor:white];
    
    priceInfoLable=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10,0,SCREEN_WIDTH-120-20,50) View:view Alignment:0 Color:Red Tag:1];
    
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-120,0, 120, 50) title:@"提交订单" select:@selector(PayAction) Tag:1 View:view textColor:white Size:font18 background:Red];

}
-(void)getData{
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api1 =[[Api alloc] init:self tag:@"orders_addUI"];
    [api1 orders_addUI:_IdStr];
    
}
-(void)PayAction{


    if([LSFEasy isEmpty:addressLable.text]){
    
        [self showHint:@"请选择地址"];
        return;
    }

   
    if(payType==1){
        
        CGFloat count =countPrice-offsetcount;
        if(count<=0){
            count=0;
            [self showHint:@"支付价格为0,无法使用支付宝支付,请使用账户余额支付"];
            return;
        }
      
      [self showHudInView:self.view hint:@"加载中"];
      Api * api =[[Api alloc] init:self tag:@"zfb_pay"];
      [api zfb_pay:[NSString stringWithFormat:@"%.2f",count*discount] type:shopName.text];
    }
    else{
    
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否使用账户余额" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self paymentDone];

            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    
    }
    
}

-(void)addAddressView{

    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, 80) view:scr backgroundColor:white];
    
    [LSFUtil addSubviewImage:@"lsf39" rect:CGRectMake(10, 30, 20, 20) View:view Tag:1];
    
    tipLable=[LSFUtil labelName:@"请选择地址" fontSize:font14 rect:CGRectMake(50,0,100,80) View:view Alignment:0 Color:black Tag:1];
    

    nameLable=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(50,10,SCREEN_WIDTH-80,20) View:view Alignment:0 Color:black Tag:1];

    
    addressLable=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(50,30,SCREEN_WIDTH-80,40) View:view Alignment:0 Color:black Tag:1];
    
    [LSFUtil addSubviewImage:@"lsf27" rect:CGRectMake(SCREEN_WIDTH-30, 30, 20, 20) View:view Tag:1];

    
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, SCREEN_WIDTH,80) title:nil select:@selector(SelectAddress) Tag:1 View:view textColor:nil Size:nil background:nil];
    
    
    [self goodsInfoView:view.frame.size.height];

}


-(void)goodsInfoView:(CGFloat)hy{

    UIView * view1 =[LSFUtil viewWithRect:CGRectMake(0,hy, SCREEN_WIDTH,50) view:scr backgroundColor:white];
    
     shopPicImg=[LSFUtil addSubviewImage:nil rect:CGRectMake(10, 5, 40, 40) View:view1 Tag:1];

     shopName=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(70,0,SCREEN_WIDTH-80,50) View:view1 Alignment:0 Color:black Tag:1];
    
    shopGoodName= [LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10,60+hy,SCREEN_WIDTH-20,40) View:scr Alignment:0 Color:black Tag:1];

    
    shopPrice=[LSFUtil labelName:nil fontSize:font16 rect:CGRectMake(10,110+hy,SCREEN_WIDTH-20,20) View:scr Alignment:0 Color:Red Tag:1];
    
    
    [LSFUtil labelName:[NSString stringWithFormat:@"x%i",_goodNum] fontSize:font14 rect:CGRectMake(0, 110+hy, SCREEN_WIDTH-10, 20) View:scr Alignment:2 Color:black Tag:1];
    
    [self goodsNumView:150+hy];

}

-(void)goodsNumView:(CGFloat)hy{

    UIView * view =[LSFUtil viewWithRect:CGRectMake(0,hy, SCREEN_WIDTH,255) view:scr backgroundColor:white];
    
    scr.contentSize=CGSizeMake(0, hy+260);
    
    
    [LSFUtil labelName:@"请选择支付方式" fontSize:font14 rect:CGRectMake(10,0, 200, 50) View:view Alignment:0 Color:black Tag:1];
  
    //
    [LSFUtil addSubviewImage:@"lsf83" rect:CGRectMake(10,50+15,20,20) View:view Tag:1];
    
    [LSFUtil labelName:@"支付宝" fontSize:font14 rect:CGRectMake(40,50, 100, 50) View:view Alignment:0 Color:black Tag:1];
    
    selectImg=[LSFUtil addSubviewImage:@"lsf28" rect:CGRectMake(SCREEN_WIDTH-30,50+15,20,20) View:view Tag:1];
    
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 50, SCREEN_WIDTH, 50) title:nil select:@selector(SelectImgAction:) Tag:1 View:view textColor:nil Size:nil background:nil];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 99, SCREEN_WIDTH, 1) view:view];
    
//
    [LSFUtil addSubviewImage:@"lsf90" rect:CGRectMake(10,100+15,20,20) View:view Tag:1];
    
    [LSFUtil labelName:@"账户余额" fontSize:font14 rect:CGRectMake(40,100, 100, 50) View:view Alignment:0 Color:black Tag:1];
    
    unselectImg=[LSFUtil addSubviewImage:@"lsf44" rect:CGRectMake(SCREEN_WIDTH-30,100+15,20,20) View:view Tag:1];
    
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 100, SCREEN_WIDTH, 50) title:nil select:@selector(SelectImgAction:) Tag:2 View:view textColor:nil Size:nil background:nil];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 149, SCREEN_WIDTH, 1) view:view];
    
    //
    [LSFUtil addSubviewImage:@"lsf95" rect:CGRectMake(10,150+15,20,20) View:view Tag:1];
    [LSFUtil labelName:@"抵用卷" fontSize:font14 rect:CGRectMake(40,150, 100, 50) View:view Alignment:0 Color:black Tag:1];
    
    discountLable=[LSFUtil labelName:@"" fontSize:font14 rect:CGRectMake(140,150, SCREEN_WIDTH-180, 50) View:view Alignment:2 Color:gray Tag:1];
    
    [LSFUtil addSubviewImage:@"lsf27" rect:CGRectMake(SCREEN_WIDTH-30, 150+15, 20, 20) View:view Tag:1];

    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 150, SCREEN_WIDTH, 50) title:nil select:@selector(DiYongAction) Tag:2 View:view textColor:nil Size:nil background:nil];
    
    //
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 199, SCREEN_WIDTH, 1) view:view];


    
    [LSFUtil labelName:@"买家留言: " fontSize:font14 rect:CGRectMake(10,200, 100, 50) View:view Alignment:0 Color:black Tag:1];

    
    text=[LSFUtil addTextFieldView:CGRectMake(100, 205, SCREEN_WIDTH-130, 40) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"请输入买家留言" View:view font:font14];
    
}

-(void)DiYongAction{
    
    if(deposit==1){
        
        [self showHint:@"需支付定金的商品不可使用抵用卷来抵扣"];
        return;
    }
    
    DiscountListViewController * list =[[DiscountListViewController alloc] init];
    list.price=[NSString stringWithFormat:@"%.2f",_goodNum * price];
    
    list.array1=[redeemcells mutableCopy];
    list.array2=[voucherCustoms mutableCopy];
    
    __weak typeof(self)weakSelf=self;
    list.completeBlockModel=^(DHModel*model){
        
        vouchercellId=model.vouchercellId;
        voucherId=model.voucherId;
        subprice=model.subprice;
        discountLable.text=[NSString stringWithFormat:@"满%@减%@",model.fullprice,model.subprice];
        [weakSelf getCountMoeny];
    };
    
    [self.navigationController pushViewController:list animated:YES];
    
}
-(void)SelectImgAction:(UIButton*)btn{


    payType=btn.tag;

    if(btn.tag==1){
    
        selectImg.image=[UIImage imageNamed:@"lsf28"];
        unselectImg.image=[UIImage imageNamed:@"lsf44"];

    }else if(btn.tag==2) {
        selectImg.image=[UIImage imageNamed:@"lsf44"];
        unselectImg.image=[UIImage imageNamed:@"lsf28"];
    }
}



-(void)getCountMoeny{
    
    if(![LSFEasy isEmpty:subprice]){
        
        offsetcount =[subprice floatValue];
        
        CGFloat count =countPrice-offsetcount;
        
        if(count<0){
            
            count=0;
        }
        priceInfoLable.text=[NSString stringWithFormat:@"共%zi件商品\n合计 :￥%.2f",_goodNum,count*discount];
    }
    else{
    
    
        priceInfoLable.text=[NSString stringWithFormat:@"共%zi件商品\n合计 :￥%.2f",_goodNum,countPrice*discount];
      
    }

}


-(void)SelectAddress{

    GetAddressListViewController * get =[[GetAddressListViewController alloc] init];
    
    get.fromView=@"JZPayView";
    
    get.completeBlockNSDictionary=^(NSDictionary*dic){
        
        tipLable.hidden=YES;

        addressLable.text=dic[@"address"];
        
        nameLable.text=[NSString stringWithFormat:@"收货人: %@    %@",dic[@"name"],dic[@"tel"]];
        
        addressTel=dic[@"tel"];
        addressName=dic[@"name"];
    };
    
    [self.navigationController pushViewController:get animated:YES];

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
    if([tag isEqualToString:@"zfb_pay"]||[tag isEqualToString:@"order_insert"]){
        
        [self showHint:message];

    }
}

- (void)Sucess:(id)response tag:(NSString*)tag
{
    [self hideHud];
    
    if([tag isEqualToString:@"zfb_pay"]){
        
        [self alipay:response[@"data"]];
        [self initialPayObserver];
    }
   else if([tag isEqualToString:@"order_insert"]){
        
        [self showHint:response[@"msg"]];
        OrderListViewController * list =[[OrderListViewController alloc] init];
        [self.navigationController pushViewController:list animated:YES];
    }
   else if ([tag isEqualToString:@"orders_addUI"]){
       
       NSDictionary * dic=response[@"data"];
       
       NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=good",urlStr,dic[@"goodscate"][@"url"]];
       
       [shopPicImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"lsf64"]];
       
       shopName.text=dic[@"goodscate"][@"name"];
       
       goodspacatid=dic[@"goodscate"][@"id"];
       
       deposit=[dic[@"goodscate"][@"deposit"] integerValue];
       
       shopGoodName.text=dic[@"goodsinfo"][@"name"];
       
       shopPrice.text=[NSString stringWithFormat:@"￥%@",dic[@"goodsinfo"][@"lowprice"]];
       
       discount=[dic[@"memberdegree"][@"discount"] floatValue]/100;
     
       if(deposit==1)
       {
           discount=1.00;
           shopPrice.text=[NSString stringWithFormat:@"定金￥%@",dic[@"goodsinfo"][@"lowprice"]];
       }
       
       price=[dic[@"goodsinfo"][@"lowprice"] floatValue];
       
       countPrice=price*_goodNum;
       
       
       priceInfoLable.text=[NSString stringWithFormat:@"共%zi件商品\n合计 :￥%.2f",_goodNum,countPrice*discount];
   
      redeemcells=dic[@"redeemcells"];
      voucherCustoms=dic[@"voucherCustoms"];
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
    Api * api =[[Api alloc] init:self tag:@"order_insert"];
    CGFloat count =countPrice-offsetcount;
    if(count<=0){
        
        count=0;
        payType=2;
    }
    [api order_insert:addressName tel:addressTel address:addressLable.text goodsname:shopGoodName.text servicetime:@"2018-08-11 09:08:00" msg:text.text price:[NSString stringWithFormat:@"%.2f",price*_goodNum] payment:[NSString stringWithFormat:@"%zi",payType] zfbno:@"支付宝支付" voucherId:voucherId vouchercellId:vouchercellId realprice:[NSString stringWithFormat:@"%.2f",count] goodscateId:goodspacatid amount:[NSString stringWithFormat:@"%zi",_goodNum]];
    
}
-(void)paymentFalse{
    
    [self showHint:@"取消支付"];
}


@end
