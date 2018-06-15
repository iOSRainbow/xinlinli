//
//  AddLockViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/19.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "AddLockViewController.h"
#import "ScanViewController.h"

@interface AddLockViewController ()

@end

@implementation AddLockViewController


-(void)actNavRightBtn{

    ScanViewController * scan =[[ScanViewController alloc] init];
    scan.completeBlockNSString=^(NSString *str){
    
        titleText.text=str;
    };
    [self.navigationController pushViewController:scan animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"车位添加"];
    
    [self addNavRightBtnWithTitle:@"扫一扫"];
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight, SCREEN_WIDTH,155) view:self.view backgroundColor:white];
    
    [LSFUtil labelName:@"注:请填写正确得链接码,否则将无法使用您的车位锁" fontSize:font12 rect:CGRectMake(10,10,SCREEN_WIDTH-20, 40) View:view Alignment:0 Color:MS_RGB(250,82,2) Tag:1];

    
    [LSFUtil labelName:@"链接码:" fontSize:font14 rect:CGRectMake(10,55,100, 50) View:view Alignment:0 Color:black Tag:1];
    
    titleText=[LSFUtil addTextFieldView:CGRectMake(110,55, SCREEN_WIDTH-120, 50) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"请输入链接码或直接扫一扫" View:view font:font14];


    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 105, SCREEN_WIDTH, 1) view:view];
    
    [LSFUtil labelName:@"使用名称:" fontSize:font14 rect:CGRectMake(10,105,100, 50) View:view Alignment:0 Color:black Tag:1];
    
    
    nameText=[LSFUtil addTextFieldView:CGRectMake(110,105, SCREEN_WIDTH-120, 50) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"请输入使用名称" View:view font:font14];
    
    
    UIButton*loginBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(20, 270,SCREEN_WIDTH-40, 40) title:@"提交" select:@selector(Action:) Tag:3 View:self.view textColor:white Size:font14 background:MS_RGB(250,82,2)];
    loginBtn.layer.cornerRadius=5;
    loginBtn.layer.masksToBounds=YES;
    
    
}

-(void)Action:(UIButton*)btn{

    if(titleText.text.length==0){
    
        [self showHint:@"请输入正确的链接码"];
        return;
    }
    if(nameText.text.length==0){
    
        [self showHint:@"使用名称不能为空"];
        return;
    }

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    NSString *date= [dateFormatter stringFromDate:[NSDate date]];
    NSDictionary * dic=@{@"name":nameText.text,@"phone":UserName,@"time":date,@"password":@"000000",@"info":titleText.text};
    
    
    NSArray *array=[myUserDefaults objectForKey:@"data_bus"];
    NSMutableArray* historyArray=[NSMutableArray array];

    if (array.count!=0) {
        historyArray=[array mutableCopy];
    }
  
    [historyArray insertObject:dic atIndex:0];
    
    [myUserDefaults setObject: historyArray forKey:@"data_bus"];
    
    [myUserDefaults synchronize];
   
    self.completeBlockNSDictionary(dic);
    [self.navigationController popViewControllerAnimated:YES];

}
   
   
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
