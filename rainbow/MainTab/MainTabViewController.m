//
//  MainTabViewController.m
//  deyingSoft
//
//  Created by 李世飞 on 16/1/22.
//  Copyright © 2016年 李世飞. All rights reserved.
//

#import "MainTabViewController.h"

#import "HomeViewController.h"
#import "VipViewController.h"
#import "JZViewController.h"
#import "MineViewController.h"
#import "WYViewController.h"
#import "ScanViewController.h"

#import "CommonNavtionController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController




- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBar.translucent = NO;
        [self addChildViewController];
        
    }
    return self;
}
-(void)addChildViewController{
    
    [self setViewControllers:@[[self WYVC],[self JZVC],[self HomeVC],[self VipVC],[self MineVC]] animated:YES];
    
    
}
-(CommonNavtionController*)WYVC{
    
    WYViewController *wyVC = [[WYViewController alloc]init];
    
    CommonNavtionController *nav = [[CommonNavtionController alloc]initWithRootViewController:wyVC];
    nav.navigationBarHidden=YES;
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"物业服务" image:[UIImage imageNamed:@"lsf8"] tag:0];
    item.selectedImage = [[UIImage imageNamed:@"lsf9"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *normalText = [NSMutableDictionary dictionary];
    normalText[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalText forState:UIControlStateNormal];
    
    //选中状态
    NSMutableDictionary *selectedText = [NSMutableDictionary dictionary];
    selectedText[NSForegroundColorAttributeName] = MS_RGB(250,82,2);
    [item setTitleTextAttributes:selectedText forState:UIControlStateSelected];
    
    wyVC.tabBarItem = item;
    
    return nav;
}
-(CommonNavtionController*)JZVC{
    
    JZViewController *jzVC = [[JZViewController alloc]init];
    
    CommonNavtionController *nav = [[CommonNavtionController alloc]initWithRootViewController:jzVC];
    nav.navigationBarHidden=YES;
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"居家商城" image:[UIImage imageNamed:@"lsf10"] tag:1];
    item.selectedImage = [[UIImage imageNamed:@"lsf11"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *normalText = [NSMutableDictionary dictionary];
    normalText[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalText forState:UIControlStateNormal];
    
    //选中状态
    NSMutableDictionary *selectedText = [NSMutableDictionary dictionary];
    selectedText[NSForegroundColorAttributeName] = MS_RGB(250,82,2);
    [item setTitleTextAttributes:selectedText forState:UIControlStateSelected];
    
    jzVC.tabBarItem = item;
    
    return nav;
}
-(CommonNavtionController*)HomeVC{
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    
    CommonNavtionController *nav = [[CommonNavtionController alloc]initWithRootViewController:homeVC];
    nav.navigationBarHidden=YES;
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"lsf12"] tag:2];
    item.selectedImage = [[UIImage imageNamed:@"lsf13"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *normalText = [NSMutableDictionary dictionary];
    normalText[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalText forState:UIControlStateNormal];
    
    //选中状态
    NSMutableDictionary *selectedText = [NSMutableDictionary dictionary];
    selectedText[NSForegroundColorAttributeName] =MS_RGB(250,82,2);
    [item setTitleTextAttributes:selectedText forState:UIControlStateSelected];
    
    homeVC.tabBarItem = item;
    
    return nav;
}

-(CommonNavtionController*)VipVC{
    
    ScanViewController *scan = [[ScanViewController alloc]init];
    scan.type=1;
    
    CommonNavtionController *nav = [[CommonNavtionController alloc]initWithRootViewController:scan];
    nav.navigationBarHidden=YES;
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"门禁" image:[UIImage imageNamed:@"lsf118"] tag:3];
    item.selectedImage = [[UIImage imageNamed:@"lsf119"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *normalText = [NSMutableDictionary dictionary];
    normalText[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalText forState:UIControlStateNormal];
    
    //选中状态
    NSMutableDictionary *selectedText = [NSMutableDictionary dictionary];
    selectedText[NSForegroundColorAttributeName] = MS_RGB(250,82,2);
    [item setTitleTextAttributes:selectedText forState:UIControlStateSelected];
    
    scan.tabBarItem = item;
    
    return nav;
}


-(CommonNavtionController*)MineVC{
    
    MineViewController *mineVC = [[MineViewController alloc]init];
    
    CommonNavtionController *nav = [[CommonNavtionController alloc]initWithRootViewController:mineVC];
    nav.navigationBarHidden=YES;
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"lsf16"] tag:4];
    item.selectedImage = [[UIImage imageNamed:@"lsf17"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *normalText = [NSMutableDictionary dictionary];
    normalText[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalText forState:UIControlStateNormal];
    
    //选中状态
    NSMutableDictionary *selectedText = [NSMutableDictionary dictionary];
    selectedText[NSForegroundColorAttributeName] = MS_RGB(250,82,2);
    [item setTitleTextAttributes:selectedText forState:UIControlStateSelected];
    
    mineVC.tabBarItem = item;
    
    return nav;
}
- (void)viewDidLoad {
    [super viewDidLoad];    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
