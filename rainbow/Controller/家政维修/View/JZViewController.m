//
//  JZViewController.m
//  rainbow
//
//  Created by 李世飞 on 17/5/8.
//  Copyright © 2017年 李世飞. All rights reserved.
//

#import "JZViewController.h"
#import "JZListViewController.h"
#import "JZDetailViewController.h"
#import "OrderListViewController.h"

#define Rate 320/640
#define TopScrollHeigt SCREEN_WIDTH*Rate

#define Rate1 260/640
#define TopScrollHeigt1 SCREEN_WIDTH*Rate1


#define Rate2 283/640
#define TopScrollHeigt2 SCREEN_WIDTH*Rate2

@interface JZViewController ()

@end

@implementation JZViewController



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //
    Api * api =[[Api alloc] init:self tag:@"app_user_getTime"];
    [api app_user_getTime];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    dataArray=[[NSMutableArray alloc] init];
    Jdarray=[[NSMutableArray alloc] init];
    Jzarray=[[NSMutableArray alloc] init];
    
    scr=[LSFUtil add_scollview:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabbarStautsHeight) Tag:1 View:self.view co:CGSizeMake(0, 2000)];
    scr.backgroundColor=white;
    
    
    [LSFUtil addSubviewImage:@"lsf37" rect:CGRectMake(0,0, SCREEN_WIDTH, TopScrollHeigt) View:scr Tag:1];
    
    
    NSMutableArray * ary=[[NSMutableArray alloc] initWithObjects:@"室内环保",@"家政服务",@"家电清洗",@"居家服务",nil];
    
    NSArray * imgAry=@[@"lsf30",@"lsf31",@"lsf32",@"lsf114"];
    
    
    for(int i=0;i<ary.count;i++){
    
        
        NSInteger index = i%4;
        NSInteger page = i/4;
        
        UIView * view =[LSFUtil viewWithRect:CGRectMake((SCREEN_WIDTH/4)*index, TopScrollHeigt+page*90, SCREEN_WIDTH/4, 90) view:scr backgroundColor:white];
        
        
        [LSFUtil addSubviewImage:imgAry[i] rect:CGRectMake((view.frame.size.width-40)/2,10,40,40) View:view Tag:1];
        
        [LSFUtil labelName:ary[i] fontSize:font14 rect:CGRectMake(0,60, view.frame.size.width, 20) View:view Alignment:1 Color:black Tag:1];
        
        
        [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, view.frame.size.width, 90) title:nil select:@selector(Action:) Tag:i View:view textColor:nil Size:nil background:nil];
        
    }
    
    
    Api * api =[[Api alloc] init:self tag:@"goods_goods"];
    [api goods_jjfwIndex];

    
}
-(void)Action:(UIButton *)btn{

    JZListViewController * list =[[JZListViewController alloc] init];
    list.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:list animated:YES];
}

-(void)hotGoodView{

    UIView * hotView =[LSFUtil viewWithRect:CGRectMake(0,TopScrollHeigt+100, SCREEN_WIDTH, [self getArayToHeight:dataArray]+70+TopScrollHeigt1) view:scr backgroundColor:white];
    
    UILabel * lb =[LSFUtil labelName:nil fontSize:font16 rect:CGRectMake(0, 10, SCREEN_WIDTH, 30) View:hotView Alignment:1 Color:black Tag:1];
    
    [lb setAttributedText:[LSFUtil ButtonAttriSring:@" 热销服务" color:black image:@"lsf77" type:1 rect:CGRectMake(0, -5, 20, 20)]];
    
    
    for(NSInteger i=0;i<dataArray.count;i++){
    
        NSDictionary * dic=dataArray[i];
        
        NSInteger index = i%2;
        NSInteger page = i/2;
        
        @autoreleasepool {
            
        UIView * view=[LSFUtil viewWithRect:CGRectMake((SCREEN_WIDTH/2)*index, page*(SCREEN_WIDTH/2+80)+50, SCREEN_WIDTH/2, SCREEN_WIDTH/2+80) view:hotView backgroundColor:white];
            
        UIImageView * pic =[LSFUtil addSubviewImage:nil rect:CGRectMake(5, 0, view.frame.size.width-10, view.frame.size.width-10) View:view Tag:1];
        NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=good",urlStr,dic[@"url"]];
        [pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"lsf64"]];
            
       UILabel*lb1=[LSFUtil labelName:dic[@"name"] fontSize:font13 rect:CGRectMake(5, view.frame.size.width-10, view.frame.size.width-10, 25) View:view Alignment:1 Color:white Tag:2];
        lb1.backgroundColor=orange;
            
       UILabel*content= [LSFUtil labelName:nil fontSize:font13 rect:CGRectMake(5, view.frame.size.width+15, view.frame.size.width-10, 40) View:view Alignment:0 Color:gray Tag:2];
       [content setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" %@",dic[@"detail"]] color:gray image:@"lsf80" type:1 rect:CGRectMake(0, 0, 20, 12)]];
            
            
     [LSFUtil labelName:[NSString stringWithFormat:@"￥%@",dic[@"price"]] fontSize:font13 rect:CGRectMake(5, view.frame.size.width+55, view.frame.size.width-10, 20) View:view Alignment:0 Color:gray Tag:2];
            
            
    [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) title:nil select:@selector(hotAction:) Tag:i View:view textColor:nil Size:nil background:nil];
        
        }
    }
    
    
    [LSFUtil addSubviewImage:@"lsf78" rect:CGRectMake(0,hotView.frame.size.height-TopScrollHeigt1,SCREEN_WIDTH,TopScrollHeigt1) View:hotView Tag:1];

}

-(void)hotAction:(UIButton*)btn{

    NSDictionary * dic=dataArray[btn.tag];
    
    JZDetailViewController * detail =[[JZDetailViewController alloc] init];
    detail.hidesBottomBarWhenPushed=YES;
    detail.goodsId=dic[@"id"];
    [self.navigationController pushViewController:detail animated:YES];

}


-(void)JDGoodView{
    
    UIView * jdView =[LSFUtil viewWithRect:CGRectMake(0,TopScrollHeigt+100+[self getArayToHeight:dataArray]+90+TopScrollHeigt1, SCREEN_WIDTH, [self getArayToHeight:Jdarray]+70+TopScrollHeigt2) view:scr backgroundColor:white];
    
    
    scr.contentSize=CGSizeMake(0, 10+jdView.frame.size.height+jdView.frame.origin.y);
    
    UILabel * lb =[LSFUtil labelName:nil fontSize:font16 rect:CGRectMake(0, 10, SCREEN_WIDTH, 30) View:jdView Alignment:1 Color:black Tag:1];
    
    [lb setAttributedText:[LSFUtil ButtonAttriSring:@" 家电清洗" color:black image:@"lsf77" type:1 rect:CGRectMake(0, -5, 20, 20)]];
    
    
    for(NSInteger i=0;i<Jdarray.count;i++){
        
        NSDictionary * dic=Jdarray[i];
        
        NSInteger index = i%2;
        NSInteger page = i/2;
        
        @autoreleasepool {
            
            UIView * view=[LSFUtil viewWithRect:CGRectMake((SCREEN_WIDTH/2)*index, page*(SCREEN_WIDTH/2+80)+50, SCREEN_WIDTH/2, SCREEN_WIDTH/2+80) view:jdView backgroundColor:white];
            
            UIImageView * pic =[LSFUtil addSubviewImage:nil rect:CGRectMake(5, 0, view.frame.size.width-10, view.frame.size.width-10) View:view Tag:1];
            NSString* url=[NSString stringWithFormat:@"%@common/showPic.do?filename=%@&filetype=good",urlStr,dic[@"url"]];
            [pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"lsf64"]];
            
            UILabel*lb1=[LSFUtil labelName:dic[@"name"] fontSize:font13 rect:CGRectMake(5, view.frame.size.width-10, view.frame.size.width-10, 25) View:view Alignment:1 Color:white Tag:2];
            lb1.backgroundColor=orange;
            
            UILabel*content= [LSFUtil labelName:nil fontSize:font13 rect:CGRectMake(5, view.frame.size.width+15, view.frame.size.width-10, 40) View:view Alignment:0 Color:gray Tag:2];
            [content setAttributedText:[LSFUtil ButtonAttriSring:[NSString stringWithFormat:@" %@",dic[@"detail"]] color:gray image:@"lsf80" type:1 rect:CGRectMake(0,0, 20, 12)]];
            
            
            [LSFUtil labelName:[NSString stringWithFormat:@"￥%@",dic[@"price"]] fontSize:font13 rect:CGRectMake(5, view.frame.size.width+55, view.frame.size.width-10, 20) View:view Alignment:0 Color:gray Tag:2];
            
            
            [self buttonPhotoAlignment:nil hilPhoto:nil rect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) title:nil select:@selector(JDAction:) Tag:i View:view textColor:nil Size:nil background:nil];

        }
    }
    
    
    [LSFUtil addSubviewImage:@"lsf79" rect:CGRectMake(0,jdView.frame.size.height-TopScrollHeigt2,SCREEN_WIDTH,TopScrollHeigt2) View:jdView Tag:1];
    
}

-(void)JDAction:(UIButton*)btn{


    NSDictionary * dic=Jdarray[btn.tag];
    
    JZDetailViewController * detail =[[JZDetailViewController alloc] init];
    detail.hidesBottomBarWhenPushed=YES;
    detail.goodsId=dic[@"id"];
    [self.navigationController pushViewController:detail animated:YES];
    



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
    
    NSLog(@"%@",response);
    
    if([tag isEqualToString:@"goods_goods"]){
    
        [dataArray removeAllObjects];
        [Jdarray removeAllObjects];
        dataArray=response[@"data"][@"hot"];
        Jdarray=response[@"data"][@"cleaning"];
        [self hotGoodView];
        [self JDGoodView];
    
    }
    else
        if([tag isEqualToString:@"app_user_getTime"]){
            
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

-(CGFloat)getArayToHeight:(NSMutableArray*)ary{

    CGFloat hy=0;
    
    if(ary.count<=2){
    
        hy=(SCREEN_WIDTH/2+80);
        
    }else{
    
        if(ary.count%2==0){
        
            hy=(SCREEN_WIDTH/2+80)*(ary.count/2);
        }
        else{
        
            hy=(SCREEN_WIDTH/2+80)*(ary.count/2+1);
        }
    }

    return hy;
}

@end
