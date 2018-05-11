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
    [self setNavTitle:@"活动"];
    
   UIWebView* webview=[[UIWebView alloc] initWithFrame:CGRectMake(0,NavigationHeight, SCREEN_WIDTH, ViewHeight)];
    [webview sizeToFit];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]]];
    [self.view addSubview:webview];

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
