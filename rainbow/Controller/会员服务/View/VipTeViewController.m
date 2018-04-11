//
//  VipTeViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/6/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "VipTeViewController.h"
#import "VipPayViewController.h"
#define Rate 884/640
#define TopScrollHeigt SCREEN_WIDTH*Rate

@interface VipTeViewController ()

@end

@implementation VipTeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"会员特权"];
    scr=[LSFUtil add_scollview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH,ViewHeight) Tag:1 View:self.view co:CGSizeMake(0, ViewHeight)];
    
    [self mainviewClass];

}

-(void)mainviewClass{
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, 130) view:scr backgroundColor:white];
        
    levelLb=[LSFUtil labelName:_dic[@"currenLevel"] fontSize:font16 rect:CGRectMake(10, 10, 200, 20) View:view Alignment:0 Color:black Tag:1];
        
    vipInfoLb=[LSFUtil labelName:nil fontSize:font14 rect:CGRectMake(10, 35, SCREEN_WIDTH-20, 40) View:view Alignment:0 Color:gray Tag:1];
        
    
    UIButton*loginBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH-100,90,80, 30) title:@"点击充值" select:@selector(PayAction) Tag:3 View:view textColor:white Size:font14 background:MS_RGB(250,82,2)];
    loginBtn.layer.cornerRadius=2;
    loginBtn.layer.masksToBounds=YES;
        
        
    if([_dic[@"type"] integerValue]==1){
            
            vipInfoLb.text=_dic[@"nextLevel"];
            
        }
    else
        {
            
            [vipInfoLb setAttributedText:[self AttributedString:[NSString stringWithFormat:@"已累计充值%@元,还差%@元升级为%@",self.Amount,_dic[@"money"],_dic[@"nextLevel"]] color:Red title1:self.Amount title2:_dic[@"money"]]];
        }
    
}
-(void)PayAction{

    VipPayViewController * pay =[[VipPayViewController alloc] init];
    [self.navigationController pushViewController:pay animated:YES];
    
}
-(NSMutableAttributedString*)AttributedString:(NSString*)title color:(UIColor*)color title1:(NSString*)title1 title2:(NSString*)title2 {
    
    
    NSMutableAttributedString *attri =[[NSMutableAttributedString alloc] initWithString:title];
    
    
    [attri addAttribute:NSForegroundColorAttributeName
     
                  value:color
     
                  range:NSMakeRange(5, title1.length)];
    
    [attri addAttribute:NSForegroundColorAttributeName
     
                  value:color
     
                  range:NSMakeRange(9+title1.length, title2.length)];
    
    return attri;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
