//
//  MineAboutViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "MineAboutViewController.h"
#import "MineHtmlViewController.h"

@interface MineAboutViewController ()

@end

@implementation MineAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"关于我们"];
    
    
    UIImageView * img= [LSFUtil addSubviewImage:@"lsf29" rect:CGRectMake((SCREEN_WIDTH-60)/2, NavigationHeight+10, 60, 60) View:self.view Tag:1];
    img.layer.cornerRadius=5;
    img.layer.masksToBounds=YES;
    
    [LSFUtil labelName:@"智慧社区管理专家" fontSize:font14 rect:CGRectMake(0, NavigationHeight+75, SCREEN_WIDTH, 20) View:self.view Alignment:1 Color:gray Tag:1];
    
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight+125, SCREEN_WIDTH, 150) view:self.view backgroundColor:white];
    
    NSArray * ary =[[NSArray alloc] initWithObjects:@"公司简介",@"官方网站:",@"客服电话:", nil];
    for(int i=0;i<ary.count;i++){
    
        [LSFUtil labelName:ary[i] fontSize:font14 rect:CGRectMake(10, 50*i, 100, 50) View:view Alignment:0 Color:black Tag:1];
        
        [LSFUtil addSubviewImage:@"lsf27" rect:CGRectMake(SCREEN_WIDTH-30,50*i+15, 20, 20) View:i==0?view:nil Tag:1];
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(10, 50*i, SCREEN_WIDTH, 1) view:i==0?nil:view];
    
        
        [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 50*i, SCREEN_WIDTH, 50) title:nil select:@selector(Action:) Tag:i+1 View:view textColor:nil Size:nil background:nil];
    
    }
    
    
}

-(void)Action:(UIButton *)btn{

    if(btn.tag==1){
    
        MineHtmlViewController * html=[[MineHtmlViewController alloc] init];
        [self.navigationController pushViewController:html animated:YES];
    
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
