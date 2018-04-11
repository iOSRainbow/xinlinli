//
//  FailViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/15.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "FailViewController.h"

@interface FailViewController ()

@end

@implementation FailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"敬请期待"];
    self.view.backgroundColor=white;
    [LSFUtil addSubviewImage:@"lsf65" rect:CGRectMake(0,NavigationHeight+60,SCREEN_WIDTH, SCREEN_WIDTH/2) View:self.view Tag:1];
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
