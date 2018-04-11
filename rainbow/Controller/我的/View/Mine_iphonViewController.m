//
//  Mine_iphonViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "Mine_iphonViewController.h"

@interface Mine_iphonViewController ()

@end

@implementation Mine_iphonViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:_name];
    
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, 100) view:self.view backgroundColor:white];
    
 
    
    usernameText=[LSFUtil addTextFieldView:CGRectMake(15, 0, view.frame.size.width-30, 50) Tag:1 textColor:gray Alignment:0 Text:UserName placeholderStr:nil View:view font:font14];
    usernameText.userInteractionEnabled=NO;

    
    valiteText=[LSFUtil addTextFieldView:CGRectMake(15, 50,view.frame.size.width-30, 50) Tag:1 textColor:gray Alignment:0 Text:nil placeholderStr:_viewType==1?@"抵用卷兑换码":@"会员卡密码" View:view font:font14];
    
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 50, view.frame.size.width, 1) view:view];
    
    
    UIButton*loginBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(30,NavigationHeight+140,SCREEN_WIDTH-60, 40) title:_viewType==1?@"确认兑换":@"确认激活" select:@selector(Action:) Tag:3 View:self.view textColor:white Size:font14 background:MS_RGB(250,82,2)];
    loginBtn.layer.cornerRadius=5;
    loginBtn.layer.masksToBounds=YES;
    
    
}

-(void)Action:(UIButton *)btn{

    if(valiteText.text.length==0){
        
        [self showHint:_viewType==1?@"请输入兑换码":@"请输会员卡密码"];
        return;
        
    }
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"vip_vipactivate"];
    
    [api vip_vipactivate:valiteText.text type:_viewType];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    
    [self showHint:response[@"msg"]];
    
    
    self.completeBlockNone();
    
    if(_viewType!=1){
    [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
