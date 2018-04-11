//
//  Mine_add_accountViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "Mine_add_accountViewController.h"

@interface Mine_add_accountViewController ()

@end

@implementation Mine_add_accountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"添加子账户"];
    
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, 150) view:self.view backgroundColor:white];
    
    [LSFUtil labelName:@"子账户名" fontSize:font14 rect:CGRectMake(10, 0, 100, 50) View:view Alignment:0 Color:black Tag:1];
    [LSFUtil labelName:@"验证码" fontSize:font14 rect:CGRectMake(10, 50, 100, 50) View:view Alignment:0 Color:black Tag:1];
    [LSFUtil labelName:@"子账户密码" fontSize:font14 rect:CGRectMake(10, 100, 100, 50) View:view Alignment:0 Color:black Tag:1];
    
    usernameText=[LSFUtil addTextFieldView:CGRectMake(120, 0, SCREEN_WIDTH-130, 50) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"请输入子账户名" View:view font:font14];
    
    valiteText=[LSFUtil addTextFieldView:CGRectMake(120, 50, SCREEN_WIDTH-230, 50) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"请输入验证码" View:view font:font14];
    valiteText.keyboardType=UIKeyboardTypeNumberPad;
    
    valiteBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-110,57.5,100, 35) title:@"获取验证码" select:@selector(Action:) Tag:1 View:view textColor:white Size:font14 background:MS_RGB(250,82,2)];
    valiteBtn.layer.cornerRadius=5;
    valiteBtn.layer.masksToBounds=YES;
    
    passwordText=[LSFUtil addTextFieldView:CGRectMake(120, 100, SCREEN_WIDTH-130, 50) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"请输入子账户密码" View:view font:font14];

    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 50, SCREEN_WIDTH, 1) view:view];
    
    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 100, SCREEN_WIDTH, 1) view:view];

    
    
    UIButton*add=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(20,NavigationHeight+180,SCREEN_WIDTH-40, 40) title:@"完成" select:@selector(Action:) Tag:3 View:self.view textColor:white Size:font14 background:MS_RGB(250,82,2)];
    add.layer.cornerRadius=5;
    add.layer.masksToBounds=YES;

    
}
-(void)Action:(UIButton*)btn{

    if(btn.tag==1){
    
    
        if(![LSFEasy validateMobile:usernameText.text]){
            
            [self showHint:@"手机格式不正确"];
            return;
        }
        
        [self showHudInView:self.view hint:@"加载中"];
        Api * api =[[Api alloc] init:self tag:@"getCode"];
        [api getCode:usernameText.text];
    
    }else{
    
    if(![LSFEasy validateMobile:usernameText.text]){
    
        [self showHint:@"手机格式不正确"];
        return;
    }

    if(passwordText.text.length==0){
    
        [self showHint:@"子账户密码(6-20位)"];
        return;
    
    }
    
    if(valiteText.text.length==0){
    
        [self showHint:@"请输入验证码"];
        return;
    }
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc]init:self tag:@"insertSubUser"];
    [api insertSubUser:usernameText.text password:passwordText.text yzm:valiteText.text yzm1:valiteText.text];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [timer invalidate];
    timer=nil;
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

-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    
    [self showHint:response[@"msg"]];
    
    if([tag isEqualToString:@"insertSubUser"]){
    
        self.completeBlockNone();
        [self.navigationController popViewControllerAnimated:YES];

    }
    if([tag isEqualToString:@"getCode"]){
       
        [self getTime];
    
    }
    
    
}

@end
