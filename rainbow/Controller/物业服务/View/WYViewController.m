//
//  WYViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "WYViewController.h"

@interface WYViewController ()

@end

@implementation WYViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //
    Api * api =[[Api alloc] init:self tag:@"app_user_getTime"];
    [api app_user_getTime];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"物业服务"];
    itemDic=[[NSDictionary alloc] init];
    scr=[LSFUtil add_scollview:CGRectMake(0, NavigationHeight, SCREEN_WIDTH,ViewHeight-TabbarStautsHeight) Tag:1 View:self.view co:CGSizeMake(0, SCREEN_HEIGHT-64-50)];

    scr.backgroundColor=white;
    
}
-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    
    [scr.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    if([LSFEasy isEmpty:CellId]){
    
       emptyView=[LSFUtil addEmptyView:scr.frame view:scr title:@"请完善地址信息,否则无法使用"];
   
    }
    else{
    
        Api * api =[[Api alloc] init:self tag:@"findCellInfo"];
        [api findCellInfo:[LSFEasy isEmpty:CellId]?@"":CellId];
    
    }

}

-(void)MainViewClass{

  
    
    UIView * view =[LSFUtil viewWithRect:CGRectMake(0, 0, SCREEN_WIDTH, 80) view:scr backgroundColor:nil];
    
    
    
    UIImageView*img=[LSFUtil addSubviewImage:nil rect:CGRectMake(10, 10, 60, 60) View:view Tag:1];
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=c",urlStr,itemDic[@"photourl"]]] placeholderImage:[UIImage imageNamed:@"lsf64"]];
    img.layer.cornerRadius=3;
    img.layer.masksToBounds=YES;
    
    [LSFUtil labelName:itemDic[@"xccontent"] fontSize:font14 rect:CGRectMake(90, 10, SCREEN_WIDTH-100, 60) View:view Alignment:0 Color:gray Tag:1];
    
    
    [self serviceContent:view.frame.size.height+20];

}

-(void)serviceContent:(CGFloat)hy{

    UIView * view =[LSFUtil viewWithRect:CGRectMake(0,hy, SCREEN_WIDTH, 250) view:scr backgroundColor:nil];
    
    [LSFUtil setXianTiao:MS_RGB(250,82,2) rect:CGRectMake(20, 10,SCREEN_WIDTH/3-20, 2) view:view];

    UILabel *lb= [LSFUtil labelName:@"服务内容" fontSize:font16 rect:CGRectMake(SCREEN_WIDTH/3+(SCREEN_WIDTH/3-80)/2, 0,80, 22) View:view Alignment:1 Color:white Tag:1];
    lb.backgroundColor=MS_RGB(250,82,2);
    
    [LSFUtil setXianTiao:MS_RGB(250,82,2) rect:CGRectMake((SCREEN_WIDTH/3)*2, 10,SCREEN_WIDTH/3-20, 2) view:view];

    
    NSArray * ary =[[NSArray alloc] initWithObjects:itemDic[@"fwcontenta"],itemDic[@"fwcontentb"],itemDic[@"fwcontentc"],itemDic[@"fwcontentd"], nil];

    for(int i=0;i<ary.count;i++){
    
        //MS_RGB(250,82,2)
        UILabel*lb= [LSFUtil setXianTiao:MS_RGB(250,82,2) rect:CGRectMake(10, 50*i+35/2+40, 15,15) view:view];
        lb.layer.cornerRadius=3;
        lb.layer.masksToBounds=YES;
        
        [LSFUtil labelName:ary[i]  fontSize:font14 rect:CGRectMake(40, 40+50*i, SCREEN_WIDTH-50, 50) View:view Alignment:0 Color:gray Tag:1];
        
        [LSFUtil setXianTiao:ColorHUI rect:CGRectMake(0, 40+50*i, SCREEN_WIDTH, 1) view:i==0?nil:view];
    
    }

    [self ServicePhone:view.frame.size.height+20+hy];
}


-(void)ServicePhone:(CGFloat)hy{

    UIView * view =[LSFUtil viewWithRect:CGRectMake(0,hy, SCREEN_WIDTH, 140) view:scr backgroundColor:nil];
    
    scr.contentSize=CGSizeMake(0, view.frame.size.height+hy+20);

    [LSFUtil setXianTiao:MS_RGB(250,82,2) rect:CGRectMake(20, 10,SCREEN_WIDTH/3-20, 2) view:view];
    
    UILabel *lb= [LSFUtil labelName:@"服务电话" fontSize:font16 rect:CGRectMake(SCREEN_WIDTH/3+(SCREEN_WIDTH/3-80)/2, 0,80, 22) View:view Alignment:1 Color:white Tag:1];
    lb.backgroundColor=MS_RGB(250,82,2);
    
    [LSFUtil setXianTiao:MS_RGB(250,82,2) rect:CGRectMake((SCREEN_WIDTH/3)*2, 10,SCREEN_WIDTH/3-20, 2) view:view];
    
    
    UILabel*lb1= [LSFUtil setXianTiao:MS_RGB(250,82,2) rect:CGRectMake(10,5/2+40, 15,15) view:view];
    lb1.layer.cornerRadius=3;
    lb1.layer.masksToBounds=YES;
    
    [LSFUtil labelName:[NSString stringWithFormat:@"监督服务电话 %@",itemDic[@"telephone"]] fontSize:font16 rect:CGRectMake(40, 40, SCREEN_WIDTH-50, 40) View:view Alignment:0 Color:gray Tag:1];
    
    
    [LSFUtil labelName:[NSString stringWithFormat:@"小区名: %@",itemDic[@"cellName"]] fontSize:font16 rect:CGRectMake(0, 90, SCREEN_WIDTH-10, 40) View:view Alignment:2 Color:MS_RGB(250,82,2) Tag:1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)Failed:(NSString*)message tag:(NSString*)tag
{
    [self hideHud];
    [self showHint:message];
    if([tag isEqualToString:@"findCellInfo"]){

        [emptyView removeFromSuperview];
        emptyView=[LSFUtil addEmptyView:scr.frame view:scr title:message];

    }

}

-(void)Sucess:(id)response tag:(NSString*)tag
{
    
    [self hideHud];
    
    if([tag isEqualToString:@"findCellInfo"]){
    
        
        if(![response[@"data"] isKindOfClass:[NSString class]]){
            
            itemDic=response[@"data"];
            [self MainViewClass];
        }
    }
 else{
    
        NSDictionary * dic=response[@"data"];
        if(![dic[@"logtime"] isEqual:logtime]){
            
            
            UIAlertView * alret=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的账号已在其他手机登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alret show];
            [myUserDefaults setObject:@"" forKey:@"token"];
            [myUserDefaults synchronize];
            [[AppDelegate sharedAppDelegate] StartMain];
        }
        
    
    }
   
}

/*
 
 data =     {
 cellId = "2e6fe2a8-12d7-4c03-9b44-dad048118efd";
 cellName = "\U65b0\U90bb\U91cc";
 fwcontenta = "\U7269\U4e1a\U670d\U52a1";
 fwcontentb = "\U7269\U4e1a\U670d\U52a1";
 fwcontentc = "\U7269\U4e1a\U670d\U52a1";
 fwcontentd = "\U7269\U4e1a\U670d\U52a1";
 id = 45;
 list = "<null>";
 photourl = "f44c1695-610a-429b-bd0b-04dd5094a8b5.jpg";
 telephone = 13351252312;
 xccontent = "\U6682\U65e0\U4fe1\U606f";
 };
 msg = "\U8fd4\U56de\U6210\U529f";
 status = success;
 }
 */
@end
