//
//  RuleViewController.m
//  rainbow
//
//  Created by 李世飞 on 2018/1/10.
//  Copyright © 2018年 李世飞. All rights reserved.
//

#import "RuleViewController.h"

@interface RuleViewController ()

@end

@implementation RuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"活动规则"];
    
    textview=[[UITextView alloc] initWithFrame:CGRectMake(0,NavigationHeight, self.view.frame.size.width, ViewHeight)];
    textview.textColor=[UIColor grayColor];
    textview.editable=NO;
    
    NSString * str =@"活动时间：2018年1月18日-28日，共10天\n活动规则：活动期间内，通过新邻里手机客户端参与抽奖的用户，均视为成功参与此次活动；每个用户只可参与一次。\n活动奖励：成功参与此次活动的用户，均可获得抽取所得相对应的商品。\n奖品发放：交易完成后，3个工作日内联系参与用户\n次活动最终解释权归新邻里所有。";
    textview.text=str;
    textview.font=[UIFont systemFontOfSize:14.0f];
    [self.view addSubview:textview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
