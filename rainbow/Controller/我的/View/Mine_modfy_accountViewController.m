//
//  Mine_modfy_accountViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "Mine_modfy_accountViewController.h"

@interface Mine_modfy_accountViewController ()

@end

@implementation Mine_modfy_accountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"修改子账户密码"];
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, 150) view:self.view backgroundColor:white];
    
    
    [LSFUtil labelName:@"子账户名" fontSize:font14 rect:CGRectMake(10, 0, 100, 50) View:view Alignment:0 Color:black Tag:1];
    [LSFUtil labelName:@"子账户密码" fontSize:font14 rect:CGRectMake(10, 50, 100, 50) View:view Alignment:0 Color:black Tag:1];
    [LSFUtil labelName:@"子账户密码" fontSize:font14 rect:CGRectMake(10, 100, 100, 50) View:view Alignment:0 Color:black Tag:1];

    
    usernameText=[LSFUtil addTextFieldView:CGRectMake(120, 0, SCREEN_WIDTH-130, 50) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"请输入子账户名" View:view font:font14];
    
    
    passwrodText=[LSFUtil addTextFieldView:CGRectMake(120, 50, SCREEN_WIDTH-130, 50) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"请输入子账户密码" View:view font:font14];
    
    
    aginpasswordText=[LSFUtil addTextFieldView:CGRectMake(120, 100, SCREEN_WIDTH-130, 50) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"请输入子账户密码" View:view font:font14];

    
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 50, SCREEN_WIDTH, 1) view:view];
    
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 100, SCREEN_WIDTH, 1) view:view];

    
    
    UIButton*add=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(20,NavigationHeight+180,SCREEN_WIDTH-40, 40) title:@"完成" select:@selector(Action:) Tag:3 View:self.view textColor:white Size:font14 background:MS_RGB(250,82,2)];
    add.layer.cornerRadius=5;
    add.layer.masksToBounds=YES;
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Action:(UIButton*)btn{

    if(usernameText.text.length==0){
        
        [self showHint:@"子账户名不能为空"];
        return;
    }
    
    if(passwrodText.text.length==0||aginpasswordText.text.length==0){
        
        [self showHint:@"子账户密码(6-20位)"];
        return;
    }
    if(![passwrodText.text isEqual:aginpasswordText.text]){
    
        [self showHint:@"2次输入子账户密码不一致"];
        return;
    }
}

@end
