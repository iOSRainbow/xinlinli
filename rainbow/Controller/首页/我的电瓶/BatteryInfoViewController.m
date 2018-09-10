//
//  BatteryInfoViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/9/4.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "BatteryInfoViewController.h"

@interface BatteryInfoViewController ()

@end

@implementation BatteryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"设备信息"];
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, 7+NavigationHeight, SCREEN_WIDTH, 85) view:self.view backgroundColor:white];
    
    
    [LSFUtil labelName:[NSString stringWithFormat:@"电瓶类型：%@",_dict[@"parameter"]] fontSize:font14 rect:CGRectMake(10, 10, SCREEN_WIDTH-15, 20) View:view Alignment:0 Color:black Tag:1];

    [LSFUtil labelName:[NSString stringWithFormat:@"租期：%@",_dict[@"time"]] fontSize:font14 rect:CGRectMake(10, 35, SCREEN_WIDTH-15, 40) View:view Alignment:0 Color:black Tag:1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
