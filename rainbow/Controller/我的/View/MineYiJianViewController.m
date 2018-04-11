//
//  MineYiJianViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "MineYiJianViewController.h"

@interface MineYiJianViewController ()

@end

@implementation MineYiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"意见反馈"];
    
    [self addNavRightBtnWithTitle:@"确定"];
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, 200) view:self.view backgroundColor:white];
    
    Lptextview=[LSFUtil addTextView:CGRectMake(10, 10, SCREEN_WIDTH-20, 180) Tag:1 textColor:black Alignment:0 Text:nil placeholderStr:@"请留下您宝贵的建议或意见..." View:view font:font14];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)actNavRightBtn{

    if(Lptextview.text.length==0){
    
        [self showHint:@"请留下您宝贵的建议或意见..."];
        return;
    
    }

    
    [self.navigationController popViewControllerAnimated:YES];

}
@end
