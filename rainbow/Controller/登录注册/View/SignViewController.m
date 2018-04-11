//
//  SignViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "SignViewController.h"

@interface SignViewController ()

@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:self.viewType==2?@"忘记密码": @"注册"];
    
    
    scr=[LSFUtil add_scollview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view co:CGSizeMake(0, SCREEN_HEIGHT-84)];
    scr.backgroundColor=white;
    
    
    NSArray * ary =[[NSArray alloc] initWithObjects:@"lsf2",@"lsf6",@"lsf3",@"lsf3", nil];

    for(int i=0;i<ary.count;i++){
    
    [LSFUtil addSubviewImage:ary[i] rect:CGRectMake(10, 50*i+15, 20, 20) View:scr Tag:1];
        
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(10, 50+50*i, SCREEN_WIDTH, 1) view:scr];
    }
    
    
    usernameText=[LSFUtil addTextFieldView:CGRectMake(45, 15, SCREEN_WIDTH-60, 20) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"请输入手机号" View:scr font:font14];
    
    valiteText=[LSFUtil addTextFieldView:CGRectMake(45, 65, SCREEN_WIDTH-170, 20) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"请输入验证码" View:scr font:font14];
    valiteText.keyboardType=UIKeyboardTypeNumberPad;
    
    valiteBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-110,57.5,100, 35) title:@"获取验证码" select:@selector(Action:) Tag:1 View:scr textColor:white Size:font14 background:MS_RGB(250,82,2)];
    valiteBtn.layer.cornerRadius=5;
    valiteBtn.layer.masksToBounds=YES;
    
    
    passwordText=[LSFUtil addTextFieldView:CGRectMake(45, 115, SCREEN_WIDTH-60, 20) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:self.viewType==2?@"新密码(6-20位)":@"请设置密码(6-20位)" View:scr font:font14];
    [passwordText setSecureTextEntry:YES];
    
    
    
    aginpassword=[LSFUtil addTextFieldView:CGRectMake(45, 165, SCREEN_WIDTH-60, 20) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:self.viewType==2?@"确认新密码(6-20位)":@"请设置密码(6-20位)" View:scr font:font14];
    [aginpassword setSecureTextEntry:YES];
    

    
    UIButton*zhuce=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(20, 230,SCREEN_WIDTH-40, 40) title:@"提交" select:@selector(Action:) Tag:2 View:scr textColor:white Size:font14 background:MS_RGB(250,82,2)];
    zhuce.layer.cornerRadius=5;
    zhuce.layer.masksToBounds=YES;
    
    
    
}

#pragma mark -定时器操作
-(void)getTime{
    
    _timestamp=60;
    [timer invalidate];
    timer=nil;
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}
-(void)timer:(NSTimer*)timerr{
    _timestamp--;
    
    if (_timestamp == 0) {
        [timer invalidate];
        timer = nil;
        [valiteBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        valiteBtn.userInteractionEnabled = YES;
        
    } else{
        
        [valiteBtn setTitle:[NSString stringWithFormat:@"验证码%.2zi",_timestamp] forState:UIControlStateNormal];
        valiteBtn.userInteractionEnabled = NO;
    }
}
-(void)Action:(UIButton*)btn{

    if(btn.tag==1){
    
        if(![LSFEasy validateMobile:usernameText.text]){
        
            [self showHint:@"请输入正确的手机号格式"];
            return;
            
        }
        
        [self showHudInView:self.view hint:@"加载中"];
        
        if(_viewType==4){
            Api * api =[[Api alloc] init:self tag:@"valite"];

        [api getCode:usernameText.text];
        }
        else{
            Api * api =[[Api alloc] init:self tag:@"valite"];

            [api getCodePassword:usernameText.text];
        
        }
    
    }

    if(btn.tag==2){
    
        if(![LSFEasy validateMobile:usernameText.text]){
            
            [self showHint:@"请输入正确的手机号格式"];
            return;
        }
    
        if(valiteText.text.length==0){
        
            [self showHint:@"验证码不能为空"];
            return;
        }
        
        if(passwordText.text.length==0||aginpassword.text.length==0){
        
            [self showHint:@"请设置密码(6-20位)"];
            return;
        
        }
    
        if(![passwordText.text isEqual:aginpassword.text]){
        
            [self showHint:@"2次输入得密码不一一致"];
            return;
        }
        
        
        
        [self showHudInView:self.view hint:@"加载中"];
        if(_viewType==4){
        
        Api * api =[[Api alloc] init:self tag:@"user_register"];

        [api user_register:usernameText.text password:passwordText.text yzm:valiteText.text yzm1:valiteText.text];
        
        }else{
        
        Api * api =[[Api alloc] init:self tag:@"resetPassword"];

        [api resetPassword:usernameText.text password:passwordText.text password1:aginpassword.text yzm:valiteText.text yzm1:valiteText.text];
        }
    
    }
    
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
    if([tag isEqualToString:@"resetPassword"]||[tag isEqualToString:@"user_register"]){
       
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
    
        [self getTime];
    }
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [timer invalidate];
    timer=nil;
}
@end
