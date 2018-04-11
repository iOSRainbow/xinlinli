//
//  Mine_PasswordViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "Mine_PasswordViewController.h"

@interface Mine_PasswordViewController ()

@end

@implementation Mine_PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"修改密码"];
    [self addNavRightBtnWithTitle:@"确定"];
    
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, 150) view:self.view backgroundColor:white];
    
    
    passwordText1=[LSFUtil addTextFieldView:CGRectMake(20, 0, SCREEN_WIDTH-30, 50) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"旧密码(6-20位)" View:view font:font14];
    [passwordText1 setSecureTextEntry:YES];
    
    
    
    passwordText2=[LSFUtil addTextFieldView:CGRectMake(20, 50, SCREEN_WIDTH-30, 50) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"新密码(6-20位)" View:view font:font14];
    [passwordText2 setSecureTextEntry:YES];
    
    
    
    passwordText3=[LSFUtil addTextFieldView:CGRectMake(20, 100, SCREEN_WIDTH-30, 50) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"新密码(6-20位)" View:view font:font14];
    [passwordText3 setSecureTextEntry:YES];
    
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 50, SCREEN_WIDTH, 1) view:view];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 100, SCREEN_WIDTH, 1) view:view];



}
-(void)actNavRightBtn{

    if(passwordText1.text.length==0){
    
        [self showHint:@"旧密码不能为空"];
        return;
    
    }
    if(passwordText1.text.length<6&&passwordText1.text.length>20){
       
        [self showHint:@"旧密码(6-20位)"];
        return;
    
    }
    if(passwordText2.text.length==0||passwordText3.text.length==0){
    
        [self showHint:@"请输入新密码"];
        return;
    
    }
    if((passwordText2.text.length<6&&passwordText2.text.length>20)||(passwordText3.text.length<6&&passwordText3.text.length>20)){
        
        [self showHint:@"新密码(6-20位)"];
        return;
        
    }
    if(![passwordText3.text isEqual:passwordText2.text]){
    
        [self showHint:@"新密码(2次输入不一致)"];
        return;
    
    }
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"changePassword"];
    [api changePassword:passwordText1.text newPassword:passwordText2.text];

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

    [myUserDefaults setObject:passwordText2.text forKey:@"password"];
    [myUserDefaults synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
