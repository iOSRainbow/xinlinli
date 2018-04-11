//
//  Mine_birthViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "Mine_birthViewController.h"

@interface Mine_birthViewController ()

@end

@implementation Mine_birthViewController


-(void)actNavRightBtn{

    if([birthLable.text isEqualToString:@"未设置"]){
    
        [self showHint:@"请设置您的生日日期"];
        return;
    
    }
    if([[NSDate date] compare:[datePicker date]]==-1){
        
        [self showHint:@"当天之后的日期不可选"];
        return;
    }
    if([birthLable.text isEqual:_birthStr]){
    
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }

    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"changeBirthday"];
    [api changeBirthday:birthLable.text];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"生日"];
    
    [self addNavRightBtnWithTitle:@"保存"];

    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, 50) view:self.view backgroundColor:white];

    birthLable=[LSFUtil labelName:self.birthStr fontSize:font14 rect:CGRectMake(20, 0, SCREEN_WIDTH-40, 50) View:view Alignment:0 Color:black Tag:1];
    
    
    [self allocDateView];

}

-(void)allocDateView
{
    
    self.DatePickerView=[[UIView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-200, self.view.frame.size.width, 200)];
    self.DatePickerView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.DatePickerView];
    
    datePicker  = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 200)];
    datePicker.backgroundColor=[UIColor clearColor];
    [datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最小时间（此处为当前时间）
    // 设置UIDatePicker的显示模式
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    // 当值发生改变的时候调用的方法
    [datePicker addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.DatePickerView  addSubview:datePicker];
    
}
-(void)datePickerValueChanged
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
   
    birthLable.text = [dateFormatter stringFromDate:[datePicker date]];
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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[response[@"data"][@"birthday"] integerValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    self.completeBlockNSString(confromTimespStr);
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
