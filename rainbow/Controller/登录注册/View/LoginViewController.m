//
//  LoginViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "LoginViewController.h"
#import "SignViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    NSString * name =[myUserDefaults objectForKey:@"username"];
    NSString * password =[myUserDefaults objectForKey:@"password"];
    NSString * flag =[myUserDefaults objectForKey:@"passwordFlag"];
    
    usernameText.text=name;
    passwordText.text=[flag integerValue]==0?@"":password;
    
    forgetBtn.selected=[flag integerValue]==0?NO:YES;
    
    [forgetBtn setAttributedTitle:[LSFUtil ButtonAttriSring:@" 记住密码" color:MS_RGB(250,82,2) image:[flag integerValue]==1?@"lsf4":@"lsf5" type:1 rect:CGRectMake(0,-5, 20, 20)] forState:normal];



}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    navView.hidden=YES;
    scr=[LSFUtil add_scollview:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) Tag:1 View:self.view co:CGSizeMake(0, 370+NavigationHeight)];
    
    [LSFUtil addSubviewImage:@"lsf1" rect:CGRectMake((SCREEN_WIDTH-60)/2, NavigationHeight+10, 60, 60) View:scr Tag:1];
    
    [LSFUtil addSubviewImage:@"lsf2" rect:CGRectMake(20, NavigationHeight+110, 20, 20) View:scr Tag:1];
    
    usernameText=[LSFUtil addTextFieldView:CGRectMake(55, NavigationHeight+110, SCREEN_WIDTH-60, 20) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"请输入手机号" View:scr font:font14];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(20, NavigationHeight+145, SCREEN_WIDTH-40, 1) view:scr];
    
    
    [LSFUtil addSubviewImage:@"lsf3" rect:CGRectMake(20, NavigationHeight+160, 20, 20) View:scr Tag:1];
    
    passwordText=[LSFUtil addTextFieldView:CGRectMake(55, NavigationHeight+160, SCREEN_WIDTH-60, 20) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"密码(6-20位)" View:scr font:font14];
    [passwordText setSecureTextEntry:YES];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(20, NavigationHeight+190, SCREEN_WIDTH-40, 1) view:scr];
    
    
    forgetBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(20, NavigationHeight+210, 100, 20) title:nil select:@selector(Action:) Tag:1 View:scr textColor:nil Size:font14 background:nil];
    forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-100, NavigationHeight+210,90, 20) title:@"忘记密码 ?" select:@selector(Action:) Tag:2 View:scr textColor:gray Size:font14 background:nil];
    

    UIButton*loginBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(40, NavigationHeight+260,SCREEN_WIDTH-80, 40) title:@"登录" select:@selector(Action:) Tag:3 View:scr textColor:white Size:font14 background:MS_RGB(250,82,2)];
    loginBtn.layer.cornerRadius=5;
    loginBtn.layer.masksToBounds=YES;

    
    UIButton*signBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(40, NavigationHeight+320,SCREEN_WIDTH-80, 40) title:@"注册" select:@selector(Action:) Tag:4 View:scr textColor:MS_RGB(250,82,2) Size:font14 background:nil];
    signBtn.layer.cornerRadius=5;
    signBtn.layer.masksToBounds=YES;
    signBtn.layer.borderWidth=1;
    signBtn.layer.borderColor=[MS_RGB(250,82,2) CGColor];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Action:(UIButton*)btn{

    if(btn.tag==1){
    
        if(!forgetBtn.selected){
        
        
         [forgetBtn setAttributedTitle:[LSFUtil ButtonAttriSring:@" 记住密码" color:MS_RGB(250,82,2) image:@"lsf4" type:1 rect:CGRectMake(0,-5, 20, 20)] forState:normal];
            forgetBtn.selected=YES;
            [myUserDefaults setObject:@"1" forKey:@"passwordFlag"];
 
        }
        else{
        
            [forgetBtn setAttributedTitle:[LSFUtil ButtonAttriSring:@" 记住密码" color:MS_RGB(250,82,2) image:@"lsf5" type:1 rect:CGRectMake(0,-5, 20, 20)] forState:normal];
            forgetBtn.selected=NO;

            [myUserDefaults setObject:@"0" forKey:@"passwordFlag"];


        }
        
        [myUserDefaults synchronize];
    }
    
    if(btn.tag==3){
    
        if(![LSFEasy validateMobile:usernameText.text]){
        
            [self showHint:@"请输入正确的手机号格式"];
            return;
        }
        if(passwordText.text.length<6||passwordText.text.length>20){
        
            [self showHint:@"请输入登录密码(6-20位)"];
            return;
        }
    
    
        [self showHudInView:self.view hint:@"加载中"];
        Api * api =[[Api alloc] init:self tag:@"login"];
        [api login:usernameText.text Password:passwordText.text];
        
    }
  
    if(btn.tag==4||btn.tag==2){
     
        SignViewController * s =[[SignViewController alloc] init];
        s.viewType=btn.tag;
        [self.navigationController pushViewController:s animated:YES];
    
    }
    
}

-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];

}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    [self showHint:response[@"data"][@"msg"]];
    NSDictionary * dic=response[@"data"][@"user"];
    
    [myUserDefaults setObject:dic[@"id"] forKey:@"token"];
    [myUserDefaults setObject:[LSFEasy isEmpty:response[@"data"][@"cellId"]]?@"":response[@"data"][@"cellId"] forKey:@"cellId"];
    [myUserDefaults setObject:usernameText.text forKey:@"username"];
    [myUserDefaults setObject:passwordText.text forKey:@"password"];
    [myUserDefaults setObject:[LSFEasy isEmpty:dic[@"parentId"]]?@"":dic[@"parentId"] forKey:@"parentId"];
    [myUserDefaults setObject:[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=h",urlStr,dic[@"headpic"]] forKey:@"headpic"];
    [myUserDefaults setObject:dic[@"logtime"] forKey:@"logtime"];
    [myUserDefaults synchronize];
    
    [[AppDelegate sharedAppDelegate] StartMain];
    
}
@end
