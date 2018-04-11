//
//  Mine_nickNameViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "Mine_nickNameViewController.h"

@interface Mine_nickNameViewController ()

@end

@implementation Mine_nickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"昵称"];
    
    
    [self addNavRightBtnWithTitle:@"保存"];
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, 50) view:self.view backgroundColor:white];

    
    nickNameText=[LSFUtil addTextFieldView:CGRectMake(20, 0, SCREEN_WIDTH-30, 50) Tag:1 textColor:black Alignment:0 Text:self.name placeholderStr:@"昵称(不能超过20个字)" View:view font:font14];
    
}

-(void)actNavRightBtn{

    if(nickNameText.text.length==0){
    
        [self showHint:@"昵称不能为空"];
        return;
    
    }
    if(nickNameText.text.length>20){
    
        [self showHint:@"昵称不能超过20个字"];
        return;
    }

    if([nickNameText.text isEqual:_name]){
    
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"changeRealName"];
    [api changeRealName:nickNameText.text];

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
        
    self.completeBlockNSString(response[@"data"][@"realname"]);
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
