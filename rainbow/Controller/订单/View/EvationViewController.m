
//
//  EvationViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/6/21.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "EvationViewController.h"

@interface EvationViewController ()

@end

@implementation EvationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"评价"];
    state=@"满意";
    
    [self mainView];
}

-(void)mainView{

    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, NavigationHeight, SCREEN_WIDTH,180) view:self.view backgroundColor:white];
    
    [LSFUtil labelName:_Dic[@"goodsname"] fontSize:font14 rect:CGRectMake(10,0,SCREEN_WIDTH-80,50) View:view Alignment:0 Color:black Tag:1];

    [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(10, 50, SCREEN_WIDTH, 1) view:view];
    
    lptext=[LSFUtil addTextView:CGRectMake(10, 60, view.frame.size.width-20, 100) Tag:1 textColor:gray Alignment:0 Text:nil placeholderStr:@"请输入评论" View:view font:font14];
    lptext.layer.cornerRadius=2;
    lptext.layer.masksToBounds=YES;
    lptext.layer.borderWidth=1;
    lptext.layer.borderColor=[ColorHUI CGColor];
    
    
    btn1= [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0,200+NavigationHeight,SCREEN_WIDTH/3, 30) title:nil select:@selector(Action:) Tag:1 View:self.view textColor:white Size:font14 background:nil];
    [btn1 setAttributedTitle:[LSFUtil ButtonAttriSring:@" 满意" color:black image:@"lsf28" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];
    
    btn2= [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH/3,200+NavigationHeight,SCREEN_WIDTH/3, 30) title:nil select:@selector(Action:) Tag:2 View:self.view textColor:white Size:font14 background:nil];
    [btn2 setAttributedTitle:[LSFUtil ButtonAttriSring:@" 一般" color:black image:@"lsf44" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];

    
    btn3= [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake((SCREEN_WIDTH/3)*2, 200+NavigationHeight,SCREEN_WIDTH/3, 30) title:nil select:@selector(Action:) Tag:3 View:self.view textColor:white Size:font14 background:nil];
    [btn3 setAttributedTitle:[LSFUtil ButtonAttriSring:@" 不满意" color:black image:@"lsf44" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];

    
    
    UIButton*loginBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(30, 250+NavigationHeight,SCREEN_WIDTH-60, 40) title:@"提交评价" select:@selector(CommitAction:) Tag:3 View:self.view textColor:white Size:font14 background:MS_RGB(250,82,2)];
    loginBtn.layer.cornerRadius=3;
    loginBtn.layer.masksToBounds=YES;

}

-(void)Action:(UIButton *)btn{

    
    if(btn.tag==1){
        
        [btn1 setAttributedTitle:[LSFUtil ButtonAttriSring:@" 满意" color:black image:@"lsf28" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];

        [btn2 setAttributedTitle:[LSFUtil ButtonAttriSring:@" 一般" color:black image:@"lsf44" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];
        
        [btn3 setAttributedTitle:[LSFUtil ButtonAttriSring:@" 不满意" color:black image:@"lsf44" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];

        state=@"满意";

    
    }else if (btn.tag==2){
    
        [btn1 setAttributedTitle:[LSFUtil ButtonAttriSring:@" 满意" color:black image:@"lsf44" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];
        
        [btn2 setAttributedTitle:[LSFUtil ButtonAttriSring:@" 一般" color:black image:@"lsf28" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];
        
        [btn3 setAttributedTitle:[LSFUtil ButtonAttriSring:@" 不满意" color:black image:@"lsf44" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];
        
        state=@"一般";

    
    }else{
    
    
        [btn1 setAttributedTitle:[LSFUtil ButtonAttriSring:@" 满意" color:black image:@"lsf44" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];
        
        [btn2 setAttributedTitle:[LSFUtil ButtonAttriSring:@" 一般" color:black image:@"lsf44" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];
        
        [btn3 setAttributedTitle:[LSFUtil ButtonAttriSring:@" 不满意" color:black image:@"lsf28" type:1 rect:CGRectMake(0, -5, 20, 20)] forState:normal];
        
        
        state=@"不满意";

    
    }


}

-(void)CommitAction:(UIButton*)btn{

    if(lptext.text.length==0){
    
        [self showHint:@"请输入评价内容"];
        return;
    }

    [self showHudInView:self.view hint:@"加载中"];
    Api *  api =[[Api alloc] init:self tag:@"comment_addComment"];
    [api comment_addComment:_Dic[@"goodscateId"] content:lptext.text orderId:_Dic[@"id"] state:state];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Api回调
- (void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    NSLog(@"apiError=%@",message);
    [self showHint:message];
}

- (void)Sucess:(id)response tag:(NSString*)tag
{
    [self hideHud];

    [self showHint:response[@"msg"]];
    
    self.completeBlockNone();
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
