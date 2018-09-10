//
//  WXDetailViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/12.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "WXDetailViewController.h"

@interface WXDetailViewController ()

@end

@implementation WXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"保修详细"];
    
    itemDic=[[NSDictionary alloc] init];
 
    
    
    scr=[LSFUtil add_scollview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH, ViewHeight) Tag:1 View:self.view co:CGSizeMake(0, SCREEN_HEIGHT)];
    
    [self showHudInView:self.view hint:@"加载中"];
    Api * api =[[Api alloc] init:self tag:@"findById"];
    [api findById:self.wxId];
    
    
    
   
}

-(void)Action:(UIButton*)btn{


    if(btn.tag==2){
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否撤销报修" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            [self showHudInView:self.view hint:@"加载中"];
            Api * api =[[Api alloc] init:self tag:@"deleteProperty"];
            [api deleteProperty:_wxId];
            
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    
    }
}
-(void)MainViewClass{


    [scr.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    
    NSArray * picAry=itemDic[@"propertyphotos"];

    
    UIView * view=[LSFUtil viewWithRect:CGRectMake(10, 20, SCREEN_WIDTH-20,(picAry.count>0)?380:240) view:scr backgroundColor:white];
    view.layer.cornerRadius=5;
    view.layer.masksToBounds=YES;
    
    
    NSArray * ary=[[NSArray alloc] initWithObjects:@"报修类别: ",@"业主保修时间: ",@"物业维修时间: ", nil];
    
    NSArray * ary1=[[NSArray alloc] initWithObjects:itemDic[@"propertytype"][@"name"],[self getTime:itemDic[@"date"]],[self getTime:itemDic[@"overdate"]], nil];
    
    for(int i=0;i<ary.count;i++){
    
        [LSFUtil labelName:[NSString stringWithFormat:@"%@ %@",ary[i],ary1[i]] fontSize:font14 rect:CGRectMake(10, 50*i, view.frame.size.width-20, 50) View:view Alignment:0 Color:gray Tag:1];
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 50+50*i, view.frame.size.width, 1) view:view];
    
    }

    [LSFUtil labelName:itemDic[@"content"] fontSize:font14 rect:CGRectMake(10, 170, view.frame.size.width-20, 60) View:view Alignment:0 Color:gray Tag:1];
    
    
    if(picAry.count!=0){
    
      UIScrollView*picScr=[LSFUtil add_scollview:CGRectMake(10,250, SCREEN_WIDTH-20,110) Tag:1 View:view co:CGSizeMake(picAry.count*100,110 )];
       
        for(int i=0;i<picAry.count;i++){
        
            NSDictionary * dic=picAry[i];
            
            UIImageView * img =[LSFUtil addSubviewImage:nil rect:CGRectMake(100*i,10, 90, 90) View:picScr Tag:1];
            
            NSString*url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=p",urlStr,dic[@"photourl"]];
            
            [img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
        }

    }
    
    
    NSInteger a =[itemDic[@"status"] integerValue];
    
    UIButton*loginBtn=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(30, 20+view.frame.size.height+30,SCREEN_WIDTH-60, 40) title:@"完成报修" select:@selector(Action:) Tag:1 View:a==1?scr:nil textColor:white Size:font14 background:MS_RGB(250,82,2)];
    loginBtn.layer.cornerRadius=5;
    loginBtn.layer.masksToBounds=YES;
    
    
    UIButton*loginBtn1=[self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(30,50+view.frame.size.height,SCREEN_WIDTH-60, 40) title:@"撤销报修" select:@selector(Action:) Tag:2 View:a==1?nil:scr textColor:MS_RGB(250,82,2) Size:font14 background:white];
    loginBtn1.layer.cornerRadius=5;
    loginBtn1.layer.masksToBounds=YES;
    loginBtn1.layer.borderWidth=1;
    loginBtn1.layer.borderColor=[MS_RGB(250,82,2) CGColor];
    
    
    scr.contentSize=CGSizeMake(0, 100+view.frame.size.height+TabbarHeight);
    
    
}
-(NSString*)getTime:(NSString*)time{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return  [LSFEasy isEmpty:time]?@"未处理":confromTimespStr;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    
}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    
    if([tag isEqualToString:@"deleteProperty"]){
    
        [self showHint:response[@"msg"]];
        self.completeBlockNone();
        [self.navigationController popViewControllerAnimated:YES];
    
    }else{
    itemDic=response[@"data"];
    [self MainViewClass];
    }

}

@end
