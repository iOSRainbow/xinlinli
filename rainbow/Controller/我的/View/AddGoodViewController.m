
//
//  AddGoodViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/10.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "AddGoodViewController.h"

@interface AddGoodViewController ()

@end

@implementation AddGoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"填写地址"];
    
    scr=[LSFUtil add_scollview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view co:CGSizeMake(0, ViewHeight)];
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, 200) view:scr backgroundColor:white];
    
    NSArray * ary=[[NSArray alloc] initWithObjects:@"联系人:",@"手机号:",@"收货地址:",@"门牌号:", nil];
    
    for(int i=0;i<ary.count;i++){
    
        [LSFUtil labelName:ary[i] fontSize:font14 rect:CGRectMake(15, 50*i, 80, 50) View:view Alignment:0 Color:gray Tag:1];
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 50*i, SCREEN_WIDTH, 1) view:i==0?nil:view];
    
    }
    
    usernameText=[LSFUtil addTextFieldView:CGRectMake(100, 0,SCREEN_WIDTH-105, 50) Tag:1 textColor:gray Alignment:0 Text:nil placeholderStr:@"您的姓名" View:view font:font14];
    
    iphoneText=[LSFUtil addTextFieldView:CGRectMake(100, 50,SCREEN_WIDTH-105, 50) Tag:1 textColor:gray Alignment:0 Text:nil placeholderStr:@"您的联系电话" View:view font:font14];

    addressText=[LSFUtil addTextFieldView:CGRectMake(100, 100,SCREEN_WIDTH-105, 50) Tag:1 textColor:gray Alignment:0 Text:nil placeholderStr:@"收货地址(xx小区)" View:view font:font14];

    numText=[LSFUtil addTextFieldView:CGRectMake(100, 150,SCREEN_WIDTH-105, 50) Tag:1 textColor:gray Alignment:0 Text:nil placeholderStr:@"例:1号楼-101" View:view font:font14];


    
    UIButton*loginBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(40, 230,SCREEN_WIDTH-80, 40) title:@"提交" select:@selector(Action:) Tag:3 View:scr textColor:white Size:font14 background:MS_RGB(250,82,2)];
    loginBtn.layer.cornerRadius=5;
    loginBtn.layer.masksToBounds=YES;

    
}

-(void)Action:(UIButton*)btn{


    if(usernameText.text.length==0){
    
    
        [self showHint:@"您的姓名不能为空"];
        return;
    
    }
    
    if(![LSFEasy validateMobile:iphoneText.text]){
    
        [self showHint:@"手机格式不正确"];
        return;
        
    }
    if(addressText.text.length==0){
    
        [self showHint:@"收货地址不能为空"];
        return;
    
    }

    if(numText.text.length==0){
    
        [self showHint:@"门牌号不能为空"];
        return;
    
    
    }
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"gifPost"];
    [api gifPost:_gifId name:usernameText.text phone:iphoneText.text cell:numText.text address:addressText.text];
    
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
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
