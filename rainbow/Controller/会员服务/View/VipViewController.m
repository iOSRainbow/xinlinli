//
//  VipViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/6/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "VipViewController.h"
#import "VipTeViewController.h"
#import "Mine_iphonViewController.h"
#import <AlipaySDK/AlipaySDK.h>

#import "YouhuiViewController.h"

#define Rate 138/640
#define TopScrollHeigt SCREEN_WIDTH*Rate

@interface VipViewController ()

@end

@implementation VipViewController

-(void)actNavRightBtn{

    
    YouhuiViewController * addressList =[[YouhuiViewController alloc] init];
    addressList.hidesBottomBarWhenPushed=YES;
    
    addressList.fromView=@"会员福利";
    
    [self.navigationController pushViewController:addressList animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"会员服务"];
    
    
    [self addNavRightBtnWithTitle:@"会员福利"];
    
    gouArray=[[NSMutableArray alloc] initWithObjects:@"1",@"0",@"0",@"0", nil];
    dataArray=[[NSMutableArray alloc] initWithObjects:@"1000",@"2000",@"3000",@"5000", nil];
    
    moenyArray=[[NSMutableArray alloc] initWithObjects:@"100",@"300",@"400",@"800", nil];
    
    balance=0.00;
    amount=0.00;
    Tag=0;
    
    scr=[LSFUtil add_scollview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH,ViewHeight-TabbarStautsHeight) Tag:1 View:self.view co:CGSizeMake(0, SCREEN_HEIGHT)];
    
    [self VipUserInfoView];
    
}

-(void)viewWillAppear:(BOOL)animated{

    Api * api1 =[[Api alloc] init:self tag:@"app_user_getTime"];
    [api1 app_user_getTime];
    
    [self getData];

}

-(void)getData{
    
    Api * api =[[Api alloc] init:self tag:@"vip_vipuser"];
    [api vip_vipuser];
}
-(void)VipUserInfoView{

    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, 70) view:scr backgroundColor:white];
    
    headImg =[LSFUtil addSubviewImage:@"lsf64" rect:CGRectMake(10, 10,50,50) View:view Tag:1];
    headImg.layer.cornerRadius=25;
    headImg.layer.masksToBounds=YES;
    
    nickname=[LSFUtil labelName:UserName fontSize:font14 rect:CGRectMake(70,10,SCREEN_WIDTH-80,20) View:view  Alignment:0 Color:Red Tag:1];

    statusLb=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(70,40,SCREEN_WIDTH-80,20) View:view  Alignment:0 Color:Red Tag:1];
    
    [LSFUtil addSubviewImage:@"lsf84" rect:CGRectMake(0, view.frame.size.height+10, SCREEN_WIDTH, TopScrollHeigt) View:scr Tag:1];
    
    
    [self VipGoodsView:TopScrollHeigt+view.frame.size.height+20];
    
    
}

-(void)VipGoodsView:(CGFloat)hy{

    UIView * view =[LSFUtil viewWithRect:CGRectMake(0,hy, SCREEN_WIDTH, 50) view:scr backgroundColor:white];

    [LSFUtil addSubviewImage:@"lsf87" rect:CGRectMake(10,(50-23/2)/2,18, 23/2) View:view Tag:1];
    
    [LSFUtil labelName:@"会员特权" fontSize:font14 rect:CGRectMake(35, 0, 100, 50) View:view Alignment:0 Color:black Tag:1];
    
    [LSFUtil addSubviewImage:@"lsf27" rect:CGRectMake(SCREEN_WIDTH-30,15, 20, 20) View:view Tag:1];

    
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) title:nil select:@selector(VipAction:) Tag:1 View:view textColor:nil Size:nil background:nil];


    [self VipSelectInfoView:hy+60];

}
-(void)VipSelectInfoView:(CGFloat)hy{

    [VipTaoCanView removeFromSuperview];
    VipTaoCanView =[LSFUtil viewWithRect:CGRectMake(0,hy, SCREEN_WIDTH, 300) view:scr backgroundColor:white];
    
    [LSFUtil labelName:@"会员套餐" fontSize:font16 rect:CGRectMake(10, 0, 100, 40) View:VipTaoCanView Alignment:0 Color:black Tag:1];
    
    Vipview=[LSFUtil viewWithRect:CGRectMake(0, 40, SCREEN_WIDTH, 240) view:VipTaoCanView backgroundColor:white];
    
    [self addVipInfoBtn];
    
    
    [self VipUserView:VipTaoCanView.frame.size.height+hy+10];

}


-(void)VipUserView:(CGFloat)hy{


    [VipCardView removeFromSuperview];
    VipCardView =[LSFUtil viewWithRect:CGRectMake(0,hy, SCREEN_WIDTH, 50) view:scr backgroundColor:white];
    
    
    [LSFUtil addSubviewImage:@"lsf86" rect:CGRectMake(10, (50-25/2)/2, 18, 25/2) View:VipCardView Tag:1];
    
    [LSFUtil labelName:@"会员卡激活" fontSize:font14 rect:CGRectMake(35, 0, 100, 50) View:VipCardView Alignment:0 Color:black Tag:1];
    
    [LSFUtil addSubviewImage:@"lsf27" rect:CGRectMake(SCREEN_WIDTH-30,15, 20, 20) View:VipCardView Tag:1];
    
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, VipCardView.frame.size.width, VipCardView.frame.size.height) title:nil select:@selector(VipAction:) Tag:2 View:VipCardView textColor:nil Size:nil background:nil];
    
    
    surePaybtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(30,VipCardView.frame.size.height+hy+30,SCREEN_WIDTH-60, 40) title:@"确认支付" select:@selector(VipAction:) Tag:3 View:scr textColor:white Size:font14 background:MS_RGB(250,82,2)];
    surePaybtn.layer.cornerRadius=5;
    surePaybtn.layer.masksToBounds=YES;
    
    
    scr.contentSize=CGSizeMake(0, VipCardView.frame.size.height+hy+80);


}

-(void)addVipInfoBtn{

    [Vipview.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    NSArray*ary1=@[@"普通会员",@"白银会员",@"黄金会员",@"至尊会员"];
    NSArray*ary2=@[@"9",@"8.5",@"8",@"7.5"];
    
    for(int i=0;i<ary1.count;i++){
    
        @autoreleasepool {
            
            NSInteger a=[gouArray[i] integerValue];
            
            UIView * view =[LSFUtil viewWithRect:CGRectMake(10, 60*i, SCREEN_WIDTH-20, 50) view:Vipview backgroundColor:a==1?MS_RGB(254,233,204):white];
            view.layer.cornerRadius=5;
            view.layer.masksToBounds=YES;
            view.layer.borderWidth=1;
            view.layer.borderColor=a==1?[MS_RGB(250,82,2) CGColor]:[ColorHUI CGColor];
            
            [LSFUtil labelName:ary1[i] fontSize:font14 rect:CGRectMake(10, 5, 100, 20) View:view Alignment:0 Color:black Tag:1];
            
            [LSFUtil labelName:[NSString stringWithFormat:@"专享%@折(充%@送%@)",ary2[i],dataArray[i],moenyArray[i]] fontSize:font13 rect:CGRectMake(10,25,view.frame.size.width-50, 20) View:view Alignment:0 Color:gray Tag:1];
            
            
            [LSFUtil labelName:[NSString stringWithFormat:@"￥%@",dataArray[i]] fontSize:font16 rect:CGRectMake(0,0,view.frame.size.width-10, 50) View:view Alignment:2 Color:MS_RGB(250,82,2) Tag:1];
            
            
            [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) title:nil select:@selector(BtnAction:) Tag:i View:view textColor:nil Size:nil background:nil];
            
        }
    
    }

}

-(void)BtnAction:(UIButton*)btn{

    Tag=btn.tag;
    
    gouArray=[[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0", nil];

    [gouArray replaceObjectAtIndex:btn.tag withObject:@"1"];
    
    [self addVipInfoBtn];

}

-(NSDictionary*)currentLevel{

    NSString * str =nil;
    NSString * str1=nil;
    CGFloat money=0.00;
    NSString * type=@"0";
    if(amount<1000){
        str=@"未开通会员";
        str1=@"普通会员";
        money=1000-amount;
    }
    else if(amount>=1000&&amount<2000){
        str=@"普通会员";
        str1=@"高级会员";
        money=2000-amount;
    }else if (amount>=2000&&amount<3000){
        str=@"高级会员";
        str1=@"黄金会员";
        money=3000-amount;

    }else if (amount>=3000&&amount<5000){
       str=@"黄金会员";
       str1=@"至尊会员";
       money=5000-amount;

    }else if (amount>=5000){
       str=@"至尊会员";
       str1=@"您已升级到最高等级";
       money=amount;
       type=@"1";
    }
    
    NSDictionary * dic=@{@"currenLevel":str,@"nextLevel":str1,@"money":[NSString stringWithFormat:@"%.2f",money],@"type":type};
    return dic;

}
-(void)VipAction:(UIButton*)btn{

    if(btn.tag==1){
    
        VipTeViewController * vip =[[VipTeViewController alloc] init];
        vip.hidesBottomBarWhenPushed=YES;
        vip.dic=[self currentLevel];
        vip.Amount=[NSString stringWithFormat:@"%.2f",amount];
        [self.navigationController pushViewController:vip animated:YES];
    }
    else if (btn.tag==2){
    
        Mine_iphonViewController * vip =[[Mine_iphonViewController alloc] init];
        vip.hidesBottomBarWhenPushed=YES;
        vip.name=@"激活";
        vip.completeBlockNone=^{
            
            [self getData];
        };
        [self.navigationController pushViewController:vip animated:YES];
    }
    else{
    
        
        [self showHudInView:self.view hint:@"加载中"];
        Api * api =[[Api alloc] init:self tag:@"zfb_pay"];
        [api zfb_pay:dataArray[Tag] type:@"会员办理"];
    
    }

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
  //  [self showHint:message];
}

- (void)Sucess:(id)response tag:(NSString*)tag
{
    [self hideHud];
    if([tag isEqualToString:@"vip_vipuser"]){
    
        NSDictionary * dic=response[@"data"];
        
        
        NSString * realName=[NSString stringWithFormat:@"(%@)",dic[@"user"][@"realname"]];
        NSString * phone =UserName;

        
        NSMutableAttributedString *attri1 =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",phone,realName]];
        
        [attri1 addAttribute:NSForegroundColorAttributeName value:gray range:NSMakeRange(phone.length,realName.length)];
        
        [nickname setAttributedText:attri1];
        
        
        NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=h",urlStr,dic[@"user"][@"headpic"]];
        [headImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"lsf64"]];
        
        
        NSString * name =dic[@"memberdegree"][@"name"];
        
        NSString * balance1=[NSString stringWithFormat:@"  余额%@",dic[@"balance"]];
        
        NSMutableAttributedString *attri =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",name,balance1]];
        
        [attri addAttribute:NSForegroundColorAttributeName value:gray range:NSMakeRange(name.length,balance1.length)];
        
        [statusLb setAttributedText:attri];
        
        balance=[dic[@"balance"] floatValue];
        amount=[dic[@"amount"] floatValue];
        
    }else if ([tag isEqualToString:@"vip_recharge"]){
    
        [self getData];
    }
    else if ([tag isEqualToString:@"zfb_pay"]){
    
        [self alipay:response[@"data"]];
        [self initialPayObserver];
    }else if([tag isEqualToString:@"app_user_getTime"]){
    
        NSDictionary * dic=response[@"data"];
        if(![dic[@"logtime"] isEqual:logtime]){
            
            UIAlertView * alret=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的账号已在其他手机登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alret show];
            [myUserDefaults setObject:@"" forKey:@"token"];
            [myUserDefaults synchronize];
            [[AppDelegate sharedAppDelegate] StartMain];
        }
    
    }
}
/*
 
 if(（1.7>1.6）&&审核中0){
   隐藏
 }else{
   显示
 }
 
 */
-(NSString *)getAppVersion
{
    NSDictionary * infoDictionary =[[NSBundle mainBundle] infoDictionary];
    
    NSString * app_Version=[infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    return app_Version;
    
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
    
    [self showHint:@"支付成功"];
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"vip_recharge"];
    [api vip_recharge:dataArray[Tag] sn:@"111" addition:moenyArray[Tag]];
    
}
-(void)paymentFalse{
    
    [self showHint:@"取消支付"];
}

@end
