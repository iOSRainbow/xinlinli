//
//  AddDoorCardViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/5/11.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "AddDoorCardViewController.h"
#import "DoorCardRecordViewController.h"
@interface AddDoorCardViewController ()

@end

@implementation AddDoorCardViewController


-(void)actNavRightBtn{
    
    
    DoorCardRecordViewController * door =[[DoorCardRecordViewController alloc] init];
    
    [self.navigationController pushViewController:door animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"门禁卡绑定"];
    [self addNavRightBtnWithTitle:@"绑定记录" rect:CGRectMake(SCREEN_WIDTH-80, StatusHeight, 80, 44)];
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, 200) view:self.view backgroundColor:white];
    
    UIView * textView =[LSFUtil viewWithRect:CGRectMake(25, 25, SCREEN_WIDTH-50, 40) view:view backgroundColor:white];
    textView.layer.cornerRadius=4;
    textView.layer.masksToBounds=YES;
    textView.layer.borderWidth=1;
    textView.layer.borderColor=ColorHUI.CGColor;
    
    cardText=[LSFUtil addTextFieldView:CGRectMake(10, 0, textView.frame.size.width-15, 40) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"请输入门禁卡编号 例如：2018000001" View:textView font:font14];
    
    
    UIButton * btn =[LSFUtil buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(30, view.frame.size.height-60, SCREEN_WIDTH-60, 35) title:@"绑定" Tag:1 View:view textColor:white Size:font14];
    btn.backgroundColor=orange;
    btn.layer.cornerRadius=5;
    btn.layer.masksToBounds=YES;
    [btn addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)Action{
    
    [cardText resignFirstResponder];
    
    if(cardText.text.length==0){
        
        [self showHint:@"请输入门禁卡编号"];
        return;
    }
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"usercard_add"];
    [api usercard_add:cardText.text];
    
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
    [self showHint:@"绑定成功"];
    cardText.text=@"";
}


@end
